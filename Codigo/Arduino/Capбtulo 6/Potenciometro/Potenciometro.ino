int PinPotenciometro = A1;
int valor;
 
void setup() {
  Serial.begin(115200);
}
 
void loop() {
   valor = analogRead(PinPotenciometro);
   Serial.println(valor);
   delay(10);
}
