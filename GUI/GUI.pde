import processing.serial.*;
import processing.sound.*;

Network network;
Communication communication;
Server server;
Sound sound;
Amplitude amp;

Serial[] arduinoPorts = new Serial[5]; // Led-Arduion ports
Serial sPort; // Switchboard port

void setup() {
  size(800, 800);
  //fullScreen();
  pixelDensity(1);

  //sPort = new Serial(this, Serial.list()[0], 9600);
  //arduinoPorts[0] = new Serial(this, Serial.list()[1], 9600);
  //arduinoPorts[0] = new Serial(this, Serial.list()[2], 9600);
  //arduinoPorts[0] = new Serial(this, Serial.list()[3], 9600);
  //arduinoPorts[0] = new Serial(this, Serial.list()[4], 9600);
  //arduinoPorts[0] = new Serial(this, Serial.list()[5], 9600);

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
  if (keyPressed && key == 'r') network.reset();

  //communication.readSwitchBoard();
  //communication.writeSwitchBoard();
  //communication.writeArduinos();
}

void mousePressed() {
  network.mousePress();
}