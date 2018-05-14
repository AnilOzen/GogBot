import processing.serial.*;

Brain person1, person2, person3, person4, person5;
Brain[] person;
int[] comPorts = {0,1,2,3,4,5 };

float prevmillis;

PApplet mainApplet = this;

void setup(){
  for(int i = 0; i < comPorts.length; i++){
    person[i] = new Brain(comPorts[i]);
  }
}

void draw(){
  for(int j = 0; j < comPorts.length; j++){
    person[j].run();
  }
}

boolean timer(float time) {                 //timer method 
  if (millis()-prevmillis>time*1000) {
    prevmillis= millis();
    return true;
  } else { 
    return false; 
    //returns true if the timer is within the set time
  }
}
