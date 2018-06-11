/*
 1=Happy
 2=Sad
 3=Angry
 4=Neutral
 5=Passionate
 */

SoundFile[] round1 = new SoundFile[5];
SoundFile[][] round2 = new SoundFile[5][5];
SoundFile[][] round3 = new SoundFile[5][5];

void loadSoundFiles() { // Load all soundfiles. This is executed in setup().
  round1=new SoundFile[]{new SoundFile(this, "1/jarco_1_happy.mp3"), new SoundFile(this, "1/thiemen_1_sad.mp3"), new SoundFile(this, "1/jp_1_angry.mp3"), new SoundFile(this, "1/anil_1_neutral.mp3"), new SoundFile(this, "1/julia_1_passionate.mp3")};
  round2=new SoundFile[][]{
    {new SoundFile(this, "2/jarco_2_happy.mp3"), new SoundFile(this, "2/thiemen_2_happy.mp3"), new SoundFile(this, "2/jp_2_happy.mp3"), new SoundFile(this, "2/anil_2_happy.mp3"), new SoundFile(this, "2/julia_2_happy.mp3")}, 
    {new SoundFile(this, "2/jarco_2_sad.mp3"), new SoundFile(this, "2/thiemen_2_sad.mp3"), new SoundFile(this, "2/jp_2_sad.mp3"), new SoundFile(this, "2/anil_2_sad.mp3"), new SoundFile(this, "2/julia_2_sad.mp3")}, 
    {new SoundFile(this, "2/jarco_2_angry.mp3"), new SoundFile(this, "2/thiemen_2_angry.mp3"), new SoundFile(this, "2/jp_2_angry.mp3"), new SoundFile(this, "2/anil_2_angry.mp3"), new SoundFile(this, "2/julia_2_angry.mp3")}, 
    {new SoundFile(this, "2/jarco_2_neutral.mp3"), new SoundFile(this, "2/thiemen_2_neutral.mp3"), new SoundFile(this, "2/jp_2_neutral.mp3"), new SoundFile(this, "2/anil_2_neutral.mp3"), new SoundFile(this, "2/julia_2_neutral.mp3")}, 
    {new SoundFile(this, "2/jarco_2_passionate.mp3"), new SoundFile(this, "2/thiemen_2_passionate.mp3"), new SoundFile(this, "2/jp_2_passionate.mp3"), new SoundFile(this, "2/anil_2_passionate.mp3"), new SoundFile(this, "2/julia_2_passionate.mp3")} 
  };
  round3=new SoundFile[][]{
    {new SoundFile(this, "3/jarco_3_happy.mp3"), new SoundFile(this, "3/thiemen_3_happy.mp3"), new SoundFile(this, "3/jp_3_happy.mp3"), new SoundFile(this, "3/anil_3_happy.mp3"), new SoundFile(this, "3/julia_3_happy.mp3")}, 
    {new SoundFile(this, "3/jarco_3_sad.mp3"), new SoundFile(this, "3/thiemen_3_sad.mp3"), new SoundFile(this, "3/jp_3_sad.mp3"), new SoundFile(this, "3/anil_3_sad.mp3"), new SoundFile(this, "3/julia_3_sad.mp3")}, 
    {new SoundFile(this, "3/jarco_3_angry.mp3"), new SoundFile(this, "3/thiemen_3_angry.mp3"), new SoundFile(this, "3/jp_3_angry.mp3"), new SoundFile(this, "3/anil_3_angry.mp3"), new SoundFile(this, "3/julia_3_angry.mp3")}, 
    {new SoundFile(this, "3/jarco_3_neutral.mp3"), new SoundFile(this, "3/thiemen_3_neutral.mp3"), new SoundFile(this, "3/jp_3_neutral.mp3"), new SoundFile(this, "3/anil_3_neutral.mp3"), new SoundFile(this, "3/julia_3_neutral.mp3")}, 
    {new SoundFile(this, "3/jarco_3_passionate.mp3"), new SoundFile(this, "3/thiemen_3_passionate.mp3"), new SoundFile(this, "3/jp_3_passionate.mp3"), new SoundFile(this, "3/anil_3_passionate.mp3"), new SoundFile(this, "3/julia_3_passionate.mp3")} 
  };
}

class Sound {
  boolean startTalking = false;

  boolean talking = false;
  int[] activeBrains = {0, 0, 0};
  int index = 0;

  float timer = 0;
  float timerReset = 0;
  
  int currentRound = 1;
  float talkDelay = 2; // How many seconds between te lines

  void run() {
    if (startTalking) {
      int j=0;
      for (int i=0; i<network.totalBrains; i++) if (network.brains.get(i).state==1) { // Put the indexes of the 3 selected brains into an array for convenience.
        activeBrains[j]=i;
        j++;
      }
      startTalking = false;
      talking = true;
      timer = 0;
      timerReset=millis();
      talk(activeBrains[0], network.brains.get(activeBrains[0]).emotion); // Start talking
    }

    if (talking) {
      if (index<3) { // Once for each of the 3 brains
        network.brains.get(activeBrains[index]).amplitude=amp.analyze(); // Pass the amplitude of the current sound to the brains
        timer = (millis()-timerReset)/1000.00- ((index==2) ? 0 : talkDelay); // Update the timer
        // If the file has ended
        if ((currentRound==1 && round1[network.brains.get(activeBrains[index]).emotion-1].duration()<timer) || (currentRound==2 && round2[network.brains.get(activeBrains[index]).emotion-1][activeBrains[index]].duration()<timer)) {
          index++;
          if (index<3) {
            timerReset=millis();
            talk(activeBrains[index], network.brains.get(activeBrains[index]).emotion);
          }
        }
      } else {
        talking=false;
        index=0;
        for (int i=0; i<5; i++) network.brains.get(i).amplitude=0; // Set the amplitude to 0
        network.updateEmotions(); // Update the emotions
        currentRound++; // Proceed to the next round
        currentRound = min(currentRound, 3); // For testing
      }
    }
  }

  void talk(int brainIndex, int emotion) {
    SoundFile s = (currentRound == 1) ? round1[emotion-1] : ((currentRound==2) ? round2[emotion-1][brainIndex] : round3[emotion-1][brainIndex]); // Get the correct soundfile
    s.play(); // Start playing the soundfile
    amp.input(s); // Start analyzing the amplitude of the soundfile
  }
}