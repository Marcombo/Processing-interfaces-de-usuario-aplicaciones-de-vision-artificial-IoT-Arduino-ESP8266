import processing.net.*;

Server servidor; 
Client cliente;
String datosCliente;
int coordenadasCliente[];

void setup() { 
  size(400, 400);
  frameRate(10);
  //Creamos el servidor
  servidor = new Server(this, 12345); 
  print("IP Servidor: ");println(Server.ip());
} 
void draw() { 
  if (mousePressed == true) {
    //Dibujamos nuestra línea
    stroke(0, 0, 255);
    line(pmouseX, pmouseY, mouseX, mouseY); 
    //Enviamos las coordenadas al cliente
    servidor.write(pmouseX + " " + pmouseY + " " + mouseX + " " + mouseY + "\n");
  }
  
  //Recibimos las coordenadas dl cliente
  cliente = servidor.available();
  if (cliente != null) {
    datosCliente = cliente.readString(); 
    datosCliente = datosCliente.substring(0, datosCliente.indexOf("\n"));  
    coordenadasCliente = int(split(datosCliente, ' '));  
    //Dibujamos la línea del cliente
    stroke(0);
    line(coordenadasCliente[0], coordenadasCliente[1], coordenadasCliente[2], coordenadasCliente[3]); 
  }
}