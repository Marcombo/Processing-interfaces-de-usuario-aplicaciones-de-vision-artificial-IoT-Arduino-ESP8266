import gab.opencv.*;

OpenCV opencv;
PImage  referencia, actual, diferencia;

void setup() {
  referencia = loadImage("./wikipedia/wikipedia0.gif");
  actual = loadImage("./wikipedia/wikipedia3.gif");
  size(783, 300);

  opencv = new OpenCV(this, referencia);    

  opencv.diff(actual);
  opencv.threshold(70);
  
  diferencia = opencv.getOutput(); 
}

void draw() {
  scale(0.5);
  image(referencia, 0, 0);
  image(actual, referencia.width, 0);
  image(diferencia, referencia.width*2, 0);
}