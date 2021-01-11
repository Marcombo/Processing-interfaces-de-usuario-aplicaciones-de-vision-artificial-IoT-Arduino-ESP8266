PFont miFuente;

void setup(){
  size(600, 600);
  textAlign(CENTER, CENTER);
  miFuente = createFont("Arial Bold", 32);
  fill(0);
}

void draw(){
  textFont(miFuente);
  text("Programar reduce el colesterol", width/2, height/2);
}