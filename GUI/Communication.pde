class Communication {
  Serial sPort;

  Communication(Serial sPort_) { // switchboard port
    sPort = sPort_;
  }

  String readSwitchBoard() {
    int incomingData = 0;
    String switchMessage = "";
    String validRead = "";

    while (sPort.available() > 0) {
      incomingData = sPort.read();
      if (char(incomingData) != '\n')
      {
        switchMessage += char(incomingData);
      } 
      else
      {
        if(switchMessage.length() == 10);
          validRead = switchMessage;
        switchMessage = "";
      }
    }
    if (validRead.length() != 0)
      println(validRead.length(), validRead);
    return validRead;
  }
}