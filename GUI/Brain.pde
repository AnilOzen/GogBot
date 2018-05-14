class Brain {
  PVector loc;
  int n;
  int state = 0;
  int emotion;
  int[] colors= {120,50,0,235,285};

  Brain(float x_, float y_, int n_) {
    loc=new PVector(x_,y_);
    n=n_;
    emotion=n+1;
  }
  
  void run(){
   colorMode(HSB);
   fill(colors[emotion-1]*255/360,255,255);
   ellipse(loc.x,loc.y,50,50); 
   fill(255);
   textAlign(CENTER,CENTER);
   textSize(40);
   text(emotion,loc.x,loc.y);
   if(state == 1) ellipse(loc.x,loc.y,20,20);
  }
}