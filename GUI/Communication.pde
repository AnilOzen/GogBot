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
  }

  void writeArduinos() {
    int[] col = {4, 2, 1, 5, 3};
    for (int i=0; i<5; i++) {
      if (sound.talking && network.brains.get(i).state==1) commandArduino(i, 1, col[network.brains.get(i).emotion-1], 127+int(network.brains.get(i).amplitude*127.00));
      if (sound.talking && network.brains.get(i).state==0) commandArduino(i, 2, col[network.brains.get(i).emotion-1], 127+int(network.brains.get(i).amplitude*127.00));

      if (!sound.talking && network.brains.get(i).state==1) commandArduino(i, 1, col[network.brains.get(i).emotion-1], 255);
      if (!sound.talking && network.brains.get(i).state==0) commandArduino(i, 2, col[network.brains.get(i).emotion-1], 255);
    }
  }

  void commandArduino(int ard, int value1, int value2, int value3) {   // for this function the value represents the brightness of the ledstrips
    String out = "";
    out+=str(value1);
    out+=str(value2);
    out+=nf(value3, 3);
    arduinoPorts[ard].write(out);
  }
}