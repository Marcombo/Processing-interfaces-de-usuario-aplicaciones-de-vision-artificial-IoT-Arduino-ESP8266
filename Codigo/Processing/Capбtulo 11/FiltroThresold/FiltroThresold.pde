import gab.opencv.*;

OpenCV opencv;
PImage  img, thresh;
void setup() {
  img = loadImage("../Imagenes/hoja.jpg");
  size(450, 169);
  opencv = new OpenCV(this, img);  

  opencv.threshold(175);  
  thresh = opencv.getOutput();
}

void draw() {
  image(img, 0, 0);
  image(thresh, img.width, 0);
}