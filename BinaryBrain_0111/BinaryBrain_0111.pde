import netP5.*;
import oscP5.*;
import ketai.net.*;
import ketai.ui.*;

ArrayList<Button> buttons = new ArrayList<Button>();
KetaiList selectionlist;
boolean submit=false;
float[] data = {3, 4, 5};
OscP5 oscP5;
NetAddress remoteLocation;
String myIPAddress; 
String remoteAddress = "130.89.235.191";

void setup() {
  orientation(PORTRAIT);
  textAlign(CENTER, CENTER);
  textSize(35);
  initNetworkConnection();
  buttons.add(new Button(width/2, height/2-200, 300, 150));
  buttons.add(new Button(width/2, height/2, 300, 150));
  buttons.add(new Button(width/2, height/2+200, 300, 150));
}

void draw() {
  background(0, 0, 0);

  for (Button b : buttons) b.run();

  OscMessage myMessage = new OscMessage("data");
  myMessage.add(data[0]); //(5)
  myMessage.add(data[1]);
  myMessage.add(data[2]);
  myMessage.add(myIPAddress);
  oscP5.send(myMessage, remoteLocation); 

  drawUI();

  if (submit) {
    initNetworkConnection();
    submit=false;
  }
}

void oscEvent(OscMessage theOscMessage) {
  if (theOscMessage.checkTypetag("iii")) 
  {
  }
}

void initNetworkConnection()
{
  oscP5 = new OscP5(this, 12000); 
  remoteLocation = new NetAddress(remoteAddress, 12000); 
  myIPAddress = KetaiNet.getIP();
}

void mousePressed() {
  if (mouseY < 100) if (mouseX < width/3) KetaiKeyboard.toggle(this);
  for (Button b : buttons) b.mousePress();
  if (mouseY>height-100) {
    data[0]=buttons.get(0).dat;
    data[1]=buttons.get(1).dat;
    data[2]=buttons.get(2).dat;
  }
}


void drawUI() {
  pushStyle();
  textAlign(LEFT);
  fill(40, 100, 255);
  noStroke();
  rect(0, 0, width/3, 100);
  fill(255);
  text("ENTER IP", 5, 60); 
  text(remoteAddress, width/3+30, 60);
  fill(50, 255, 100);
  rect(0, height-100, width, 100);
  fill(255);
  textAlign(CENTER, CENTER);
  text("SUBMIT", width/2, height-50);
  popStyle();
}

void keyPressed() {
  if ((int)key == 65535 && (int)keyCode == 67) {
    if (remoteAddress.length() > 0) {
      remoteAddress = remoteAddress.substring(0, remoteAddress.length()-1);
    }
  } else if (key==10) {
    submit=true;
  } else {
    remoteAddress = remoteAddress + key;
  }
}