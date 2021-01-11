import processing.serial.*;
import controlP5.*;

Serial puerto; 
String datosLeidos;
int valor; 
int[] valores;

ControlP5 cp5;
DropdownList desplegablePuertosCOM;
Textlabel nivelZoom;
Toggle interruptorZoom;
int zoom;

void setup() 
{
  size(1200, 500);
  
  cp5 = new ControlP5(this);
  //desplegable con los puertos COM disponibles
  desplegablePuertosCOM = cp5.addDropdownList("com");
  desplegablePuertosCOM.setPosition(50, 20);
  desplegablePuertosCOM.setSize(50,200);
  String[] puertosCOM = Serial.list();
  for (int i=0; i<puertosCOM.length; i++) {
    desplegablePuertosCOM.addItem(puertosCOM[i], i);
  }
  //toggle con el nivel de zoom
  interruptorZoom = cp5.addToggle("zoom");
  interruptorZoom.setPosition(width-100, 20);
  interruptorZoom.setSize(50,20);
  interruptorZoom.setValue(false);
  interruptorZoom.setMode(ControlP5.SWITCH);
  //etiqueta que muestra el nivel de zoom
  nivelZoom = cp5.addTextlabel("etiqueta");
  nivelZoom.setText("X1");
  nivelZoom.setPosition(width-140, 20);
  nivelZoom.setFont(createFont("Times New Roman",18));
  zoom = 1;
   
  //array que almacena los valores de las tensiones que se muestran en pantalla
  valores = new int[width];
}

void draw()
{
  background(0);

  pintaTitulo();
  pintaRejilla();
  if (valor >= 0) pushValor(valor);
  pintaTrazo();
}

void serialEvent( Serial puerto) {
  datosLeidos = puerto.readStringUntil('\n');
  if (datosLeidos != null) {
    valor = int(trim(datosLeidos))*zoom;
    //println(valor);
    puerto.clear();
  }
}

//almacena un nuevo valor en el array de valores
void pushValor(int valor) {
  for (int i = 0; i < width-1; i++) valores[i] = valores[i+1];
  valores[width-1] = valor;
}

void pintaTitulo(){
  textAlign(CENTER, CENTER);
  textSize(30);
  fill(255, 255, 255, 50);
  text("OSCILOSCOPIO", width/2, height/2);
}

//dibuja en pantanlla la evolución de la tensión en el tiempo
//para ello pinta líneas entre valores de tensión consecutivos
void pintaTrazo() {
  stroke(250, 250, 0);
  strokeWeight(2);
  int x0 = 0;
  int y0 = int(map(float(valores[0]), 0, 1023, height, 0));
  for (int i = 1; i < width; i++) {
    int x1 = i;
    int y1 = int(map(float(valores[i]), 0, 1023, height, 0));
    line(x0, y0, x1, y1);
    x0 = x1;
    y0 = y1;
  }
}

//dibuja la rejilla
void pintaRejilla() {
  stroke(150, 150, 180);
  fill(150, 150, 180);
  strokeWeight(1);
  textSize(15);
  for(int i = 0; i<= height; i += height/5){
    line(0, i, width, i);
    text(str((float(height) - i)/100/zoom) + " V.", 20, i - 10);
  }
}

//gestiona los eventos de los elementos ControlP5
void controlEvent(ControlEvent evento) {
  int val = int(evento.getValue());
  String nombre = evento.getName();
  if(nombre == "com"){
      //establece las comunicaciones con Arduino
    puerto = new Serial(this, Serial.list()[val], 115200);
    puerto.bufferUntil('\n');
  }
  else if(nombre == "zoom" && nivelZoom != null){
    if(val == 0){
      nivelZoom.setText("X1");
      zoom = 1;
    }
    else if(val == 1){
      nivelZoom.setText("X5");
      zoom = 5;
    }
  }
}
 