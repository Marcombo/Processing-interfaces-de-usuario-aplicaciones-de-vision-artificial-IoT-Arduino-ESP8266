int x, y, tamanioEmoticono;
int xTranslate;
int incremento = 1;

void setup(){
  size(600, 600);
  tamanioEmoticono = 400;
  x = width/2;
  y = height/2;
  textAlign(CENTER, CENTER);
  textSize(30);
}

void draw(){
  background(255);
  text("¡SONRÍE! ES GRATIS", width/2+xTranslate, width-50);
  strokeWeight(1);
  fill(255, 255, 0);
  ellipse(x+xTranslate, y, tamanioEmoticono, tamanioEmoticono);
  fill(0);
  ellipse(x+xTranslate-70, y-70, 50, 70);
  ellipse(x+xTranslate+70, y-70, 50, 70);
  noFill();
  strokeWeight(10);
  arc(x+xTranslate, y+60, 200, 150, 0, PI);
  
  if(xTranslate + width/2 > width - tamanioEmoticono/2) incremento = -1;
  if(xTranslate + width/2 < tamanioEmoticono/2) incremento = 1;
  xTranslate +=incremento;
}