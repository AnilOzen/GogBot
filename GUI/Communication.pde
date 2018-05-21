class Communication {
  Serial sPort;
  
  Communication(Serial sPort_) { // switchboard port
    sPort = sPort_;
  }

  void readSwitchBoard() {
    int incomingData = 0;
    while (sPort.available() > 0) {
      incomingData = sPort.read();
    }
  }
}