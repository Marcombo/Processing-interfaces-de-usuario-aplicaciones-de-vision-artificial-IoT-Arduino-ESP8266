#include <ESP8266WiFi.h>
#include <PubSubClient.h>

const char* ssid = "**************";             // SSID de la red WIFI a la que desea conectarse
const char* password = "********************";  // contraseña de dicha red

const char* mqtt_server = "test.mosquitto.org";
const char* tema = "marcombo_pir";
WiFiClient clienteWIFI;
PubSubClient clienteMQTT(clienteWIFI);

int pinPIR = 13; 
boolean estadoAlarma = false;
boolean alarmaRearmada = true;

void setup() {
  pinMode(pinPIR, INPUT);
  
  Serial.begin(115200);

  //Inicializa la conexión WIFI
  Serial.print("Conectando a " + String(ssid) + " ");     
  WiFi.begin(ssid, password);
  while (WiFi.status() != WL_CONNECTED)
  {
    delay(500);
    Serial.print(".");
  }
  Serial.println(" Conectado");

  //Establecerá el broker que utilizaremos
  clienteMQTT.setServer(mqtt_server, 1883);
}

void loop() {
  //Establecerá la conexión con el broker 
  while (!clienteMQTT.connected()) {
      Serial.print("Conectando al broker ...");
      if (clienteMQTT.connect("wemos")) {
        Serial.println("Conectado al broker.");
      } else {
        delay(5000);
      }
  }
  if (digitalRead(pinPIR) == HIGH){
      estadoAlarma = true;
      if(alarmaRearmada){
        alarmaRearmada = false;
        Serial.println("Alarma activada");
        clienteMQTT.publish(tema, "ON");
      }
  }
  else if(estadoAlarma){
    estadoAlarma = false;
    alarmaRearmada = true;
    Serial.println("Alarma desactivada");
    clienteMQTT.publish(tema, "OFF");
  }
  // Cliente escuchando
  clienteMQTT.loop();
  delay(100);
}

