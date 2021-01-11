import gab.opencv.*;

OpenCV opencv;

void setup() {
  opencv = new OpenCV(this, "imagen1.jpg", true);
  size(800, 600);
}

void draw() {
  image(opencv.getOutput(), 0, 0);
}