import gab.opencv.*;

OpenCV opencv;
PImage  img, thresold, dilated;

void setup() {
  background(255);
  img = loadImage("../Imagenes/emoticono2.png");
  size(1140, 349);
  opencv = new OpenCV(this, img);  

  img = opencv.getSnapshot();
  opencv.threshold(75);
  thresold = opencv.getSnapshot();
  opencv.dilate();
  dilated = opencv.getSnapshot();
}

void draw() {
  image(img, 0, 0);
  image(thresold, img.width, 0);
  image(dilated, img.width*2, 0);
}