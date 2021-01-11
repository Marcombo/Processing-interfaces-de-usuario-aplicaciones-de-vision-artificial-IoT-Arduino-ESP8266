import gab.opencv.*;
import java.awt.Rectangle;

PImage img;
OpenCV opencv;

ArrayList<Contour> contornos;
Rectangle rect;
String tipoTaco="";

float AREA_MINIMA = 1000;
float AREA_MAXIMA = 10000;
float AREA9 = 5000;
float AREA6 = 1000;
int numeroTacos6, numeroTacos9;

void setup() {

  img = loadImage("../Imagenes/tacos1.jpg"); 
  size(436, 245);
  opencv = new OpenCV(this, img);
  
  strokeWeight(2);
  textSize(12);

  opencv.threshold(80);
  contornos = opencv.findContours();
}

void draw() {
  numeroTacos6 = 0;
  numeroTacos9 = 0;
  image(img, 0, 0);
  for (Contour contorno : contornos){
    if(contorno.area() > AREA_MINIMA && contorno.area() < AREA_MAXIMA){
      if(contorno.area() > AREA9){
        tipoTaco = "Nº9";
        numeroTacos9++;
      }
      else if(contorno.area() > AREA6){
        tipoTaco = "Nº6";
        numeroTacos6++;
      }
      
      rect = contorno.getBoundingBox();

      fill(0, 0, 255);
      textAlign(CENTER, CENTER);
      text(tipoTaco, rect.x+rect.width/2, rect.y+rect.height/2);
    }
  }
  textAlign(LEFT);
  fill(255);
  text("Número de tacos del Nº 9: "+str(numeroTacos9), 10, 20);
  text("Número de tacos del Nº 6: "+str(numeroTacos6), 10, 40);
}