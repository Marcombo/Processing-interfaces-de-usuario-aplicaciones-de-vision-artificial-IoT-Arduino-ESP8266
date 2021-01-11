import processing.net.*; 

Client cliente; 
String datosServidor;
int coordenadasServidor[]; 

void setup() { 
  size(400, 400); 
  frameRate(10);
  //Creamos el cliente
  cliente = new Client(this, "192.168.1.37", 12345); // ¡Asegurarse de que la IP coincide con la del servidor!
} 

void draw() {         
  if (mousePressed == true) {
    //Dibuja su línea
    stroke(0, 0, 255);
    line(pmouseX, pmouseY, mouseX, mouseY); 
    //Enviamos las coordenadas del ratón al servidor
    cliente.write(pmouseX + " " + pmouseY + " " + mouseX + " " + mouseY + "\n");
  }

  //Recibe los datos de las coordenadas del servidor
  if (cliente.available() > 0) { 
    datosServidor = cliente.readString(); 
    datosServidor = datosServidor.substring(0, datosServidor.indexOf("\n"));
    coordenadasServidor = int(split(datosServidor, ' '));
    //Dibuja la linea del servidor
    stroke(0);
    line(coordenadasServidor[0], coordenadasServidor[1], coordenadasServidor[2], coordenadasServidor[3]); 
  } 
}