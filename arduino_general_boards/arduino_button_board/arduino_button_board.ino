/*
  Arduino_button_board
  The code will function for the main buttonboard for the Gogbot installation.
  The circuit:
    Addresable led ring 24-bit
    6 buttons
  Jan-paul Konijn
  17-5-2018
*/

#include <Adafruit_NeoPixel.h>

#define PIXEL_PIN    6    // Digital IO pin connected to the NeoPixels.
#define PIXEL_COUNT 24

Adafruit_NeoPixel strip = Adafruit_NeoPixel(PIXEL_COUNT, PIXEL_PIN, NEO_GRB + NEO_KHZ800);

//buttonpins are ordered based on GUI. The top button is the first, the others increase clockwise.
int buttonpins[] = {2, 4, 7, 8, 12, 13};
int buttonvalues[7] = {};
int lightlocations[] = {0, 5, 10, 14, 19};
int long previousm;
int fadeAmount;
boolean checkpressed = false;
char command;
uint32_t d;


//11 bit represents the board state. odd bits are the status on if the persons are picked. Even numbers are their current emotions
//11. bit is the board state. 0 stands for selection 1 is for talking
/*
  1=Happy
  2=Sad
  3=Angry
  4=Neutral
  5=Funny
*/

int boardState[] = {0, 1,
                    0, 2,
                    0, 3,
                    0, 4,
                    0, 5
                   };

int emotions[] = { 4, 5, 1, 2, 3};
int amps[] = {0, 0, 0, 0, 0};

int emotionColors[5][3] = { // RGB values
  {0, 255, 0},
  {255, 255, 0},
  {255, 0, 0},
  {0, 0, 255},
  {255, 0, 255}
};


void setup() {
  for (int i = 0; i < 6; i++) pinMode(buttonpins[i], INPUT);
  Serial.begin(9600);
  strip.begin();
  strip.show(); // Initialize all pixels to 'off'
  strip.setBrightness(255);
}

void loop() {
  buttonlight();
  readvalues();
  sendData();
  receiveData();

  //buttonlightanimation(1);
  //rainbow(10);
}

void readvalues() {
  for ( int i = 0; i < 6; i++) buttonvalues[i] = 1 - digitalRead(buttonpins[i]);

  //the ordering of the buttons are not the same on board as the message
  boardState[0] = buttonvalues[3]; //pin 8
  boardState[1] = buttonvalues[4]; //pin 12
  boardState[2] = buttonvalues[0]; //pin 2
  boardState[3] = buttonvalues[1]; //pin 4
  boardState[4] = buttonvalues[2]; //pin 7
  boardState[5] = buttonvalues[5]; //pin 7
}


void sendData() {
  if (millis() - previousm > 20) {
    String msg = "S";
    previousm = millis();
    for (int z = 0; z < 5; z++) msg = msg + boardState[z];
    msg = msg + "B";
    msg = msg + boardState[5];
    Serial.println(msg);
  }
}

void receiveData() {
  if (Serial.available() > 0) {
    int n = Serial.read();
    if (n < 100) for (int i = 0; i < 5; i++) if (floor(n / 10) == i + 1) emotions[(i + 3) % 5] = n - 10 * floor(n / 10);
    if (n > 100) for (int i = 0; i < 5; i++) if (floor((n - 100) / 10) == i + 1) amps[(i + 3) % 5] = n - 100 - 10 * floor((n - 100) / 10);
  }
}

void buttonlight() {
  for (int i = 0; i < 5; i++) {
    if (buttonvalues[i] == 1) {
      int j = emotions[i] - 1;
      strip.setPixelColor(lightlocations[i], strip.Color(emotionColors[j][0]*(amps[i]/10.00), emotionColors[j][1]*(amps[i]/10.00), emotionColors[j][2]*(amps[i]/10.00)));
      strip.show();
    }
    if (buttonvalues[i] == 0) {
      strip.setPixelColor(lightlocations[i], 0, 0, 0);
      strip.show();
    }
  }
}








void color_strip(byte red, byte green, byte blue, int brightness) {
  for (int i = 0; i < PIXEL_COUNT;  i++) {
    strip.setBrightness(brightness);
    strip.setPixelColor(i, strip.Color(red, green, blue));
  }
  strip.show();
}

void color_stripBYTE(uint32_t x) {
  for (int i = 0; i < PIXEL_COUNT;  i++) {
    strip.setBrightness(255);
    strip.setPixelColor(i, x);
  }
  strip.show();
}



void buttonlightanimation(int value) {
  if (value == 1) {
    d = strip.Color(0, 0, 0);
  } else if (value == 2) {
    d = strip.Color(0, 255, 0);
  } else {
    d = strip.Color(255, 255, 255);
  }

  if (buttonvalues[5] == 1) {
    checkpressed = true;
    if (checkpressed) {
      buttonlight();
      delay(500);
      rainbow(1000);

      color_stripBYTE(d);
      buttonvalues[6] = 1;
    }
    else {
      for (int i = 0; i, strip.numPixels(); i++) {
        strip.setPixelColor(i, 255, 0, 0);
      }
      strip.show();
    }
  }
}

uint32_t Wheel(byte WheelPos) {
  WheelPos = 255 - WheelPos;
  if (WheelPos < 85) {
    return strip.Color(255 - WheelPos * 3, 0, WheelPos * 3);
  }
  if (WheelPos < 170) {
    WheelPos -= 85;
    return strip.Color(0, WheelPos * 3, 255 - WheelPos * 3);
  }
  WheelPos -= 170;
  return strip.Color(WheelPos * 3, 255 - WheelPos * 3, 0);
}

void rainbow(uint8_t wait) {
  for (int i = 0; i < strip.numPixels(); i++) {
    if (millis() % 1000 < 500) {
      strip.setPixelColor(i, Wheel(((i * 256 / strip.numPixels())) & 255));
      strip.show();
    } else {
      strip.setPixelColor((i + 4 + millis() / 1000) % strip.numPixels(), 0, 0, 0);
      strip.show();
    }
  }
}

void rainbowCycle(uint8_t wait) {
  uint16_t i, j;

  for (j = 0; j < 256 * 5; j++) { // 5 cycles of all colors on wheel
    for (i = 0; i < strip.numPixels(); i++) {
      strip.setPixelColor(i, Wheel(((i * 256 / strip.numPixels()) + j) & 255));
    }
    strip.show();
    delay(wait);
  }
}


void theaterChaseRainbow(uint8_t wait) {
  for (int j = 0; j < 256; j++) {   // cycle all 256 colors in the wheel
    for (int q = 0; q < 3; q++) {
      for (int i = 0; i < strip.numPixels(); i = i + 3) {
        strip.setPixelColor(i + q, Wheel( (i + j) % 255)); //turn every third pixel on
      } strip.show();
    }
  }
}

