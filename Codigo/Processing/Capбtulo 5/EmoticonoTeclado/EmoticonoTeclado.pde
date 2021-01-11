int tamanioEmoticono, posicionX, posicionY;

void setup(){
  size(1000, 600);
  tamanioEmoticono = 400;
  posicionX = width/2;
  posicionY = height/2;
}

void draw(){
  background(255);
  if(keyPressed){
    if (key == CODED){
      switch(keyCode){
        case UP: if(posicionY > tamanioEmoticono/2) posicionY--; break;
        case DOWN: if(posicionY + tamanioEmoticono/2 < height) posicionY++; break;
        case LEFT:  if(posicionX > tamanioEmoticono/2) posicionX--; break;
        case RIGHT: if(posicionX + tamanioEmoticono/2 < width) posicionX++; break;
      }
    }
  }
  pintaEmoticono(posicionX, posicionY);
}

void pintaEmoticono(int x, int y){
  strokeWeight(1);
  fill(255, 255, 0);
  ellipse(x, y, tamanioEmoticono, tamanioEmoticono);
  fill(0);
  ellipse(x-70, y-70, 50, 70);
  ellipse(x+70, y-70, 50, 70);
  noFill();
  strokeWeight(10);
  arc(x, y+60, 200, 150, 0, PI);
}