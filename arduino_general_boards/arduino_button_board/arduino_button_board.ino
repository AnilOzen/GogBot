//This code is for the Arduino button board.



#include <Adafruit_NeoPixel.h>

#define BUTTON_PIN   6
#define PIXEL_PIN    6    // Digital IO pin connected to the NeoPixels.

#define PIXEL_COUNT 24
Adafruit_NeoPixel strip = Adafruit_NeoPixel(PIXEL_COUNT, PIXEL_PIN, NEO_GRB + NEO_KHZ800);
int buttonpins[] = {1, 2, 3, 4, 5};
int buttonvalues[5] = {};
char headers[] = {'X', 'y', 'Z', 'U', 'V'};
int interval = 500;
unsigned long previousm = 0;


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
         }strip.show();
      }
      

    }
 
}

