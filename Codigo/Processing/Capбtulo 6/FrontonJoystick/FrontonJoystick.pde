import processing.serial.*;

Serial puerto;
String datosLeidos;
int posicionMando;

int anchoPelota=20;
int velocidadXPelota = 6;
int velocidadYPelota = 6;
int posXPelota = -anchoPelota;
int posYPelota = -anchoPelota;

int velocidadRaqueta = 6;
int anchoRaqueta=75;
int altoRaqueta=10;
int posXRaqueta;
int posYRaqueta;

//no hay pelota en pantalla inicialmente
boolean nuevoJuego=false;

void setup(){
  size(400,500);
  textAlign(CENTER, CENTER);
  textSize(20);
  //coloca la raqueta abajo en el centro
  posXRaqueta=width/2 - anchoRaqueta/2;
  posYRaqueta=height - altoRaqueta;
  
  //crea el puerto de comunicaciones con Arduino
  String nombrePuerto  = Serial.list()[0];
  puerto = new Serial(this, nombrePuerto, 115200);
}

void draw(){
  //lee la posición del potenciómetro
  datosLeidos = puerto.readStringUntil('\n');
  if (datosLeidos != null) {
    posicionMando = int(trim(datosLeidos));
    puerto.clear();
  }
  
  background(125);
  text("FRONTÓN", width/2, height/2);
  //situa la pelota en una posición aleatoria si se ha pulado el espacio
  if (nuevoJuego){
    posXPelota=int(random(width));
    posYPelota=int(random(height/2));
    nuevoJuego=false;
  }  
  pintaRaqueta();
  pintaPelota();
}

void pintaPelota(){
  //la pelota rebota en la izquierda y en la derecha
  if(posXPelota <=0 || posXPelota >= width){
    velocidadXPelota = -velocidadXPelota;
  }
  //la pelota rebota arriba 
  if(posYPelota <=0){
    velocidadYPelota = -velocidadYPelota;
  }
  //la pelota rebota en la raqueta
  if((posXPelota >= posXRaqueta && posXPelota <=posXRaqueta + anchoRaqueta) &&
     (posYPelota >= posYRaqueta && posYPelota <=posYRaqueta + altoRaqueta)){
     velocidadYPelota = -velocidadYPelota;
  }
  //actualiza la posición de la pelota
  posXPelota = posXPelota + velocidadXPelota;
  posYPelota = posYPelota + velocidadYPelota;
  //pinta la pelota
  ellipse(posXPelota,posYPelota,anchoPelota,anchoPelota);
}

void pintaRaqueta(){ 
  //actualiza la posición de la raqueta
  posXRaqueta = int(map(posicionMando, 0, 1023, 0, 399));
  if (posXRaqueta > width - anchoRaqueta) posXRaqueta = width - anchoRaqueta;
  //pinta la raqueta
  rect(posXRaqueta, posYRaqueta, anchoRaqueta, altoRaqueta);
}


void keyPressed(){
  if (key == ' ') nuevoJuego=true; 
}