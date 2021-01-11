
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
}

void draw(){
  background(125);
  text("FRONTÓN", width/2, height/2);
  //situa la pelota en una posición aleatoria en la parte superior de la ventana
  if (nuevoJuego){
    posXPelota=int(random(width));
    posYPelota=int(random(height/2));
    nuevoJuego=false;
  }  
  pintaPelota();
  pintaRaqueta();
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
  if(keyPressed){
    if (key == CODED){
      switch(keyCode){
        case LEFT:  if (posXRaqueta - velocidadRaqueta > 0) posXRaqueta-=velocidadRaqueta; break;
        case RIGHT: if (posXRaqueta + anchoRaqueta + velocidadRaqueta < width) posXRaqueta+=velocidadRaqueta; break;
      }
    }
  }
  //pinta la raqueta
  rect(posXRaqueta, posYRaqueta, anchoRaqueta, altoRaqueta);
}


void keyPressed(){
  if (key == ' ') nuevoJuego=true; 
}