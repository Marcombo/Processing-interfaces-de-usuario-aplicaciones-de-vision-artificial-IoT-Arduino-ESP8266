import gab.opencv.*;

OpenCV opencv;
PImage  img, dilated;

void setup() {
  background(255);
  img = loadImage("../Imagenes/emoticono.png");
  size(760, 349);
  opencv = new OpenCV(this, img);  

  //opencv.gray(); 
  img = opencv.getSnapshot();
  opencv.dilate();
  dilated = opencv.getSnapshot();
}

void draw() {
  image(img, 0, 0);
  image(dilated, img.width, 0);
}