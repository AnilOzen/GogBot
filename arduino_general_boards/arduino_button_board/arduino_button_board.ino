
int buttonpins[] = {1, 2, 3, 4, 5};
int buttonvalues[5] = {};
char headers[] = {'T', 'R', 'F'};


//char HEADERS[];

void setup() {
  for (int i = 0; i < 5; i++) {


    pinMode(buttonpins[i], INPUT);
  }
  Serial.begin(9600);

}

void loop() {

}

void readvalues() {

  for ( int i = 0; i < 5; i++) {
    for (int y = 0; y < 5; y++) {
      buttonvalues[y] = digitalRead(buttonpins[i]);
    }
  }
}


void datasender() {
  if (millis() - previousm2 > 500) {
    previousm2 = millis();
    for (int z = 0; z < 3; z++) {
      Serial.print(headers[z]);
      Serial.println(data[z]);
    }
  }


