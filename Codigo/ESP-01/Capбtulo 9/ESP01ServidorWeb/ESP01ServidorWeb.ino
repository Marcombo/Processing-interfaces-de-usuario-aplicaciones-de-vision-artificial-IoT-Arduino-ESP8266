#include <ESP8266WiFi.h>
 
const char* ssid = "*************";             // SSID de la red WIFI a la que desea conectarse
const char* password = "********************";  // contraseña de dicha red

IPAddress ip(192, 168, 1, 99);      //dirección IP elegida dentro de la red
IPAddress gateway(192, 168, 1, 1);  //dirección IP del gateway
IPAddress subnet(255, 255, 255, 0); //mascara de red
 
WiFiServer servidorWeb(80);
 
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

  //Arranca el servidor web
  servidorWeb.begin();
  Serial.println("Servidor web arrancado");
}
 
void loop() {
  //Comprueba si hay algún cliente conectado
  WiFiClient clienteWeb = servidorWeb.available();
  if (!clienteWeb) return;

  Serial.println("Nuevo cliente");
  //Espera a que el cliente envíe la petición
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
  clienteWeb.println("<title>Servidor Web ESP8266</title>");
  clienteWeb.println("</head>");
  clienteWeb.println("<html>");
  clienteWeb.println("<body>");
  clienteWeb.println("<h1>Bienvenido al servidor Web de mi ESP8266</h1>");
  clienteWeb.println("</body>");
  clienteWeb.println("</html>");
 
  delay(5);
  Serial.println("Cliente desconectado");
}
