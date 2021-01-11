import gab.opencv.*;

OpenCV opencv;
PImage  imagen1, imagen2, diferencia;

void setup() {
  imagen1 = loadImage("../Imagenes/wikipedia/wikipedia0.gif");
  imagen2 = loadImage("../Imagenes/wikipedia/wikipedia3.gif");
  size(783, 300);

  opencv = new OpenCV(this, imagen1);    

  opencv.diff(imagen2);
  opencv.threshold(70);
  
  diferencia = opencv.getOutput(); 
}

void draw() {
  scale(0.5);
  image(imagen1, 0, 0);
  image(imagen2, imagen1.width, 0);
  image(diferencia, imagen1.width*2, 0);
}