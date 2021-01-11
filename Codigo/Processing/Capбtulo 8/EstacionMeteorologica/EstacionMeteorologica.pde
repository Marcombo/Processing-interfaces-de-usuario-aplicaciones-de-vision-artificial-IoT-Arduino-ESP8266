import meter.*;
import processing.serial.*; 

Serial puerto; 
Meter termometro, higrometro;
String datosLeidos;
String[] temperaturaHumedad;
int temperatura, humedad;

void setup() {
  size(930, 450);
  background(255);
  
  fill(0, 0, 255);
  textSize(30);
  textAlign(CENTER, CENTER);
  
  puerto = new Serial(this, "COM5", 9600); //cambiar por el puerto bluetooth correspondiente
  puerto.bufferUntil('\n'); 
  
  configuratermometro();
  configurahigrometro();
}

void draw() {
  background(255);
  text("ESTACIÓN METEOROLÓGICA", width/2, 30);
  termometro.updateMeter(temperatura);
  higrometro.updateMeter(humedad);
}

void serialEvent( Serial puerto) {
  datosLeidos = puerto.readStringUntil('\n');
  if (datosLeidos != null) {
    temperaturaHumedad = split(datosLeidos, ",");
    temperatura = int(trim(temperaturaHumedad[0]));
    humedad = int(trim(temperaturaHumedad[1]));
    //print(temperatura);print(","); println(humedad);
    puerto.clear();
  }
}
  
void configuratermometro(){
  termometro = new Meter(this, 25, 100); // se crea el objeto termometro
  
  termometro.setFrameColor(255); //color de fondo del termómetro

  // Título del termometro y tamaño de fuente utilizada
  termometro.setTitleFontSize(20);
  termometro.setTitle("Temperatura (ºC)");

  
  // Escala utilizada y tamaño y color de la fuente con la que se dibuja
  String[] scaleLabelsT = {"0", "5", "10", "15", "20", "25", "30", "35", "40", "45", "50"};
  termometro.setScaleLabels(scaleLabelsT);
  termometro.setScaleFontSize(18);
  termometro.setScaleFontColor(color(0, 0, 255));
  
  // Color y ancho del arco
  termometro.setArcColor(color(0, 0, 255));
  termometro.setArcThickness(15);

  termometro.setNeedleThickness(5); //ancho de la aguja
  
  // Valores máximo y mínimo que se van a medir
  termometro.setMinInputSignal(0);
  termometro.setMaxInputSignal(50);
}

void configurahigrometro(){
  //se obtienen las coordenadas en la que se dibujó el termometro y su ancho
  //las utilizará para situar el higrómetro a su derecha
  int termometroX = termometro.getMeterX();
  int termometroY = termometro.getMeterY();
  int termometroAncho = termometro.getMeterWidth();
  higrometro = new Meter(this,termometroX + termometroAncho, termometroY); // se crea el objeto higrómetro
  
  higrometro.setFrameColor(255); //color de fondo del higrómetro

  // Título del higrómetro y tamaño de fuente utilizada
  higrometro.setTitleFontSize(20);
  higrometro.setTitle("Humedad (%)");

  
  // Escala utilizada y tamaño y color de la fuente con la que se dibuja
  String[] scaleLabelsT = {"0", "10", "20", "30", "40", "50", "60", "70", "80", "90", "100"};
  higrometro.setScaleLabels(scaleLabelsT);
  higrometro.setScaleFontSize(18);
  higrometro.setScaleFontColor(color(0, 0, 255));
  
  // Color y ancho del arco
  higrometro.setArcColor(color(0, 0, 255));
  higrometro.setArcThickness(15);

  higrometro.setNeedleThickness(5); //ancho de la aguja
  
  // Valores máximo y mínimo que se van a medir
  higrometro.setMinInputSignal(0);
  higrometro.setMaxInputSignal(100);
}