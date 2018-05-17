import oscP5.*;
import netP5.*;

class Server {
  OscP5 oscP5;
  NetAddress remoteLocation;
  int[] data = {0, 0, 0}; // The data it received

  Server() {
    oscP5 = new OscP5(this, 12000);
    remoteLocation = new NetAddress("130.89.000.00", 12000);
  }

  void oscEvent(OscMessage theOscMessage) {
    if (theOscMessage.checkTypetag("fffs")) { // If there is data, save it
      data[0] =  (int)theOscMessage.get(0).floatValue();
      data[1] =  (int)theOscMessage.get(1).floatValue();
      data[2] =  (int)theOscMessage.get(2).floatValue();

      String newIP = theOscMessage.get(3).stringValue();
      remoteLocation = new NetAddress(newIP, 12000);
      println("CURRENT DATA: " + data[0] + " , " + data[1] + " , " + data[2]);
    }
  }
}