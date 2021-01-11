import gab.opencv.*;
import java.awt.Rectangle;

PImage img;
OpenCV opencv;

ArrayList<Contour> contornos;
Rectangle rect;
Contour poligono;
String tipoPoligono;

void setup() {
  img = loadImage("../Imagenes/figurasGeometricas2.png"); 
  size(945, 302);
  opencv = new OpenCV(this, img);
  
  strokeWeight(3);
  textSize(20);
  fill(0);
  textAlign(CENTER, CENTER);
  
  opencv.threshold(70);
  contornos = opencv.findContours();
}

void draw() {
  image(img, 0, 0);
  for (Contour contorno : contornos){
    poligono = contorno.getPolygonApproximation();
    if(poligono.numPoints() == 3) tipoPoligono = "TRIÁNGULO";
    else if(poligono.numPoints() == 4) tipoPoligono = "CUADRADO";
      else tipoPoligono = "CÍRCULO";
        
    rect = contorno.getBoundingBox();
    text(tipoPoligono, rect.x+rect.width/2, rect.y+rect.height/2);
  }
}