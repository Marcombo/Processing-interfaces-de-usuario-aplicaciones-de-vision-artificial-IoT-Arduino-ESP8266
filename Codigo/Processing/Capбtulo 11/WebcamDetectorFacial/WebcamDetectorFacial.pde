import gab.opencv.*;
import java.awt.Rectangle;
import processing.video.*;

Capture camara;
OpenCV opencv;
Rectangle[] caras;
int areaCaraMinima = 1000;

int resolucionX = 320;
int resolucionY = 240;

void setup() {
  opencv = new OpenCV(this, resolucionX, resolucionY);
  size(640, 480);
  opencv.loadCascade(OpenCV.CASCADE_FRONTALFACE); 

  camara = new Capture(this, resolucionX, resolucionY);
  camara.start();
}

void draw() {
  scale(2);
  opencv.loadImage(camara);
  image(camara, 0, 0 );
  
  caras = opencv.detect();
  noFill();
  stroke(0, 255, 0);
  strokeWeight(3);
  for (int i = 0; i < caras.length; i++) {
    if (caras[i].x*caras[i].y > areaCaraMinima) rect(caras[i].x, caras[i].y, caras[i].width, caras[i].height);
  }
}

void captureEvent(Capture c) {
  c.read();
}