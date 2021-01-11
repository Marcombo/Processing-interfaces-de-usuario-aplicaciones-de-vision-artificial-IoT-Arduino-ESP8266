import processing.serial.*;
import gab.opencv.*;
import processing.video.*;

Serial puerto; 
Capture camara;
OpenCV opencv;

color colorPelota1, colorPelota2; 
int posicionXColor, posicionYColor; 
int distanciaMaximaAceptable = 10; 
float distanciaMaximaPosible = dist(0, 0, 0, 255, 255, 255);
float distanciaMinimaObservada = distanciaMaximaPosible;

void setup() {
  String nombrePuerto  = Serial.list()[0];
  puerto = new Serial(this, nombrePuerto, 115200);
  
  opencv = new OpenCV(this, 640, 480);
  size(640, 480); 

  camara = new Capture(this, 640, 480);
  camara.start();

  stroke(255, 0, 0);
  fill(255, 0, 0);
  
  colorPelota1 = color(255, 255, 255);
  colorPelota2 = color(0, 0, 255);
}

void draw() {
  camara.loadPixels();
  image(camara, 0, 0);

  distanciaMinima(colorPelota2);
  if (distanciaMinimaObservada < distanciaMaximaAceptable) { 
    ellipse(posicionXColor, posicionYColor, 20, 20);
    mueveServo(135);
  }
  else{
    distanciaMinima(colorPelota1);
    if (distanciaMinimaObservada < distanciaMaximaAceptable) { 
      ellipse(posicionXColor, posicionYColor, 20, 20);
      mueveServo(45);
    }
    else{
      mueveServo(90);
    }
  }
}

void distanciaMinima(color colorObjetivo){
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
}

void mueveServo(int angulo){
    puerto.write("CONECTA=X\n");
    puerto.write("SERVO_X" + "=" + angulo + "\n");
    puerto.write("DESCONECTA=X\n");
}

void mousePressed() {
  if(mouseButton == LEFT) colorPelota1 = camara.pixels[mouseX + mouseY*camara.width];
  if(mouseButton == RIGHT) colorPelota2 = camara.pixels[mouseX + mouseY*camara.width];
}

void captureEvent(Capture camara){ 
  camara.read();
}