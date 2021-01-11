void setup() {
  size(400,400,P3D);
  background(255);
  noStroke();
  fill(124);
}

void draw() {
  lights();
  translate(width/2, height/2, 0);
  rotateX(-0.4);
  box(150);
}