import gab.opencv.*;

OpenCV opencv;

Histogram histograma;
PImage img;

void setup() {
  size(800, 300);
  img = loadImage("../Imagenes/imagen4.jpg");
  opencv = new OpenCV(this, img);

  histograma = opencv.findHistogram(opencv.getGray(), 256);
}

void draw() {
  background(255);
  scale(0.5);
  image(img, 0, 0);

  histograma.draw(800, 0, img.width, img.height);
}