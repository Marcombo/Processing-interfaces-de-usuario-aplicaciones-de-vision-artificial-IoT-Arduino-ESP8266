void setup() {
  size(300, 600);
}

void draw() {
  rectMode(CORNERS);
  //rectángulo
  fill(150);
  rect(50, 100, 250, 525);
  
  //Círculo rojo
  fill(255, 0, 0);
  ellipse(width/2, 175, 100, 100);
  
  //Círculo amarillo
  fill(255, 255, 0);
  ellipse(width/2, 300, 100, 100);
  
  //Círculo verde
  fill(0, 255, 0);
  ellipse(width/2, 425, 100, 100);
}