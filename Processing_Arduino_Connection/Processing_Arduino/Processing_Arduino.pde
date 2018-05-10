//This Code will form the basis for the connection to the Arduino. 




//=====================================================================================
//Code is currently in development. Code needs to be imporved!!!



//======================================================================================

import processing.serial.*; 

Serial Nano1;
Serial Nano2;
Serial Nano3;
Serial Nano4;
Serial Nano5;


Serial Arduino_CB;         //Arduino buttonboard
Serial Arduino_OF;         //Arduino General
void setup()



{
  size(600,100);
  println("Available serial ports:");
  for (int i = 0; i<Serial.list().length; i++) 
  { 
    print("[" + i + "] ");
    println(Serial.list()[i]);
  } 


  Nano1 = new Serial(this, Serial.list()[0], 9600);
  //Nano2 = new Serial(this, Serial.list()[0], 9600);
  //Nano3 = new Serial(this, Serial.list()[0], 9600);
  //Nano4 = new Serial(this, Serial.list()[0], 9600);
  //Nano5 = new Serial(this, Serial.list()[0], 9600);
  //Arduino_CB = new Serial(this, Serial.list()[0], 9600);
  //Arduino_OF = new Serial(this, Serial.list()[0], 9600);
}



void draw() {                   


  setauto(Nano1);
  delay(1500);
  setcolorBLUE(Nano1);
    delay(1500);
    setcolorGREEN(Nano1);
      delay(1500);
}



//=============================================
//The commands that can be used are shown below


//========================================
void setcolorRED(Serial Arduino) {
    Arduino.write("R");
}
void setcolorBLUE(Serial Arduino){
    Arduino.write("B");
}
void setcolorGREEN(Serial Arduino){
    Arduino.write("G"); 
}
void setauto(Serial Arduino){
   Arduino.write("A"); 
}