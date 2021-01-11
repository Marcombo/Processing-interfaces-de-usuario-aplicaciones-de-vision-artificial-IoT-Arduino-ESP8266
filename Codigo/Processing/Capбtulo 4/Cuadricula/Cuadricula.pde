int ladoCuadricula = 20; //el lado de la cuadrícula es de 20 píxeles

void setup() {
  size(300, 300);
}

void draw() {
  //dibujará las líneas verticales
  for(int x = 0; x <= width; x += ladoCuadricula){
    line(x, 0, x, height);
  }
  
  //dibujará las líneas horizontales
  for(int y = 0; y <= height; y += ladoCuadricula){
    line(0, y, width, y);
  } 
}