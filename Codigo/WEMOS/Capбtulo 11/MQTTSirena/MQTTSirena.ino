#include <ESP8266WiFi.h>
#include <PubSubClient.h>

const char* ssid = "*************";             // SSID de la red WIFI a la que desea conectarse
const char* password = "*******************";  // contraseña de dicha red

const char* mqtt_server = "test.mosquitto.org";
const char* tema = "marcombo_alarma_movimiento";
WiFiClient clienteWIFI;
PubSubClient clienteMQTT(clienteWIFI);

int pinRele = 13; 
int pinPulsador = 12;

boolean releActivado = false;

void setup() {
  pinMode(pinPulsador, INPUT);
  pinMode(pinRele, OUTPUT);
  digitalWrite(pinRele, LOW);
  
  Serial.begin(115200);

  //Inicializamos la conexión WIFI
  Serial.print("Conectando a " + String(ssid) + " ");     
  WiFi.begin(ssid, password);
  while (WiFi.status() != WL_CONNECTED)
  {
    delay(500);
    Serial.print(".");
  }
  Serial.println(" Conectado");

  //Establecerá el broker que utilizará
  clienteMQTT.setServer(mqtt_server, 1883);
  //Establecerá la función a la que se va a llamar cuando llegue un mensaje del broker
  clienteMQTT.setCallback(callback);
}

void callback(char* tema, byte* contenido, unsigned int longitudContenido) {
  String mensaje = "";
  Serial.print("Ha llegado un mensaje con el tema: ");
  Serial.print(tema);
  Serial.print(" y el contenido: ");
  for (int i = 0; i < longitudContenido; i++) {
    mensaje = mensaje + (char)contenido[i];
    Serial.print((char)contenido[i]);
  }
  Serial.println();
  //Activa o desactiva el rele
  if (mensaje == "ON"){
    digitalWrite(pinRele, HIGH);
    releActivado = true;
  }
  else if (mensaje == "OFF"){
    digitalWrite(pinRele, LOW); 
    releActivado = false;
  }
}

void loop() {
  //Si se presiona el pulsador se desactiva el relé
  if(digitalRead(pinPulsador) && releActivado){
    digitalWrite(pinRele, LOW);
    clienteMQTT.publish(tema, "OFF");
    releActivado = false;
  }
  
  //Establecerá la conexión con el broker 
  while (!clienteMQTT.connected()) {
      Serial.print("Conectando al broker ...");
      if (clienteMQTT.connect("wemos")) {
        Serial.println("Conectado al broker.");
        clienteMQTT.subscribe(tema);
      } else {
        delay(5000);
      }
  }
  // Cliente escuchando
  clienteMQTT.loop();
}
