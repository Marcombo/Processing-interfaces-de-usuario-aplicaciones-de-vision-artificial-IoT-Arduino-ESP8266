import gab.opencv.*;

OpenCV opencv;
PImage  img, adp;
void setup() {
  img = loadImage("../Imagenes/imagen2.jpg");
  size(800, 300);
  opencv = new OpenCV(this, img);  

  opencv.adaptiveThreshold(751, 1);  
  adp = opencv.getOutput();
}

void draw() {
  scale(0.5);
  image(img, 0, 0);
  image(adp, img.width, 0);
}