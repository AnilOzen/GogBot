import oscP5.*;
import netP5.*;

OscP5 oscP5;
NetAddress remoteLocation;
String clientIP;
float accelerometerX, accelerometerY, accelerometerZ;
int[] data = {0, 0, 0};

void setup() {
  size(480, 480);
  oscP5 = new OscP5(this, 12000);
  remoteLocation = new NetAddress("130.89.000.00", 12000);
  textSize(24);
}

void draw() {
  background(50, 100, 255);
  textAlign(LEFT,CENTER);
  text(oscP5.ip(),0,20);
  textAlign(CENTER,CENTER);
  
  text("Data: " + "\n" +
    "length: "+ data[0] + "\n" +
    "age: "+ data[1] + "\n" +
    "gender: "+ data[2] + "\n\n", width/2, height/2);

  OscMessage myMessage = new OscMessage("status");
  myMessage.add(0);  //(2)
  oscP5.send(myMessage, remoteLocation); //(5)
}

void oscEvent(OscMessage theOscMessage) {
  if (theOscMessage.checkTypetag("fffs")) {
    data[0] =  (int)theOscMessage.get(0).floatValue();
    data[1] =  (int)theOscMessage.get(1).floatValue();
    data[2] =  (int)theOscMessage.get(2).floatValue();

    String newIP = theOscMessage.get(3).stringValue();
    remoteLocation = new NetAddress(newIP, 12000);
  }
}