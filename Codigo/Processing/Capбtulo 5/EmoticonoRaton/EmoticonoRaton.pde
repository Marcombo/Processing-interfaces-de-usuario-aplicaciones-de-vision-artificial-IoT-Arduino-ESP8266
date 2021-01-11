int tamanioEmoticono, posicionX, posicionY, offsetX, offsetY;

void setup(){
  size(1000, 600);
  tamanioEmoticono = 400;
  posicionX = width/2;
  posicionY = height/2;
}

void draw(){
  background(255);
  if(mousePressed && dentroEmoticono(posicionX, posicionY)){
    posicionX = mouseX - offsetX;
    posicionY = mouseY - offsetY;
  }
  pintaEmoticono(posicionX, posicionY);
}

void mousePressed(){
  offsetX = mouseX - posicionX;
  offsetY = mouseY - posicionY;
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

boolean dentroEmoticono(int x, int y){
  float disX = x - mouseX;
  float disY = y - mouseY;
  if (sqrt(sq(disX) + sq(disY)) < tamanioEmoticono/2 ) {
    return true;
  } else {
    return false;
  }
}