import processing.serial.*;
import processing.sound.*;
import processing.net.*;

Server s;
Client c;

Network network;
Communication communication;
Sound sound;
Amplitude amp;

Animation animation;

Serial[] arduinoPorts = new Serial[5]; // Led-Arduion ports
Serial sPort; // Switchboard port

void setup() {
  size(800, 800, FX2D);
  //fullScreen(FX2D);
  pixelDensity(1);

  s = new Server(this, 12345); // Start a simple server on a port

  sPort = new Serial(this, Serial.list()[0], 9600);
  arduinoPorts[0] = new Serial(this, Serial.list()[35], 19200);
  arduinoPorts[1] = new Serial(this, Serial.list()[36], 19200);
  arduinoPorts[2] = new Serial(this, Serial.list()[34], 19200);
  arduinoPorts[3] = new Serial(this, Serial.list()[33], 19200);
  //arduinoPorts[4] = new Serial(this, Serial.list()[34], 19200);

  communication = new Communication();
  network = new Network();

  loadSoundFiles();
  sound = new Sound();
  amp = new Amplitude(this);
}

void draw() {


  network.run();
  sound.run();
  
  send(frameCount % 2);

  communication.readSwitchBoard();
  communication.writeSwitchBoard();
  communication.writeArduinos();
}

void send(int msg){
  s.write(msg +"");
}

void mousePressed() {
  network.mousePress();
}

void keyPressed() {
  if (key == ' ') network.reset();
}
