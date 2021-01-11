const int analogPin = A0;
 
void setup() {
  //Setup serial connection
  Serial.begin(115200); 
}
 
void loop() {
  //Read analog pin
  int val = analogRead(analogPin);
  Serial.println(val);
}
