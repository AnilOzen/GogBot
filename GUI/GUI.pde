import processing.serial.*;

Network network;
Communication communication;
Server server;

void setup() {
  size(800, 800);
  //network = new Network(new Serial(this, Serial.list()[0], 9600)); // Uncommented for testing
  //communication = new Communication(new Serial(this,Serial.list()[1], 9600)); // Uncommented for testing
  network = new Network(null);
  communication = new Communication(null);
  server = new Server();
}

void draw() {
  network.run();
}

void mousePressed() {
  network.mousePress();
}