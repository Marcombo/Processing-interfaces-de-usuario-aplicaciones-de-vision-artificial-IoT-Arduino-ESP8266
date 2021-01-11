import gab.opencv.*;

OpenCV opencv;
PImage  img, r, g, b;
void setup() {
  img = loadImage("../Imagenes/imagen2.jpg");
  size(1200, 300);
  opencv = new OpenCV(this, img, true);  
 
  r = opencv.getSnapshot(opencv.getR());
  g = opencv.getSnapshot(opencv.getG());
  b = opencv.getSnapshot(opencv.getB());
}

void draw() {
  scale(0.5);
  image(r, 0, 0);
  image(g, img.width, 0);
  image(b, img.width*2, 0);
}