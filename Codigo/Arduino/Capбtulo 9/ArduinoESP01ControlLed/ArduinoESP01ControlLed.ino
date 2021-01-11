#include <SoftwareSerial.h>

SoftwareSerial puertoESP01(11, 12); // RX | TX

int pinLed = 3;
int nivelLuz;
 
void setup() {
   Serial.begin(115200);
   puertoESP01.begin(115200);

   pinMode(pinLed, OUTPUT);
}
 
void loop() {
  //Obtengo el nivel de luz de ESP01
  if (puertoESP01.available() > 0){
    nivelLuz = puertoESP01.read(); 
    Serial.println(nivelLuz);
    analogWrite(pinLed, nivelLuz);
  }
  delay(100);
}

