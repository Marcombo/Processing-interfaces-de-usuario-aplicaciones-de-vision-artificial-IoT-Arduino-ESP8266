import processing.serial.*;
import cc.arduino.*;

Arduino miArduino;
int fotocelulaPin = 0;
float nivelLuzArduino, nivelLuzProcessing;

void setup()
{
  fullScreen();
  miArduino = new Arduino(this, Arduino.list()[0], 57600);
  miArduino.pinMode(fotocelulaPin, Arduino.INPUT);
  
}

void draw()
{
  nivelLuzArduino = miArduino.analogRead(fotocelulaPin);
  nivelLuzProcessing = 255 - map(nivelLuzArduino, 0, 1023, 0, 255);
  background(nivelLuzProcessing);
}