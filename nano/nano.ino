// base code for the Arduino nano written by Jan-Paul Konijn. The code will form a base for the Gogbot interactive art festival. To the arduino nano a analogstrip will be connected, as well as, digital ledstrip.
//The will be one way communication from a main pc. And the network of arduino will act as a slave network. That will only control.


#include <Adafruit_NeoPixel.h>    // library for the rgbstrip 
#define leddatapin 6

#define redpin  11         //rgb analogstrip pins initialization.
#define bluepin  10
#define greenpin  9

#define NUM_LEDS   60
#define BRIGHTNESS  255
#define METO_SIZE 8

#define RED 0xFF0000
#define YELLOW 0xFFFF00
#define GREEN 0x008000
#define PURPLE 0x800080
#define BLUE 0x0000FF

byte rr = 0xff;
byte gg = 0xff;
byte bb = 0xff;

int currentValue = 0;
int values[3] = {0,0,0};

int a_BLUE;
char val;

Adafruit_NeoPixel strip = Adafruit_NeoPixel(NUM_LEDS, leddatapin, NEO_GRB + NEO_KHZ800);

void setup() {

  Serial.begin(9600);
  strip.begin();
  strip.setBrightness(BRIGHTNESS);
  strip.show();

  pinMode(redpin, OUTPUT);
  pinMode(bluepin, OUTPUT);
  pinMode(greenpin, OUTPUT);
  pinMode(3, OUTPUT);

}
void loop() {
  communication();
  control();
}



void showStrip() {
  strip.show();
}
void color_strip(uint32_t  color, int brightness) {

  for (int i = 0; i < NUM_LEDS;  i++) {
    strip.setBrightness(brightness);
    strip.setPixelColor(i, color);
  }
  showStrip();
}


void color_rgbstrip(int r, int g, int b) {
  analogWrite(redpin, r);
  analogWrite(bluepin, b);
  analogWrite(greenpin, g);
}

void setPixel(int Pixel, byte red, byte green, byte blue) {
  strip.setPixelColor(Pixel, strip.Color(red, green, blue));
}

void meteorRain(byte red, byte green, byte blue, byte meteorSize, byte meteorTrailDecay, boolean meteorRandomDecay, int SpeedDelay) {
  for (int i = 0; i < NUM_LEDS + NUM_LEDS; i++) {
    // fade brightness all LEDs one step
    for (int j = 0; j < NUM_LEDS; j++) {
      if ( (!meteorRandomDecay) || (random(10) > 5) ) {
        fadeToBlack(j, meteorTrailDecay );
      }
    }
    // draw meteor
    for (int j = 0; j < meteorSize; j++) {
      if ( ( i - j < NUM_LEDS) && (i - j >= 0) ) {
        setPixel(i - j, red, green, blue);
      }
    }
    showStrip();
    delay(SpeedDelay);
  }
}

void fadeToBlack(int ledNo, byte fadeValue) {

  uint32_t oldColor;
  uint8_t r, g, b;
  int value;

  oldColor = strip.getPixelColor(ledNo);
  r = (oldColor & 0x00ff0000UL) >> 16;
  g = (oldColor & 0x0000ff00UL) >> 8;
  b = (oldColor & 0x000000ffUL);

  r = (r <= 10) ? 0 : (int) r - (r * fadeValue / 256);
  g = (g <= 10) ? 0 : (int) g - (g * fadeValue / 256);
  b = (b <= 10) ? 0 : (int) b - (b * fadeValue / 256);

  strip.setPixelColor(ledNo, r, g, b);
}

//void communication2() {
//  while (Serial.available()) {
//    String incomingValue = Serial.readStringUntil('\n');
//    if ( incomingValue.length() > 0) {
//      //      Serial.println(incomingValue.charAt(0));
//      values[0] = String(incomingValue.charAt(0)).toInt();
//
//      incomingValue = "";
//      delay(10);
//    }
//  }
//  if (values[0] == 1) {
//    analogWrite(3, 255);
//  } else {
//    analogWrite(3, 0);
//  }
//
//}


/*
  while (Serial.available()) {
    String incomingValue = Serial.readStringUntil('\n');
    if( incomingValue.length() > 0) {
      Serial.println(incomingValue.charAt(0));
      values[0]= String(incomingValue.charAt(0)).toInt();
      values[1]= String(incomingValue.charAt(1)).toInt();
      values[2]= incomingValue.substring(2,5).toInt();
      incomingValue ="";
      delay(10);
    }
  }
*/
void communication() {
  String inputread = "";
  if (Serial.available())
  { // If data is available to read,
    do {
       val = Serial.read(); // read it and store it in val
      if (val != -1) {
        inputread = inputread + val;
      }
      
    }
    while( val != -1);
  }

  if ( inputread.length() == 5) {
    values[0] = String(inputread.charAt(0)).toInt();
    values[1] = String(inputread.charAt(1)).toInt();
    values[2] = inputread.substring(2).toInt(); //from char(2) until the end
  }

  delay(10); //TODO We need to check if this is actually necessary
}


void control() {

  if (values[0] == 1) {

    switch (values[1]) {
      case 1:   //red
        color_rgbstrip(values[2], 0, 0);              //red
        break;
      case 2:
        color_rgbstrip(values[2], values[2], 0);             //yellow
        break;
      case 3:
        color_rgbstrip(values[2], 0, values[2]);             //purple
        break;
      case 4:
        color_rgbstrip(0, values[2], 0);              // green
        break;
      case 5:
        color_rgbstrip(0, 0, values[2]);               //blue
        break;
    }

  } else if ( values[0] == 2) {

    switch (values[1]) {
      case 1:
        color_strip(RED, 255);              //red
        break;
      case 2:
        color_strip(YELLOW, 255);             //yellow
        break;
      case 3:
        color_strip(PURPLE, 255);             //purple
        break;
      case 4:
        color_strip(GREEN, 255);              // green
        break;
      case 5:
        color_strip(BLUE, 255);              //blue
        break;
    }
  } else if (values[0] == 3) {

    int zz = random(1, 6);
    if ( zz != 5) {
      rr = 0xff;
      gg = 0xff;
      bb = 0xff;
    }
    else {
      rr = 0xff;
      gg = 0x00;
      bb = 0x00;
    }
    meteorRain( rr, gg, bb, METO_SIZE, random(60, 150), true, 50);
  }
}










