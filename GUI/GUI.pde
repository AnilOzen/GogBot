import processing.serial.*;
import processing.sound.*;

Network network;
Communication communication;
Server server;
Sound sound;
Amplitude amp;

void setup() {
  //size(800, 800);
  fullScreen();
  pixelDensity(1);
  //network = new Network(new Serial(this, Serial.list()[0], 9600)); // Uncommented for testing
  //communication = new Communication(new Serial(this,Serial.list()[0], 9600)); // Uncommented for testing
  communication = new Communication(null);
  network = new Network(null);

  //the port name will be different from this most likely. This is for mac
  //Serial switchPort = new Serial(this, "/dev/cu.usbmodem1421", 9600);

  //server = new Server();
  
  loadSoundFiles();
  sound = new Sound();

  amp = new Amplitude(this);
}

void draw() {
  network.run();
  sound.run();
  
  //communication.readSwitchBoard();
  //communication.writeSwitchBoard();
}

void mousePressed() {
  network.mousePress();
}