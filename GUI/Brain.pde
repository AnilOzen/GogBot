class Brain {
  PVector loc; // Location on the screen, just for the GUI
  int state = 0; // If it is selected or not
  int emotion; // Current emotion
  int[] colors= {120, 50, 0, 235, 285}; // Hue color values
  color clr;
  float amplitude;
  color[] emotionClrs = {color(0,255,0),color(255,255,0),color(255,0,0),color(0,0,255),color(255,0,255)};

  Brain(int emotion_) {
    loc=new PVector(400*cos(map(emotion_, 0, 5, -HALF_PI, HALF_PI+PI)), 400*sin(map(emotion_, 0, 5, -HALF_PI, HALF_PI+PI)));
    emotion=emotion_+1;
    clr = emotionClrs[emotion_];
  }

  void updateEmotion(int newEmotion){
    emotion = newEmotion;
  }

  void display() {
    colorMode(HSB);
    fill(clr);
    float r=60+amplitude*100;
    ellipse(loc.x, loc.y, r, r); 
    fill(255);
    textAlign(CENTER, CENTER);
    textSize(50);
    //text(emotion, loc.x, loc.y);
    if (state == 1) ellipse(loc.x, loc.y, 20, 20);
  }
}