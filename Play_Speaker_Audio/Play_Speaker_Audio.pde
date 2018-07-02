import processing.net.*;
import processing.sound.*;

SoundFile intro;

Client c;
String input;
int x = 0, prevX = 0;

void setup() 
{
  size(450, 255);
  background(204);
  stroke(0);
  //frameRate(5); // Slow it down a little
  // Connect to the server's IP address and port
  c = new Client(this, "127.0.0.1", 12345); // Replace with your server's IP and port
  //  c = new Client(this, "10.53.246.56", 12345); // Replace with your server's IP and port
  intro = new SoundFile(this, "a.mp3");
}

void draw() 
{

  // Receive data from server
  if (c.available() > 0) {
    input = c.readString();
    if (input.length() == 1)
    {
      println(input);
      x = int(input);
      if (prevX == 0 && x == 1)
        intro.play();
      if (prevX == 1 && x == 0)
        intro.stop();

      prevX = x;
    }
  }
}
