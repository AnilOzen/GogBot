import processing.serial.*;

Network network;
Server server;

ArrayList<Serial> ports = new ArrayList<Serial>();


void setup() {
  size(800, 800);
  //ports.add(new Serial(this, Serial.list()[0], 9600));
  network = new Network(ports);
  server = new Server();
}

void draw() {
  network.run();
}

void mousePressed() {
  network.mousePress();
}