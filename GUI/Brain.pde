class Brain {
  PVector loc;
  int n;
  int state = 0;
  char emotion;
  

  Brain(float x_, float y_, int n_) {
    loc=new PVector(x_,y_);
    n=n_;
  }
  
  void run(){
   colorMode(HSB);
   fill(map(n,0,totalBrains,0,255),255,255);
   ellipse(loc.x,loc.y,50,50); 
   fill(255);
   if(state == 1) ellipse(loc.x,loc.y,20,20);
  }
}