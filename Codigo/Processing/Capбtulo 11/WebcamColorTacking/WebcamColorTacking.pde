import gab.opencv.*;
import processing.video.*;

Capture camara;
OpenCV opencv;

color colorObjetivo; 
int posicionXColor, posicionYColor; 
int distanciaMaximaAceptable = 10; 
float distanciaMaximaPosible = dist(0, 0, 0, 255, 255, 255);
float distanciaMinimaObservada = distanciaMaximaPosible;

void setup() {
  opencv = new OpenCV(this, 640, 480);
  size(640, 480); 

  camara = new Capture(this, 640, 480);
  camara.start();

  stroke(255, 0, 0);
  fill(255, 0, 0);
  
  colorObjetivo = color(255, 255, 255);
}

void draw() {
  camara.loadPixels();
  image(camara, 0, 0);

  distanciaMinimaObservada = distanciaMaximaPosible; 
  posicionXColor = 0;
  posicionYColor = 0;

  for (int x = 0; x < camara.width; x ++ ) {
    for (int y = 0; y < camara.height; y ++ ) {
      color colorPixel = camara.pixels[x + y*camara.width];
      
      float r1 = red(colorPixel);
      float g1 = green(colorPixel);
      float b1 = blue(colorPixel);
      float r2 = red(colorObjetivo);
      float g2 = green(colorObjetivo);
      float b2 = blue(colorObjetivo);

      float distancia = dist(r1, g1, b1, r2, g2, b2);

      if (distancia < distanciaMinimaObservada) {
        distanciaMinimaObservada = distancia;
        posicionXColor = x;
        posicionYColor = y;
      }
    }
  }

  if (distanciaMinimaObservada < distanciaMaximaAceptable) { 
    ellipse(posicionXColor, posicionYColor, 20, 20);
  }
}

void mousePressed() {
  colorObjetivo = camara.pixels[mouseX + mouseY*camara.width];
}

void captureEvent(Capture camara){ 
  camara.read();
}