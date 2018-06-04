import processing.serial.*;
import processing.sound.*;

Network network;
Communication communication;
Server server;
Sound sound;
Amplitude amp;

void setup() {
  size(800, 800);
  //network = new Network(new Serial(this, Serial.list()[0], 9600)); // Uncommented for testing
  communication = new Communication(new Serial(this,Serial.list()[0], 9600)); // Uncommented for testing
  network = new Network(null);

  //the port name will be different from this most likely. This is for mac
  //Serial switchPort = new Serial(this, "/dev/cu.usbmodem1421", 9600);
  //communication = new Communication(null);

  //server = new Server();

  // Load the soundfiles here
  String[] emotionNames = {"Happy", "Sad", "Angry", "Neutral", "Funny"};
  ArrayList<SoundFile> brainLines = new ArrayList<SoundFile>();
  for (int i=0; i<5; i++) brainLines.add(new SoundFile(this, emotionNames[i]+".mp3"));
  sound = new Sound(brainLines);
  
  amp = new Amplitude(this);
}

void draw() {
  network.run();
  sound.run();
  communication.readSwitchBoard();
  communication.writeSwitchBoard();
}

void mousePressed() {
  network.mousePress();
}