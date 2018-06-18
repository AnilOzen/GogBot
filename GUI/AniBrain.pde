class AniBrain {
  PVector[] prevLocs = new PVector[10];
  PVector loc; // Location on the screen, just for the GUI
  int state = 0; // If it is selected or not
  int emotion; // Current emotion
  int init = 0;
  int[] colors= {120, 50, 0, 235, 285}; // Hue color values
  float r;
  float d;

  AniBrain(int emotion_) {
    loc = new PVector(100*cos(map(emotion_, 0, 5, -HALF_PI, HALF_PI+PI)), 100*sin(map(emotion_, 0, 5, -HALF_PI, HALF_PI+PI)));
    for (int i=0; i<prevLocs.length; i++) prevLocs[i] = new PVector(0, 0);
    emotion = emotion_+1;
    init = emotion_;
  }

  void updateEmotion(int newEmotion) {
    emotion = newEmotion;
  }

  void display() {
    for (int i=prevLocs.length-1; i>0; i--) prevLocs[i].set(prevLocs[i-1]);
    prevLocs[0]= loc;
    colorMode(HSB);
    r = (state==1) ? lerp(r, 40, 0.15) : lerp(r, 120, 0.15);
    d = (f<1) ? 60 : (f>m)? lerp(d, 100, 0.08) : lerp(d, 60, 0.08);
    loc.set(r*cos(map(init, 0, 5, -HALF_PI, HALF_PI+PI)), r*sin(map(init, 0, 5, -HALF_PI, HALF_PI+PI)));
    for (int i=0; i<prevLocs.length; i++) {
      fill(colors[emotion-1]*255/360, 255, 255,map(i,0,prevLocs.length-1,150,10));
      ellipse(prevLocs[i].x, prevLocs[i].y, d, d);
    }
    fill(colors[emotion-1]*255/360, 255, 255);
    ellipse(loc.x, loc.y, d, d); 
    fill(255);
  }
}