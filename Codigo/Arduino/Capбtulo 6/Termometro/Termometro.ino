#include <SimpleDHT.h>

int pinDHT11 = 2;
SimpleDHT11 dht11;
 
void setup() {
   Serial.begin(9600);
}
 
void loop() {
  byte temperatura = 0;
  byte humedad = 0;
  dht11.read(pinDHT11, &temperatura, &humedad, NULL);
  if (!isnan(temperatura)) Serial.println((int)temperatura);
  delay(1000);
}
