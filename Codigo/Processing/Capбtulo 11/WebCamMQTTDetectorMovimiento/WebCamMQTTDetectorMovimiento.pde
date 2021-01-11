import gab.opencv.*;
import processing.video.*;
import mqtt.*;

Capture camara;
OpenCV opencv;

MQTTClient cliente;
String tema = "marcombo_alarma_movimiento";

float areaContornoMinima = 10000;
boolean alarmaActivada = false;
boolean alarmaRearmada = true;
int diametroBotonDesactivacion = 100;

void setup() {
  size(640, 480);
  textAlign(CENTER);
  opencv = new OpenCV(this, 640, 480);
  
  opencv.startBackgroundSubtraction(5, 30, 0.5);
    
  camara = new Capture(this, 640, 480);
  camara.start();
  
  delay(1000);
  
  cliente = new MQTTClient(this);
  cliente.connect("tcp://test.mosquitto.org", "processing");
}

void draw() {
  opencv.loadImage(camara);
  image(camara, 0, 0 );
  
  opencv.updateBackground();

  for (Contour contorno : opencv.findContours()) {
    if(contorno.area() > areaContornoMinima) alarmaActivada = true;
  }
  
  if(alarmaActivada && alarmaRearmada) {
    cliente.publish(tema, "ON");
    alarmaRearmada = false;
    saveFrame();
  }
  
  if(alarmaActivada){
    fill(255, 0, 0);
    ellipse(width/2, height/2, diametroBotonDesactivacion, diametroBotonDesactivacion);
    fill(255);
    text("DESACTIVAR\nALARMA", width/2, height/2);
  }
}

void captureEvent(Capture c) {
  c.read();
}

void clientConnected() {
  println("Cliente conectado");
  cliente.subscribe(tema);
}

void messageReceived(String tema, byte[] contenido) {
  String contenidoMensaje = new String(contenido);
  println("mensaje: " + tema + " - " + contenidoMensaje + ".");
  if(contenidoMensaje.equals("OFF") == true){
    alarmaActivada = false;
    alarmaRearmada = true;
  }
}

void connectionLost() {
  println("Conexión perdida");
}

void mousePressed(){
  if(ratonSobreBoton()){
    cliente.publish(tema, "OFF");
    alarmaActivada = false;
    alarmaRearmada = true;
  }
}

boolean ratonSobreBoton() {
  float distanciaX = width/2 - mouseX;
  float distanciaY = height/2 - mouseY;
  if (sqrt(sq(distanciaX) + sq(distanciaY)) < diametroBotonDesactivacion/2 ) {
    return true;
  } else {
    return false;
  }
}