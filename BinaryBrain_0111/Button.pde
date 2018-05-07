class Button {
  int x, y;
  int w, h;
  int dat = 1;

  Button(int x_, int y_, int w_, int h_){
    x=x_;
    y=y_;
    w=w_;
    h=h_;
  }

  void run() {
    rectMode(CENTER);
    fill(255);
    rect(x,y,w,h);
    rectMode(CORNER);
    fill(0);
    textAlign(CENTER,CENTER);
    text(dat,x,y);
  }
  
  void mousePress(){
   if(mouseX>x-w/2 && mouseX<x+w/2 && mouseY>y-h/2 && mouseY<y+h/2) dat++; 
   if(dat>3) dat = 1;
  }
}