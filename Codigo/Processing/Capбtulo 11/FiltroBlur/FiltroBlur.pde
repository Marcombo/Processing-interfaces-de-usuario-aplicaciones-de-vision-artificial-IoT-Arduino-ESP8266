import gab.opencv.*;

OpenCV opencv;
PImage  img, blur;
void setup() {
  img = loadImage("../Imagenes/imagen2.jpg");
  size(800, 300);
  opencv = new OpenCV(this, img, true);  

  opencv.blur(12);  
  blur = opencv.getOutput();
}

void draw() {
  scale(0.5);
  image(img, 0, 0);
  image(blur, img.width, 0);
}