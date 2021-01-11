import processing.net.*;

Server servidor; 
Client cliente;
String peticion;

void setup() { 
  frameRate(10);
  servidor = new Server(this, 80); 
  print("IP Servidor: ");println(Server.ip());
} 

void draw() { 
  //Obtiene un cliente con una petición pendiente de ser atendida
  cliente = servidor.available();
  if (cliente != null) {
    //Lee la petición del cliente
    peticion = cliente.readString(); 
    //Devuelve una respuesta
    cliente.write("HTTP/1.1 200 OK\n");
    cliente.write("Content-Type: text/html\n");
    cliente.write("\n");
    cliente.write("<!DOCTYPE HTML>\n");
    cliente.write("<head>\n");
    cliente.write("<meta charset='UTF-8'>\n");
    cliente.write("<title>Servidor Web Processing</title>\n");
    cliente.write("</head>\n");
    cliente.write("<html>\n");
    cliente.write("<body>\n");
    cliente.write("<h1>Bienvenido al servidor Web de mi Processing</h1>\n");
    cliente.write("</body>\n");
    cliente.write("</html>\n");
    
    cliente.stop();
  }
}