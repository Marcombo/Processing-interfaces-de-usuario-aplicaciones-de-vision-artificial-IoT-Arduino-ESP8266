import gab.opencv.*;
import java.awt.Rectangle;

OpenCV opencv;
Rectangle[] caras;

void setup() {
  opencv = new OpenCV(this, "../Imagenes/Einstein.jpg");
  size(384, 512);

  opencv.loadCascade(OpenCV.CASCADE_FRONTALFACE);  
  caras = opencv.detect();
}

void draw() {
  image(opencv.getInput(), 0, 0);

  noFill();
  stroke(0, 255, 0);
  strokeWeight(3);
  for (int i = 0; i < caras.length; i++) {
    rect(caras[i].x, caras[i].y, caras[i].width, caras[i].height);
  }
}