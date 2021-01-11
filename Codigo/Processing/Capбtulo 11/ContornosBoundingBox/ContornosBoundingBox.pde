import gab.opencv.*;
import java.awt.Rectangle;

PImage img;
OpenCV opencv;

ArrayList<Contour> contornos;
Rectangle rect;

void setup() {
  img = loadImage("../Imagenes/figurasGeometricas2.png"); 
  size(945, 302);
  opencv = new OpenCV(this, img);
  
  noFill();
  strokeWeight(3);
  stroke(0, 255, 0);
  
  opencv.threshold(70);
  contornos = opencv.findContours();
}

void draw() {
  image(img, 0, 0);
  for (Contour contorno : contornos){
    rect = contorno.getBoundingBox();
    rect(rect.x, rect.y, rect.width, rect.height);
  }
}