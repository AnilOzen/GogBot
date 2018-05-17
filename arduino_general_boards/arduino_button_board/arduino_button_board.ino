//This code is for the Arduino button board.

//test

#include <Adafruit_NeoPixel.h>

#define BUTTON_PIN   6
#define PIXEL_PIN    6    // Digital IO pin connected to the NeoPixels.

#define PIXEL_COUNT 24
Adafruit_NeoPixel strip = Adafruit_NeoPixel(PIXEL_COUNT, PIXEL_PIN, NEO_GRB + NEO_KHZ800);
int buttonpins[] = {2, 4, 7, 8, 12};
int buttonvalues[5] = {};
char headers[] = {'X', 'Y', 'Z', 'U', 'V'};
int lightlocations[] = {1, 6, 11, 16, 21};
int interval = 500;
unsigned long previousm = 0;
char c;

//char HEADERS[];

void setup() {
  for (int i = 0; i < 5; i++) {
    pinMode(buttonpins[i], INPUT);
  }
  Serial.begin(9600);

  strip.begin();
  strip.show(); // Initialize all pixels to 'off'
}

void loop() {
  readvalues();
  datasender();
  communication();

  //  delay(1000);
  //
  //  buttonlight();
  //

}



void communication() {                //currently some testing.

  if (Serial.available() > 0) {


    c = Serial.read();

    if (c == 'R') {
      setwheelred();
    }

  } else if (c == 'G') {
    setwheelgreen();


  }
  else {
    theaterChaseRainbow(5000);
  }
}

void readvalues() {
  for ( int i = 0; i < 5; i++) {
    buttonvalues[i] = digitalRead(buttonpins[i]);
  }
}



void datasender() {
  if (millis() - previousm > interval) {
    previousm = millis();
    for (int z = 0; z < 5; z++) {
      Serial.print(headers[z]);
      Serial.println(buttonvalues[z]);

    }
  }

}
void setwheelred() {
  for ( int i = 0;  i < strip.numPixels(); i++) {
    strip.setPixelColor(i, 255, 0, 0);
  }
  strip.show();

}
void setwheelgreen() {
  for ( int i = 0;  i < strip.numPixels(); i++) {
    strip.setPixelColor(i, 0, 255, 0);
  }
  strip.show();


}


void buttonlight() {


  strip.setBrightness(255);
  for (int i = 0; i < 5; i++) {
    if (buttonvalues[i] == 1) {

      strip.setPixelColor(lightlocations[i], 255, 255, 255);

    } else {
      for (int x = 0; x < strip.numPixels(); x++) {
        strip.setPixelColor(i, 0, 0, 0);
      }

    }
    strip.show();



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

