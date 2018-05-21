//This Code will form the basis for the connection to the Arduino. 




//=====================================================================================
//Code is currently in development. Code needs to be improved!!!
//======================================================================================

import processing.serial.*; 
Serial Nano1, Nano2, Nano3, Nano4, Nano5;       // all the Arduino Nano boards
Serial Arduino_CB;         //Arduino buttonboard
Serial Arduino_OF;         //Arduino General
int NEWLINE = 10;
char header[] = {'X', 'Y', 'Z', 'U', 'V', 'Q', 'C'};           
int pinDATA[] = new int[7];                     
String buff= "";

void setup()

{
  size(600, 100);
  println("Available serial ports:");
  for (int i = 0; i<Serial.list().length; i++) 
  { 
    print("[" + i + "] ");
    println(Serial.list()[i]);
  } 


  //Nano1 = new Serial(this, Serial.list()[0], 9600);
  //Nano2 = new Serial(this, Serial.list()[0], 9600);
  //Nano3 = new Serial(this, Serial.list()[0], 9600);
  //Nano4 = new Serial(this, Serial.list()[0], 9600);
  //Nano5 = new Serial(this, Serial.list()[0], 9600);
  Arduino_CB = new Serial(this, Serial.list()[0], 9600);
  //Arduino_OF = new Serial(this, Serial.list()[0], 9600);
}



void draw() {                   


  //setauto(Nano1);
  //delay(1500);
  //setcolorBLUE(Nano1);
  //delay(1500);
  //setcolorGREEN(Nano1);
  //delay(1500);
  Data_Arduino();
  println(pinDATA[6]);

  buttonRing(Arduino_CB,1);
  if (pinDATA[6]==1) {
  commandArduino(Arduino_CB, 'G', 255);
  }
}





//===============================================================================================================================================
//Data fucntions for getting data from the Arduino. The data will be saved in the pinDATA array.
//===============================================================================================================================================

void Data_Arduino() {
  while (Arduino_CB.available()>0) {                   //checks whether something is being received. 
    Receive_Arduino(Arduino_CB.read());
  }
}

void Receive_Arduino(int serial) {


  try {                                           // try-catch because of transmission errors
    if (serial != NEWLINE) { 
      buff += char(serial);
    } else {

      char c = buff.charAt(0);

      buff = buff.substring(1);

      buff = buff.substring(0, buff.length()-1);

      for (int z=0; z<7; z++) {
        if (c == header[z]) {
          pinDATA[z] = Integer.parseInt(buff);
        }
      }
      buff = "";                                      // Clear the value of "buff"
    }
  }
  catch(Exception e) {
    println("no valid data");
  }
}
//========================================================
//codes that only can be used for the Arduino button board
//========================================================



//==================================================
//The commands that can be used are shown below. 
//The commands only work for the Arduino Nano boards. 
//===================================================


void commandArduino(Serial Arduino, char command, int value) {   // for this function the value represents the brightness of the ledstrips
  String i = "";
  i+=command;
  Arduino.write(i+value);
}

void buttonRing(Serial Arduino, int colorValue) {                          //the color value 1 = red, 2= green,        This represents whether the connection is right or wrong. 
  Arduino.write("R"+colorValue);
}