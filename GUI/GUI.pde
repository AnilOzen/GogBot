import processing.serial.*;

Network network;
Communication communication;
Server server;


void setup() {
  size(800, 800);
  //network = new Network(new Serial(this, Serial.list()[0], 9600)); // Uncommented for testing
  //communication = new Communication(new Serial(this,Serial.list()[1], 9600)); // Uncommented for testing
  network = new Network(null);

  //the port name will be different from this most likely. This is for mac
  Serial switchPort = new Serial(this, "/dev/cu.usbmodem1421", 9600);
  communication = new Communication(switchPort);

  //server = new Server();
}

void draw() {
  network.run();
  communication.readSwitchBoard();
}

void mousePressed() {
  network.mousePress();
}