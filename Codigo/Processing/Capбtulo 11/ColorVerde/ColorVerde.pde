import gab.opencv.*;

OpenCV opencv;
PImage  img, r, g, b;
void setup() {
  img = loadImage("../Imagenes/circulosDeColores.png");
  size(124, 434);
  opencv = new OpenCV(this, img, true);  
  b = opencv.getSnapshot(opencv.getG());
}

void draw() {
  scale(0.5);
  image(b, 0, 0);
}