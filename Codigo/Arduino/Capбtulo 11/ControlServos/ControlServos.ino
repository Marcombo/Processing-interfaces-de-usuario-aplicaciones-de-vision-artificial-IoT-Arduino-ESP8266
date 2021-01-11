//Processing envía:  "CONECTA=X\n", "CONECTA=Y\n", "DESCONECTA=X\n", "DESCONECTA=Y\n", "SERVO_X=<angulo>\n", "SERVO_Y=<angulo>\n"

#include <Servo.h>
Servo servoX, servoY;

int pinServoX =3, pinServoY = 11; 

char c = ' ' ;
String input = "" ;
String comando;
String valor;

void setup() {
  Serial.begin(115200);
  
  servoX.attach(pinServoX);
  servoY.attach(pinServoY); 

  // lleva el servo a posición inicial
  servoX.write(90);
  servoY.write(90);  
  delay(1000);

  servoX.detach();
  servoY.detach();
}

void loop(){
  //lee la entrada
  input = "" ;
  c = ' ' ;
  if (Serial.available()>0){             
    while( c != '\n') 
        { 
          input = input + c ; 
          c = Serial.read();
        }
    //Serial.print(input);

    input.trim(); 
    comando = input.substring(0, input.indexOf("="));  // identifica el comando
    valor = input.substring(input.indexOf("=")+1);  // identifica el valor                     
    }

    if (comando == "SERVO_X") controlServoX(valor);
    if (comando == "SERVO_Y") controlServoY(valor);
    if (comando == "CONECTA") conecta(valor);
    if (comando =="DESCONECTA") desconecta(valor);
}

//mueve el servoX al ángulo indicado por el valor
void controlServoX(String valor){
    servoX.write(valor.toInt()); 
    delay(20); 
}
//mueve el servoY al ángulo indicado por el valor
void controlServoY(String valor){
    servoY.write(valor.toInt()); 
    delay(20); 
}
//conecta el servo indicado como argumento (X o Y)
void conecta(String valor){
  if(valor == "X") servoX.attach(pinServoX);
  else if (valor == "Y") servoY.attach(pinServoY);
}
//desconecta el servo indicado como argumento (X o Y)
void desconecta(String valor){
  if(valor == "X") servoX.detach();
  else if (valor == "Y") servoY.detach();
}
