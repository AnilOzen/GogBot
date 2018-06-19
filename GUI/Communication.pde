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
  }

  void writeArduinos() {
    int[] col = {4, 2, 1, 5, 3};
    for (int i=0; i<1; i++) {
      //commandArduino(i, 3-network.brains.get(i).state, col[network.brains.get(i).emotion-1], 255);
      commandArduino(i, 1, col[network.brains.get(i).emotion-1], int(network.brains.get(i).amplitude*255.00));
      //commandArduino(i, 1, col[network.brains.get(i).emotion-1], 127);
      //if (sound.talking) commandArduino(i, 1, col[network.brains.get(i).emotion-1], int(network.brains.get(i).amplitude*255.00));
      commandArduino(i, 2, col[network.brains.get(i).emotion-1], (sound.talking) ? int(network.brains.get(i).amplitude*255.00) : 255*network.brains.get(i).state);
      if (!sound.talking) commandArduino(i, 3, col[network.brains.get(i).emotion-1], (sound.talking) ? int(network.brains.get(i).amplitude*255.00) : 255*network.brains.get(i).state);
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