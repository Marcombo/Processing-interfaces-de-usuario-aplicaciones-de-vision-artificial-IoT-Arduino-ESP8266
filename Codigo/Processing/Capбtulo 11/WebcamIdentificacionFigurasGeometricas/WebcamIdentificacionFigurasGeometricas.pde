import gab.opencv.*;
import java.awt.Rectangle;
import processing.video.*;

Capture camara;
OpenCV opencv;

ArrayList<Contour> contornos;
Rectangle rect;
Contour poligono;
String tipoPoligono = "";

float areaContorno;
int AreaContornoMinimo = 20000;
int AreaContornoMaximo = 80000;

void setup() {
  size(640, 480);
  opencv = new OpenCV(this, 640, 480);
    
  camara = new Capture(this, 640, 480);
  camara.start();
  
  strokeWeight(3);
  fill(255);
  textAlign(CENTER, CENTER);
}

void draw() {
  opencv.loadImage(camara);
  image(camara, 0, 0 );
  
  opencv.threshold(100);
  contornos = opencv.findContours();
  
  for (Contour contorno : contornos){
    areaContorno = contorno.area();
    if (areaContorno > AreaContornoMinimo && areaContorno < AreaContornoMaximo){
      poligono = contorno.getPolygonApproximation();
      if(poligono.numPoints() == 3) tipoPoligono = "TRIÁNGULO";
      else if(poligono.numPoints() == 4) tipoPoligono = "CUADRADO";
        else if(poligono.numPoints() == 5) tipoPoligono = "PENTÁGONO";
          
      rect = contorno.getBoundingBox();
      textSize(int(areaContorno/2500));
      text(tipoPoligono, rect.x+rect.width/2, rect.y+rect.height/2);
    }
  }
}

void captureEvent(Capture c) {
  c.read();
}