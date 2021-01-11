import gab.opencv.*;

OpenCV opencv;
PImage  img, byn;
void setup() {
  img = loadImage("../Imagenes/imagen2.jpg");
  size(800, 300);
  opencv = new OpenCV(this, img, true);  

  opencv.gray();  
  byn = opencv.getOutput();
}

void draw() {
  scale(0.5);
  image(img, 0, 0);
  image(byn, img.width, 0);
}