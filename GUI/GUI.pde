//For GogBot

import processing.serial.*;
import processing.sound.*;
//import processing.net.*;

//Server s;
//Client c;

Network network;
Communication communication;
Sound sound;
Amplitude amp;

Animation animation;

Serial[] arduinoPorts = new Serial[5]; // Led-Arduion ports
Serial sPort; // Switchboard port

int pstate = 0;

void setup() {
  size(800, 800, FX2D);
  //fullScreen(FX2D);
  pixelDensity(1);

  //s = new Server(this, 12345); // Start a simple server on a port

  sPort = new Serial(this, Serial.list()[0], 9600);
  arduinoPorts[0] = new Serial(this, Serial.list()[35], 19200);
  arduinoPorts[1] = new Serial(this, Serial.list()[36], 19200);
  arduinoPorts[2] = new Serial(this, Serial.list()[37], 19200);
  arduinoPorts[3] = new Serial(this, Serial.list()[33], 19200);
  arduinoPorts[4] = new Serial(this, Serial.list()[34], 19200);

  communication = new Communication();
  network = new Network();
  animation = new Animation();

  loadSoundFiles();
  sound = new Sound();
  amp = new Amplitude(this);
}

void draw() {
  if (pstate == 1) {
    network.run();
    sound.run();
  }

  if (pstate == 0) {
    background(0,255,0);
    textAlign(CENTER,CENTER);
    textSize(48);
    text("SYSTEM READY", width/2, height/2);
    for (int i=0; i<5; i++) communication.commandArduino(i, 2, 255, 255, 255);
    animation.reset();
    animation.a1 = true;
  }

  if (pstate == 0 && communication.latestMessage.charAt(7)=='0' && millis()>2000) {
    hint1.play();
    pstate = 1;
    network.secsRst = millis();
  }

  communication.readSwitchBoard();
  communication.writeSwitchBoard();

  if (pstate == 1) {
    if (sound.introBool2 && !sound.finished) communication.writeArduinos();
    if (!sound.introBool2) animation.run();
    if (sound.finished) animation.finito();
  }
}

void send(int msg) {
  println(msg);
}

void mousePressed() {
  network.mousePress();
}

void keyPressed() {
  if (key == ' ') network.reset();
}
