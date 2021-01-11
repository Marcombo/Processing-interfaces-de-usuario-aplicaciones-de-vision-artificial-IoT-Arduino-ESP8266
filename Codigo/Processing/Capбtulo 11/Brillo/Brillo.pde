import gab.opencv.*;

PImage img;
OpenCV opencv;

int brillo;

void setup(){
  img = loadImage("miImagen.jpg");
  size(800, 600);
  opencv = new OpenCV(this, img, true);   
}

void draw(){
  opencv.loadImage(img);
  if(keyPressed){
    if (key == CODED){
      switch(keyCode){
        case LEFT:  brillo--; break;
        case RIGHT: brillo++; break;
      }
    }
  }
  opencv.brightness(brillo);
  image(opencv.getOutput(),0,0);
}