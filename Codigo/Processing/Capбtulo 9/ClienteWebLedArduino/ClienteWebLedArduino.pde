import processing.net.*; 

Client cliente; 
String datos;

int nivelLuz = 127;

int posicionBotonDeslizador;
int diametroBotonDeslizador = 50;
boolean botonPulsado = false;

void setup() { 
  size(800, 200);
  
  strokeWeight(4);
  textSize(20);
  textAlign(CENTER, CENTER);
  
  posicionBotonDeslizador = width/2;
}

void draw() {
   if(mousePressed && ratonSobreBoton()){
    nivelLuz = int(map(mouseX, 0, width, 0, 255));
    posicionBotonDeslizador = mouseX;
   }
   
   background(nivelLuz, 0, 0);
   
   stroke(255);
   line(0, height/2, width, height/2);
   stroke(255);
   fill(100);
   ellipse(posicionBotonDeslizador, height/2, diametroBotonDeslizador, diametroBotonDeslizador);
   fill(255);
   text(nivelLuz, posicionBotonDeslizador, height/2);
}

void mouseReleased(){
   cliente = new Client(this, "192.168.1.99", 80);
   cliente.write("GET / HTTP/1.1\n");
   cliente.write("Host: 192.168.1.99/?nivelLuz="+nivelLuz+"\n\n");
   cliente.stop();
}

boolean ratonSobreBoton() {
  float distanciaX = posicionBotonDeslizador - mouseX;
  float distanciaY = height/2 - mouseY;
  if (sqrt(sq(distanciaX) + sq(distanciaY)) < diametroBotonDeslizador/2 ) {
    return true;
  } else {
    return false;
  }
}