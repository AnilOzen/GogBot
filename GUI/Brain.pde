class Brain {
  PVector loc; // Location on the screen, just for the GUI
  int state = 0; // If it is selected or not
  int emotion; // Current emotion
  int[] colors= {120, 50, 0, 235, 285}; // Hue color values
  float amplitude;

  Brain(int emotion_) {
    loc=new PVector(400*cos(map(emotion_, 0, 5, -HALF_PI, HALF_PI+PI)), 400*sin(map(emotion_, 0, 5, -HALF_PI, HALF_PI+PI)));
    emotion=emotion_+1;
  }

  void updateEmotion(int newEmotion){
    emotion = newEmotion;
  }

  void display() {
    colorMode(HSB);
    fill(colors[emotion-1]*255/360, 255, 255);
    float r=60+amplitude*200;
    ellipse(loc.x, loc.y, r, r); 
    fill(255);
    textAlign(CENTER, CENTER);
    textSize(50);
    text(emotion, loc.x, loc.y);
    if (state == 1) ellipse(loc.x, loc.y, 20, 20);
  }
}