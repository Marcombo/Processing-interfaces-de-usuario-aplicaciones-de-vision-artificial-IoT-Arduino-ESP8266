#include <ESP8266WiFi.h>
 
const char* ssid = "*************";             // SSID de la red WIFI a la que desea conectarse
const char* password = "*******************";  // contraseña de dicha red

IPAddress ip(192, 168, 1, 99);      //dirección IP elegida dentro de la red
IPAddress gateway(192, 168, 1, 1);  //dirección IP del gateway
IPAddress subnet(255, 255, 255, 0); //máscara de red
 
WiFiServer servidorWeb(80);

String nivelLuz="";
int nivelLuzInt;
 
void setup() {
  Serial.begin(115200);

  pinMode(13, OUTPUT);

  //Inicializa la conexión WIFI  
  WiFi.config(ip, gateway, subnet);  
  WiFi.begin(ssid, password);
  while (WiFi.status() != WL_CONNECTED)
  {
    delay(500);
  }

  //arrancamos el servidor Web
  servidorWeb.begin();
}

void loop() {
  //Comprueba si hay algún cliente conectado
  WiFiClient clienteWeb = servidorWeb.available();
  if (!clienteWeb) return;

  //Espera a que el cliente envíe la petición
  while(!clienteWeb.available()) delay(5);
 
  // Lee la petición del cliente
  String peticion = clienteWeb.readStringUntil('\n');
  clienteWeb.flush();
  
  //Obtiene el botón pulsado
  if (peticion.indexOf("nivelLuz=") != -1) nivelLuz = peticion.substring(peticion.indexOf("nivelLuz=")+9,peticion.length());

  nivelLuzInt = nivelLuz.toInt();
  Serial.write(nivelLuzInt);
 
  delay(100);
}
