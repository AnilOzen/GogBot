// base code for the Arduino nano written by Jan-Paul Konijn. The code will form a base for the Gogbot interactive art festical 
#include <Adafruit_NeoPixel.h>

#define leddatapin 6 
#define redpin  11
#define bluepin  10
#define greenpin  9
#define NUM_LEDS   28
#define BRIGHTNESS  225
#define METO_SIZE 8 

int brightness = 0;    // how bright the LED is
int fadeAmount = 1; 

Adafruit_NeoPixel strip = Adafruit_NeoPixel(NUM_LEDS, leddatapin, NEO_GRB + NEO_KHZ800);



void setup() {
Serial.begin(9600);
strip.begin();
strip.setBrightness(BRIGHTNESS);
strip.show();

pinMode(redpin,OUTPUT);
pinMode(bluepin,OUTPUT);
pinMode(greenpin, OUTPUT);


}

void loop(){
byte rr = 0xff;
byte gg = 0xff;
byte bb = 0xff;

int zz = random(1,6);
                                                  //Serial.println(zz);
                                                //change rgb hex values for different color random meteor
if( zz != 5){
  rr = 0xff;
  gg = 0xff;
  bb = 0xff;
}
else {
  rr = 0xff;
  gg = 0x00;
  bb = 0x00;  

}

 brightness = brightness + fadeAmount;

                                              
  if (brightness <= 0 || brightness >= 255) {
    fadeAmount = -fadeAmount;
    delay(500);
                                                                    // meteorRain( rr, gg, bb, METO_SIZE, random(60,150), true, 50);
                                                                     // meteorRain(byte red, byte green, byte blue, byte meteorSize, byte meteorTrailDecay, boolean meteorRandomDecay, int SpeedDelay)
  }
 color_strip(255,255,0,brightness);
}



void communication(){
  if(Serial.available()>0){

    
  }
}
void color_rgbstrip(){

 analogWrite(redpin,255);
 analogWrite(bluepin,255);
 analogWrite(greenpin,255);
}




void color_strip(byte red, byte green, byte blue, int brightness){

  for(int i = 0; i <NUM_LEDS;  i++){
    strip.setBrightness(brightness);
    strip.setPixelColor(i, strip.Color(red, green, blue));
    
    
  }
  showStrip();
}

void showStrip() {
   strip.show();
   
}

void setPixel(int Pixel, byte red, byte green, byte blue) {
    strip.setPixelColor(Pixel, strip.Color(red, green, blue));
  }

void meteorRain(byte red, byte green, byte blue, byte meteorSize, byte meteorTrailDecay, boolean meteorRandomDecay, int SpeedDelay) {  
  
  
  for(int i = 0; i < NUM_LEDS+NUM_LEDS; i++) {
    
    
    // fade brightness all LEDs one step
    for(int j=0; j<NUM_LEDS; j++) {
      if( (!meteorRandomDecay) || (random(10)>5) ) {
        fadeToBlack(j, meteorTrailDecay );        
      }
    }
    
    // draw meteor
    for(int j = 0; j < meteorSize; j++) {
      if( ( i-j <NUM_LEDS) && (i-j>=0) ) {
        setPixel(i-j, red, green, blue);
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

    r=(r<=10)? 0 : (int) r-(r*fadeValue/256);
    g=(g<=10)? 0 : (int) g-(g*fadeValue/256);
    b=(b<=10)? 0 : (int) b-(b*fadeValue/256);
    
     strip.setPixelColor(ledNo, r,g,b);
    }








