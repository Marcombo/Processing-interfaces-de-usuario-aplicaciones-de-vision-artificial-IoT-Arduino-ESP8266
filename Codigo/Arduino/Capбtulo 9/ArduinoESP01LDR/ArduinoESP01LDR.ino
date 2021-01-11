#include <SoftwareSerial.h>

SoftwareSerial puertoESP01(11, 12); // RX | TX

int pinFotocelula = 0;
int nivelLuz, nivelLuzMapeado;
 
void setup() {
   Serial.begin(115200);
   puertoESP01.begin(115200);
}
 
void loop() {
  nivelLuz = analogRead(pinFotocelula);
  nivelLuzMapeado = map(nivelLuz, 0, 1023, 0, 255);
  Serial.println(nivelLuzMapeado);
  puertoESP01.write(nivelLuzMapeado);
  delay(2000);
}

