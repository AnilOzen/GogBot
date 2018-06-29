import processing.serial.*;
import processing.sound.*;

Network network;
Communication communication;
Server server;
Sound sound;
Amplitude amp;

Animation animation;

Serial[] arduinoPorts = new Serial[5]; // Led-Arduion ports
Serial sPort; // Switchboard port

void setup() {
  size(800, 800, FX2D);
  //fullScreen(FX2D);
  pixelDensity(1);
  
  
  sPort = new Serial(this, Serial.list()[0], 9600);
  //arduinoPorts[0] = new Serial(this, Serial.list()[35], 19200);
  //arduinoPorts[1] = new Serial(this, Serial.list()[36], 19200);
  //arduinoPorts[2] = new Serial(this, Serial.list()[37], 19200);
  //arduinoPorts[3] = new Serial(this, Serial.list()[33], 19200);
  //arduinoPorts[4] = new Serial(this, Serial.list()[34], 19200);

  communication = new Communication();
  network = new Network();
  //server = new Server(); // The app server

  loadSoundFiles();
  sound = new Sound();
  amp = new Amplitude(this);
}

void draw() {
  network.run();
  sound.run();

  communication.readSwitchBoard();
  communication.writeSwitchBoard();
  //communication.writeArduinos();
}

void mousePressed() {
  network.mousePress();
}

void keyPressed() {
  if(key == ' ') network.reset();
}