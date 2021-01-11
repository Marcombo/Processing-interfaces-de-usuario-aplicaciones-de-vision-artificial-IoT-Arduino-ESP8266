PImage miImagen;

void setup() {
  miImagen = loadImage("imagen1.jpg");
  size(800, 600);
}

void draw() {
  image(miImagen, 0, 0);
}