int ladoCubo = 200;

void setup() {
  size(800, 600, P3D);
  strokeWeight(2); 
}

void draw() {
  background(100); //borra todo lo dibujado previamente
  
  //calcula los ángulos de rotación (en radianes)
  float rotacionX = (mouseY/float(width))*-TWO_PI+PI;
  float rotacionY = (mouseX/float(height))*TWO_PI-PI;

  // centra los ejes de coordenadas en la ventana
  translate(width/2, height/2, 0); 
  //los rotamos
  rotateX(rotacionX);  
  rotateY(rotacionY);  
  
  //dibuja los ejes
  stroke(255);
  line(-ladoCubo, 0, ladoCubo, 0);       
  line(0, ladoCubo, 0, -ladoCubo);       
  line(0, 0, -ladoCubo, 0, 0, ladoCubo); 
  
  //dibuja el cubo
  stroke(0, 0, 255);
  noFill();
  box(ladoCubo); 
}