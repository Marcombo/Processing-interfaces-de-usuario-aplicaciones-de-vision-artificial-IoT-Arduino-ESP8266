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

int anchoLadrillo = 50;
int altoLadrillo = 20;
int posXLadrillo;
int posYLadrillo;
int numeroFilas = 5;
int numeroColumnas = 8;
int alturaPrimeraFila = 80;
color[] colores  = {#FF0000, #00FF00, #FFFF00, #0000FF, #00FFFF};
boolean visibilidadLadrillos[];

//no hay pelota en pantalla inicialmente
boolean nuevoJuego=false;

void setup(){
  size(400,500);
  //coloca la raqueta abajo en el centro
  posXRaqueta=width/2 - anchoRaqueta/2;
  posYRaqueta=height - altoRaqueta;
  
  //inicializa la matriz que indica que sevisualicen todos los ladrillos
  visibilidadLadrillos = new boolean[numeroFilas*numeroColumnas];
  for(int i = 0; i < visibilidadLadrillos.length; i++) visibilidadLadrillos[i] = true;
}

void draw(){
  background(125);
  //situa la pelota en una posición aleatoria si se ha pulado el espacio
  if (nuevoJuego){
    posXPelota = int(random(width));
    posYPelota = height/2;
    nuevoJuego = false;
  }
  pintaLadrillos();
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
  //la pelota rebota en un ladrillo
  for(int fila = 0; fila < numeroFilas; fila++){
    for(int columna = 0; columna < numeroColumnas; columna++){
      posXLadrillo = columna*anchoLadrillo;
      posYLadrillo = fila*altoLadrillo+alturaPrimeraFila;
      //solo puedo rebotar en los ladrillos cuyo visibles
      if(visibilidadLadrillos[fila*numeroColumnas+columna]){
        //la pelota rebota en un ladrillo
        if((posXPelota >= posXLadrillo && posXPelota <= posXLadrillo + anchoLadrillo) &&
           (posYPelota >= posYLadrillo && posYPelota <= posYLadrillo + altoLadrillo)){
           velocidadYPelota = -velocidadYPelota;
           visibilidadLadrillos[fila*numeroColumnas+columna] = false; //oculto el ladrillo
           fila = numeroFilas; //obligo a salir del bucle superior
           break; //salgo del bucle
         }
      }
    }
  }
  //actualiza la posición de la pelota
  posXPelota = posXPelota + velocidadXPelota;
  posYPelota = posYPelota + velocidadYPelota;
  //pinta la pelota
  ellipse(posXPelota,posYPelota,anchoPelota,anchoPelota);
}

void pintaRaqueta(){ 
  fill(255);
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

void pintaLadrillos(){

  for(int fila = 0; fila < numeroFilas; fila++){
    fill(colores[fila]);
    for(int columna = 0; columna < numeroColumnas; columna++){
      //solo visualiza los ladrillos cuyo valor en su posición dentro del array de visibilidad sea true
      if(visibilidadLadrillos[fila*numeroColumnas+columna]) rect(columna*anchoLadrillo, fila*altoLadrillo+alturaPrimeraFila, anchoLadrillo, altoLadrillo);
    }
  }
}

void keyPressed(){
  if (key == ' ') nuevoJuego=true; 
}