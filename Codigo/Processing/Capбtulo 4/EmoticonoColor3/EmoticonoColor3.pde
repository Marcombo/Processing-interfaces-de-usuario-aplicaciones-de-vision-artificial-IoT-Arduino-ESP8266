int x, y, tamanioEmoticono;

void setup(){
  size(600, 600);
  background(255);
  tamanioEmoticono = 400;
  x = width/2;
  y = height/2;
}

void draw(){
  strokeWeight(1);
  fill(255, 255, 0);
  ellipse(x, y, tamanioEmoticono, tamanioEmoticono);
  fill(0);
  ellipse(x-70, y-70, 50, 70);
  ellipse(x+70, y-70, 50, 70);
  ellipse(x, y+60, 200, 15);
}