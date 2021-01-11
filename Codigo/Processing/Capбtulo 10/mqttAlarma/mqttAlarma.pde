import mqtt.*;
import ddf.minim.*;

MQTTClient cliente;
String tema = "marcombo_pir";

Minim minim;
AudioPlayer reproductor;

boolean estadoAlarma = false;
boolean alarmaRearmada = true;

void setup() {
  cliente = new MQTTClient(this);
  cliente.connect("tcp://test.mosquitto.org", "processing");
  
  //Inicia objetos de audio
  minim = new Minim(this);
  reproductor = minim.loadFile("sirena.mp3");
}

void draw() {
  if(estadoAlarma && alarmaRearmada){
        reproductor.play();
        reproductor = minim.loadFile("sirena.mp3");
        alarmaRearmada = false;
  }
}

void clientConnected() {
  println("Cliente conectado");
  cliente.subscribe(tema);
}

void messageReceived(String tema, byte[] contenido) {
  String contenidoMensaje = new String(contenido);
  println("mensaje: " + tema + " - " + contenidoMensaje + ".");
  if(contenidoMensaje.equals("ON") == true && alarmaRearmada) estadoAlarma = true;
  else if(contenidoMensaje.equals("OFF") == true){
    estadoAlarma = false;
    alarmaRearmada = true;
  }
}

void connectionLost() {
  println("Conexión perdida");
}