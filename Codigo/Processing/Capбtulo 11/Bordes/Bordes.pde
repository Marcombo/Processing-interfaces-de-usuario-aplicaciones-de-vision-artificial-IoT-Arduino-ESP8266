import gab.opencv.*;

OpenCV opencv;
PImage src, canny;

void setup() {
  src = loadImage("../Imagenes/figurasGeometricas.png");
  size(567, 200);
  
  opencv = new OpenCV(this, src);
  opencv.findCannyEdges(20,60);
  canny = opencv.getSnapshot();
}

void draw() {
  scale(0.5);
  image(src, 0, 0);
  image(canny, src.width, 0);
}