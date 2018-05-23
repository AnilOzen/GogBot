class Communication {
  Serial sPort;

  Communication(Serial sPort_) { // switchboard port
    sPort = sPort_;
  }

  String readSwitchBoard() {
    String switchBoardMsg = "";
    while (sPort.available() > 0) {
      int inByte = sPort.read();
      switchBoardMsg += char(inByte);
    
    }
      println(switchBoardMsg);
    /*
    while (sPort.available() > 0) {
     String inBuffer = sPort.readString();   
     if (inBuffer != null) {
     println(inBuffer);
     }
     }
     */
    /*
    int incomingData = 0;
     String switchMessage = "";
     String validRead = "";
     String invalidRead = "";
     while (sPort.available() > 0) {
     incomingData = sPort.read();
     if (char(incomingData) != '\n')
     {
     switchMessage += char(incomingData);
     } else
     {
     
     if (switchMessage.length() == 6)
     validRead = switchMessage;
     
     println(switchMessage);
     switchMessage = "";
     }
     }
     if (validRead.length() != 0)
     {
     //println(validRead);
     return validRead;
     } else
     return invalidRead;
     */
    return "yeah";
  }

  void writeSwitchBoard(String newEmotions)
  {
    while (sPort.available() > 0)
      sPort.write(newEmotions);
  }
}