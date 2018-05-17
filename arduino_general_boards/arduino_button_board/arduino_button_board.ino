//This code is for the Arduino button board.

//test

#include <Adafruit_NeoPixel.h>

#define PIXEL_PIN    6    // Digital IO pin connected to the NeoPixels.
#define PIXEL_COUNT 24

Adafruit_NeoPixel strip = Adafruit_NeoPixel(PIXEL_COUNT, PIXEL_PIN, NEO_GRB + NEO_KHZ800);

int buttonpins[] = {2, 4, 7, 8, 12, 13};
int buttonvalues[6] = {};
char headers[] = {'X', 'Y', 'Z', 'U', 'V', 'Q'};
int lightlocations[] = {0, 5, 10, 14, 19};
int interval = 500;
int long previousm;
int fadeAmount;
boolean checkpressed = true;
char command;

void setup() {

  for (int i = 0; i < 6; i++) {
    pinMode(buttonpins[i], INPUT);
  }

  Serial.begin(9600);

  strip.begin();
  strip.show(); // Initialize all pixels to 'off'
}

void loop() {

  //buttonlightanimation();
  // readvalues();
  //datasender();
  communication();

  //  delay(1000);
  //
  //  buttonlight();
  //

}



void communication() {                //currently some testing.

  while (Serial.available() > 0) {

    int value = Serial.parseInt();
    char command = Serial.read();

    if (command == 'R') {
      readvalues();
     // buttonlight(255);
     buttonlightanimation(255);
      //datasender();
    }
    if (command == 'G') {
    }

  }
}
void readvalues() {
  for ( int i = 0; i < 6; i++) {
    buttonvalues[i] = digitalRead(buttonpins[i]);
  }
}



void datasender() {
  if (millis() - previousm > interval) {
    previousm = millis();
    for (int z = 0; z < 6; z++) {
      Serial.print(headers[z]);
      Serial.println(buttonvalues[z]);
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


void buttonlightanimation(int value) {
  strip.setBrightness(value);

  if ( buttonvalues[5] == 1 && checkpressed) {
    for (int i = 0; i < 5; i++) {
      strip.setPixelColor(lightlocations[i], Wheel(((i * 256 / 5) + i) & 255));
      strip.show();
    }

    delay(1000);
    rainbow(1000);
    fadeAmount++;
    color_strip(255, 255, 255, 255);
    checkpressed = false;
    //    if ( fadeAmount < 0 || fadeAmount> 255) {
    //    fadeAmount * -1;
    //    }

  }


}









void buttonlight(int value) {

  for (int i = 0; i < 5; i++) {
    if (buttonvalues[i] == 1) {
      strip.setBrightness(value);
      strip.setPixelColor(lightlocations[i], Wheel(((i * 256 / 5) + i) & 255));
      //      strip.setPixelColor(lightlocations[i], 255, 255, 255);
      strip.show();
    }
    if (buttonvalues[i] == 0) {
      strip.setPixelColor(lightlocations[i], 0, 0, 0);
      strip.show();
    }

  }
  //strip.show();
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
  uint16_t i, j;


  for (i = 0; i < strip.numPixels(); i++) {
    strip.setPixelColor(i, Wheel(((i * 256 / strip.numPixels()) + j) & 255));
    strip.show();
    delay(wait);

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

