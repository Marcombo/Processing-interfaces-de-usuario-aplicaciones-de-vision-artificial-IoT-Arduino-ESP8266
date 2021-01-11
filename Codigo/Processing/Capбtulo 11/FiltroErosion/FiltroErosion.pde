import gab.opencv.*;

OpenCV opencv;
PImage  img, eroded;

void setup() {
  background(255);
  img = loadImage("../Imagenes/emoticono.png");
  size(760, 349);
  opencv = new OpenCV(this, img);  

  //opencv.gray(); 
  img = opencv.getSnapshot();
  opencv.erode();
  eroded = opencv.getSnapshot();
}

void draw() {
  image(img, 0, 0);
  image(eroded, img.width, 0);
}