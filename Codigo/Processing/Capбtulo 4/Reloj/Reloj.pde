void setup() {
  size(275, 275);
}

void draw() {
  background(255);

  //lleva los de ejes de coordenanas al centro de la pantalla
  translate(width / 2, height / 2);
  
  // dibujará el marco del reloj
  strokeWeight(4);
  stroke(0, 0, 255);
  fill(0, 0, 255);
  ellipse(0, 0, 250, 250);
  fill(255);
  ellipse(0, 0, 200, 200);
  
  stroke(0);
  
  // seconds
  strokeWeight(1);
  // ángulo que se mueve la aguja del segundero cada segundo
  float anguloSegundos = 360 / 60 * second();
  //dibujará la aguja que marca los segundos
  pushMatrix();
  rotate(radians(anguloSegundos));
  line(0, 0, 0, -95);
  popMatrix();
  
  // ángulo que  mueve la aguja del segundero cada minuto
  float anguloMinutos = 360 / 60 * minute();
  //dibujará la aguja que marca los minutos
  strokeWeight(2);
  pushMatrix();
  rotate(radians(anguloMinutos));
  line(0, 0, 0, -90);
  popMatrix();
  
  // ángulo que  mueve la aguja del segundero cada hora
  float anguloHoras = 360 / 12 * hour();
  //dibujará la aguja que marca la horas
  strokeWeight(4);
  pushMatrix();
  rotate(radians(anguloHoras));
  line(0, 0, 0, -50);
  popMatrix();
}