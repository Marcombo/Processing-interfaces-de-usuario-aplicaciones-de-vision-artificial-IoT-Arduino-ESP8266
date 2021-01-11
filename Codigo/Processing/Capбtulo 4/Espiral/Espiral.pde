void setup() {
  size(500, 400);
}

void draw() {
  translate(width/2, height/2);
  //scale(6);
  for (int i = 0; i < 100; i++){
    rotate(0.1);
    point(i, 0);
  }
}