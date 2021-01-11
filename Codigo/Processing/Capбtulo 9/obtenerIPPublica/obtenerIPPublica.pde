import processing.net.*; 

Client cliente; 
String datos;

void setup() { 
  size(500, 200);
  background(255);
  fill(0);
  textSize(24);
  textAlign(CENTER, CENTER);
    
  //Crea el cliente y lo conecta al servidor www.vermiip.es
  cliente = new Client(this, "www.vermiip.es", 80); 
  //Realiza la petiicón de HTTP del tipo GET
  cliente.write("GET / HTTP/1.1\n");
  cliente.write("Host: www.vermiip.es\n\n");
}

void draw() {
  if (cliente.available() > 0) { 
    datos = cliente.readString();
    if(datos.indexOf("<h2>Tu IP p&uacute;blica es: ") != -1)
       text("Su IP pública es: "+
            datos.substring(datos.indexOf("<h2>Tu IP p&uacute;blica es: ")+28, 
            (datos.indexOf("</h2>"))),
            width/2, height/2);
  }
}