class Brain {
  Serial person;
  String currentMessage, prevMessage;
  String emotion, prevEmotion;

  Brain(int comPort) {
    person = new Serial(mainApplet, Serial.list()[comPort], 9600);
  }

  void run() {
    if (timer(1)) {                        //Only runs the code every second
      updateMessage();
      sendMessage();
    }
  }

  void updateMessage() {                   //updates the message that will be send to the arduino
    if (!emotion.equals(prevEmotion)) {    //If the emotion changed run the code
      if (emotion == "funny") {            //Sets the message to the according emotion
        currentMessage = "funny";
      }
      if (emotion == "happy") {
        currentMessage = "happy";
      }
      if (emotion == "funny") {
        currentMessage = "funny";
      }
      if (emotion == "funny") {
        currentMessage = "funny";
      }
      if (emotion == "funny") {
        currentMessage = "funny";
      }
      prevEmotion = emotion;                //Updates the previous emotion, so the code only runs when the emotion changes again
    }
  }


  void sendMessage() {                      //Sends the message to the arduino
    if (!currentMessage.equals(prevMessage)) {      //Checks if the message has changed
      person.write(currentMessage);                 //If the message has changed, send the message to the arduino
      prevMessage = currentMessage;                 //Update the previous message so the code only runs when the message changes again
    }
  }
}
