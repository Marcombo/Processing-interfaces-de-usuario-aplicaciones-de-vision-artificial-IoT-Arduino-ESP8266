import mqtt.*;

MQTTClient cliente;
String tema = "marcombo_rele";

boolean estadoLuz = false;
int diametroBoton = 100;

void setup() {
  size(200, 200);
  textAlign(CENTER);
  stroke(255);
  
  cliente = new MQTTClient(this);
  cliente.connect("tcp://test.mosquitto.org", "processing");
  cliente.publish(tema, "OFF");
}

void draw() {
  background(100);
  if (estadoLuz){
    fill(0, 0, 255);
    ellipse(width/2, height/2, diametroBoton, diametroBoton);
    fill(255);
    line(width/2-diametroBoton/2, height/2, width/2+diametroBoton/2, height/2);
    text("El relé está activado", width/2, height-20);
  }
  else{
    fill(0, 0, 255);
    ellipse(width/2, height/2, diametroBoton, diametroBoton);
    fill(255);
    line(width/2-diametroBoton/2, height/2, width/2, height/2-diametroBoton/4);
    line(width/2, height/2, width/2+diametroBoton/2, height/2);
    text("El relé está desactivado", width/2, height-20);
  }
}

void clientConnected() {
  println("Cliente conectado");
}

void messageReceived(String topic, byte[] payload) {}

void connectionLost() {
  println("Conexión perdida");
}

void mousePressed() {
  if(ratonSobreBoton()){
    if(estadoLuz){
      cliente.publish(tema, "OFF");
      estadoLuz = false;
    }
    else{
      cliente.publish(tema, "ON");
      estadoLuz = true;
    }
  }
}

boolean ratonSobreBoton() {
  float distanciaX = width/2 - mouseX;
  float distanciaY = height/2 - mouseY;
  if (sqrt(sq(distanciaX) + sq(distanciaY)) < diametroBoton/2 ) {
    return true;
  } else {
    return false;
  }
}