class Brain {
  PVector loc;
  int state = 0;
  int emotion;
  int serialPort;
  Serial arduino_LED;    
  int[] colors= {120, 50, 0, 235, 285}; // Hue color values

  Brain(float x_, float y_, int emotion_, Serial arduino_) {
    loc=new PVector(x_, y_);
    emotion=emotion_+1;
    arduino_LED = arduino_;
  }

  void updateEmotion(int newEmotion){
    emotion = newEmotion;
  }

  void sendEmotionToArduino(){
    arduino_LED.write(emotion);
  }

  void run() {
    colorMode(HSB);
    fill(colors[emotion-1]*255/360, 255, 255);
    ellipse(loc.x, loc.y, 50, 50); 
    fill(255);
    textAlign(CENTER, CENTER);
    textSize(40);
    text(emotion, loc.x, loc.y);
    if (state == 1) ellipse(loc.x, loc.y, 20, 20);
  }
}