import gab.opencv.*;
import java.awt.Rectangle;
import processing.video.*;

Capture camara;
OpenCV opencv;
Rectangle[] caras;
int areaCaraMinima = 1000;

PImage sombrero;
float relacionAspectosombrero;
float tallasombrero = 1.4;
int anchoSombrero, altoSombrero;

int resolucionX = 320;
int resolucionY = 240;

void setup() {
  sombrero = loadImage("../Imagenes/sombrero.png");
  relacionAspectosombrero = sombrero.width/sombrero.height;
  
  opencv = new OpenCV(this, resolucionX, resolucionY);
  opencv.loadCascade(OpenCV.CASCADE_FRONTALFACE); 
  size(640, 480);
  
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
  sombrero = loadImage("../Imagenes/sombrero.png");
  for (int i = 0; i < caras.length; i++) {
    if (caras[i].x*caras[i].y > areaCaraMinima){
      anchoSombrero = (int)(caras[i].width*tallasombrero);
      altoSombrero = (int)(anchoSombrero/relacionAspectosombrero);
      sombrero.resize(anchoSombrero, altoSombrero);
      image(sombrero, caras[i].x + caras[i].width/2 - anchoSombrero/2, caras[i].y - altoSombrero);
    }
  }
}

void captureEvent(Capture c) {
  c.read();
}