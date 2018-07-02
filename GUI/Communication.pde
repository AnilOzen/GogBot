class Communication {
  String latestMessage = "00000001";

  Communication() { // switchboard port
  }

  void readSwitchBoard() {
    int incomingData = 0;
    String switchMessage = "";
    String validRead = "";

    while (sPort.available() > 0) {
      incomingData = sPort.read();
      if (char(incomingData) != '\n') {
        switchMessage += char(incomingData);
      } else {
        if (switchMessage.length() == 9) validRead = switchMessage;
        switchMessage = "";
      }
    }

    if (validRead.length() != 0) {
      //println(validRead);
      latestMessage=validRead;
    }
  }

  void writeSwitchBoard() {
    for (int i=1; i<6; i++) sPort.write(i*10+network.brains.get(i-1).emotion);
    for (int i=1; i<6; i++) sPort.write(int(100 + i*10 + ((sound.talking) ? network.brains.get(i-1).state*1+1 : 4) + network.brains.get(i-1).amplitude*7));
    sPort.write((sound.talking) ? 202 : 201);
  }

  void writeArduinos() {
    for (int i=0; i<4; i++) {
      colorMode(RGB);
      float ampl = floor(55+int(network.brains.get(i).amplitude*200.00));
      ampl/=40;

      if (sound.talking && network.brains.get(i).state==1) commandArduino(i, 1, int(red(network.brains.get(i).clr)/ampl), int(green(network.brains.get(i).clr)/ampl), int(blue(network.brains.get(i).clr)/ampl));
      if (sound.talking && network.brains.get(i).state==0) commandArduino(i, 2, 255, 255, 255);

      if (!sound.talking && network.brains.get(i).state==1) commandArduino(i, 1, (int) red(network.brains.get(i).clr), (int) green(network.brains.get(i).clr), (int) blue(network.brains.get(i).clr));
      if (!sound.talking && network.brains.get(i).state==0) commandArduino(i, 2, (int) red(network.brains.get(i).clr), (int) green(network.brains.get(i).clr), (int) blue(network.brains.get(i).clr));
    }
  }

  void commandArduino(int ard, int value1, int r, int g, int b) {   // for this function the value represents the brightness of the ledstrips
    String out = "";
    out+=str(value1);
    out+=nf(r, 3);
    out+=nf(g, 3);
    out+=nf(b, 3);
    arduinoPorts[ard].write(out);
  }
}
