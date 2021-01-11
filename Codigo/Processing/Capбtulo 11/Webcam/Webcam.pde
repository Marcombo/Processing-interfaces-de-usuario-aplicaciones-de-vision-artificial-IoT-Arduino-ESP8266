import gab.opencv.*;
import processing.video.*;

Capture camara;
OpenCV opencv;

void setup() {
  size(640, 480);
  opencv = new OpenCV(this, 640, 480);
    
  camara = new Capture(this, 640, 480);
  camara.start();
}

void draw() {
  opencv.loadImage(camara);
  image(camara, 0, 0 );
}

void mouseClicked(){
  saveFrame("foto.png");
}

void captureEvent(Capture c) {
  c.read();
}
