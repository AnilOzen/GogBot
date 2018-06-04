class Communication {
  Serial sPort;
  String latestMessage = "";

  Communication(Serial sPort_) { // switchboard port
    sPort = sPort_;
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
      println(validRead);
      latestMessage=validRead;
    }
  }

  void writeSwitchBoard(){
    for (int i=1; i<6; i++) sPort.write(i*10+network.brains.get(i-1).emotion);
  }
}