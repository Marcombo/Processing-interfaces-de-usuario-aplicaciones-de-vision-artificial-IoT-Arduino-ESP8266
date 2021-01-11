#include <ESP8266WiFi.h>
 
const char* ssid = "**************";             // SSID de la red WIFI a la que desea conectarse
const char* password = "********************";  // contraseña de dicha red

IPAddress ip(192, 168, 1, 99);      //dirección IP elegida dentro de la red
IPAddress gateway(192, 168, 1, 1);  //dirección IP del gateway
IPAddress subnet(255, 255, 255, 0); //máscara de red
 
WiFiServer servidorWeb(80);

String nivelLuz = "0";
 
void setup() {
  Serial.begin(115200);

  //Inicializa la conexión WiFI
  Serial.print("Conectando a " + String(ssid) + " ");   
  WiFi.config(ip, gateway, subnet);  
  WiFi.begin(ssid, password);
  while (WiFi.status() != WL_CONNECTED)
  {
    delay(500);
    Serial.print(".");
  }
  Serial.println(" Conectado");

  //Arranca el servidor Web
  servidorWeb.begin();
  Serial.println("Servidor web arrancado");
}

void loop() {
  //Obtiene el nivel de luz de Arduino
  if (Serial.available() > 0)  nivelLuz = Serial.read(); 
  
  //Comprueba si hay algún cliente conectado
  WiFiClient clienteWeb = servidorWeb.available();
  if (!clienteWeb) return;

  Serial.println("Nuevo cliente");
  //espero a que el cliente envíe la petición
  while(!clienteWeb.available()) delay(5);
 
  // Lee la petición del cliente
  String peticion = clienteWeb.readStringUntil('\n');
  Serial.println(peticion); 
  clienteWeb.flush();
    
 //Devuelve una página web como respuesta
  clienteWeb.println("HTTP/1.1 200 OK");
  clienteWeb.println("Content-Type: text/html");
  clienteWeb.println("Connection: close");
  clienteWeb.println("");
  clienteWeb.println("<!DOCTYPE HTML>");
  clienteWeb.println("<head>");
  clienteWeb.println("<meta charset='UTF-8'>");
  clienteWeb.println("<META HTTP-EQUIV='REFRESH' CONTENT='2'>");
  clienteWeb.println("<title>Nivel de luz ESP01-Arduino</title>");
  clienteWeb.println("</head>");
  clienteWeb.println("<html>");
  clienteWeb.println("<body style='background-color:rgb("+nivelLuz+","+nivelLuz+","+nivelLuz+");'>");
  clienteWeb.println("</body>");
  clienteWeb.println("</html>");

  delay(5);
  Serial.println("Cliente desconectado");
}
