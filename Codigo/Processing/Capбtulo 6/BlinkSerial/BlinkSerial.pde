import processing.serial.*;

Serial puerto; 

void setup() 
{
  String nombrePuerto  = Serial.list()[0];
  puerto = new Serial(this, nombrePuerto, 9600);
}
void draw() {
  puerto.write('1');

  delay(1000);
  puerto.write('0');

  delay(1000);
}