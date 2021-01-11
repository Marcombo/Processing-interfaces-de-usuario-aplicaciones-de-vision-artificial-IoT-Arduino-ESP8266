import gab.opencv.*;

OpenCV opencv;
PImage  img, pasoBajo, pasoAlto;

void setup() {
  img = loadImage("../Imagenes/imagen7.jpg");
  size(800, 300);
  opencv = new OpenCV(this, img);  

  opencv.blur(6);  
  pasoBajo = opencv.getOutput();
  opencv = new OpenCV(this, img); 
  opencv.diff(img);
  pasoAlto = opencv.getOutput();
}

void draw() {
  scale(0.5);
  image(img, 0, 0);
  image(pasoAlto, img.width, 0);
}