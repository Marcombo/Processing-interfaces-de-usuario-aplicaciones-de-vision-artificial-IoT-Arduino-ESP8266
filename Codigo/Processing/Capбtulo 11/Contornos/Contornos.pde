import gab.opencv.*;

PImage origen, destino;
OpenCV opencv;

ArrayList<Contour> contornos;

void setup() {
  origen = loadImage("../Imagenes/figurasGeometricas2.png"); 
  size(945, 302);
  opencv = new OpenCV(this, origen);
  
  noFill();
  strokeWeight(3);
  stroke(0, 255, 0);

  opencv.threshold(70);

  contornos = opencv.findContours();
}

void draw() {
  image(origen, 0, 0);
  for (Contour contorno : contornos) {
    contorno.draw();
  }
}