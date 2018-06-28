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

SoundFile[] ambients = new SoundFile[3];
SoundFile intro, intro2;
SoundFile hint1, hint2;

/*
jarco - lefika
 anil - radhika
 julia - hannah
 */

void loadSoundFiles() { // Load all soundfiles. This is executed in setup().
  round1=new SoundFile[]{new SoundFile(this, "1/lefika_1_happy.mp3"), new SoundFile(this, "1/thiemen_1_sad.mp3"), new SoundFile(this, "1/jp_1_angry.mp3"), new SoundFile(this, "1/radhika_1_neutral.mp3"), new SoundFile(this, "1/hannah_1_passionate.mp3")};
  round2=new SoundFile[][]{
    {new SoundFile(this, "2/lefika_2_happy.mp3"), new SoundFile(this, "2/thiemen_2_happy.mp3"), new SoundFile(this, "2/jp_2_happy.mp3"), new SoundFile(this, "2/radhika_2_happy.mp3"), new SoundFile(this, "2/hannah_2_happy.mp3")}, 
    {new SoundFile(this, "2/lefika_2_sad.mp3"), new SoundFile(this, "2/thiemen_2_sad.mp3"), new SoundFile(this, "2/jp_2_sad.mp3"), new SoundFile(this, "2/radhika_2_sad.mp3"), new SoundFile(this, "2/hannah_2_sad.mp3")}, 
    {new SoundFile(this, "2/lefika_2_angry.mp3"), new SoundFile(this, "2/thiemen_2_angry.mp3"), new SoundFile(this, "2/jp_2_angry.mp3"), new SoundFile(this, "2/radhika_2_angry.mp3"), new SoundFile(this, "2/hannah_2_angry.mp3")}, 
    {new SoundFile(this, "2/lefika_2_neutral.mp3"), new SoundFile(this, "2/thiemen_2_neutral.mp3"), new SoundFile(this, "2/jp_2_neutral.mp3"), new SoundFile(this, "2/radhika_2_neutral.mp3"), new SoundFile(this, "2/hannah_2_neutral.mp3")}, 
    {new SoundFile(this, "2/lefika_2_passionate.mp3"), new SoundFile(this, "2/thiemen_2_passionate.mp3"), new SoundFile(this, "2/jp_2_passionate.mp3"), new SoundFile(this, "2/radhika_2_passionate.mp3"), new SoundFile(this, "2/hannah_2_passionate.mp3")} 
  };
  round3=new SoundFile[][]{
    {new SoundFile(this, "3/lefika_3_happy.mp3"), new SoundFile(this, "3/thiemen_3_happy.mp3"), new SoundFile(this, "3/jp_3_happy.mp3"), new SoundFile(this, "3/radhika_3_happy.mp3"), new SoundFile(this, "3/hannah_3_happy.mp3")}, 
    {new SoundFile(this, "3/lefika_3_sad.mp3"), new SoundFile(this, "3/thiemen_3_sad.mp3"), new SoundFile(this, "3/jp_3_sad.mp3"), new SoundFile(this, "3/radhika_3_sad.mp3"), new SoundFile(this, "3/hannah_3_sad.mp3")}, 
    {new SoundFile(this, "3/lefika_3_angry.mp3"), new SoundFile(this, "3/thiemen_3_angry.mp3"), new SoundFile(this, "3/jp_3_angry.mp3"), new SoundFile(this, "3/radhika_3_angry.mp3"), new SoundFile(this, "3/hannah_3_angry.mp3")}, 
    {new SoundFile(this, "3/lefika_3_neutral.mp3"), new SoundFile(this, "3/thiemen_3_neutral.mp3"), new SoundFile(this, "3/jp_3_neutral.mp3"), new SoundFile(this, "3/radhika_3_neutral.mp3"), new SoundFile(this, "3/hannah_3_neutral.mp3")}, 
    {new SoundFile(this, "3/lefika_3_passionate.mp3"), new SoundFile(this, "3/thiemen_3_passionate.mp3"), new SoundFile(this, "3/jp_3_passionate.mp3"), new SoundFile(this, "3/radhika_3_passionate.mp3"), new SoundFile(this, "3/hannah_3_passionate.mp3")} 
  };
  intro = new SoundFile(this, "intro/intro1.wav");
  intro2 = new SoundFile(this, "intro/intro2.wav");
  //intro.play();
  ambients=new SoundFile[]{new SoundFile(this, "ambient/1.mp3"), new SoundFile(this, "ambient/2.mp3"), new SoundFile(this, "ambient/3.mp3")};
  for (int i=0; i<ambients.length; i++) ambients[i].amp(0.05);
  ambients[0].play();
  
  hint1= new SoundFile(this, "hints/start.mp3");

  //float amp = 5; // Increase the volume of the soundfiles a bit
  //for (SoundFile s : round1) s.amp(amp);
  //for (int i=0; i<round2[0].length; i++) for (SoundFile s : round2[i]) s.amp(amp);
  //for (int i=0; i<round3[0].length; i++) for (SoundFile s : round3[i]) s.amp(amp);
}

class Sound {
  boolean startTalking = false;

  boolean talking = false;
  int[] activeBrains = {0, 0, 0};
  int index = 0;

  float timer = 0;
  float timerReset = 0;

  int currentRound = 1;
  float talkDelay = 1.5; // How many seconds between te lines

  boolean introBool = false;
  boolean introBool2 = false;
  long intro2secs = 0;

  boolean finished = false;

  void run() {
    if (network.secs > intro.duration() && !introBool && (communication.latestMessage.charAt(7)=='0' || keyPressed)) {
      introBool=true;
      intro2.play();
      intro2secs = network.secs;
    }
    if (network.secs-intro2secs > intro2.duration() && !introBool2 && introBool) {
      introBool2=true;
      println("FINISHED INTRO");
    }

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
        network.brains.get(activeBrains[index]).amplitude=constrain(amp.analyze()*5,0,1); // Pass the amplitude of the current sound to the brains
        timer = (millis()-timerReset)/1000.00- ((index==2) ? 0 : talkDelay); // Update the timer
        // If the file has ended
        if ((currentRound==1 && round1[network.brains.get(activeBrains[index]).emotion-1].duration()<timer) || (currentRound==2 && round2[network.brains.get(activeBrains[index]).emotion-1][activeBrains[index]].duration()<timer) || (currentRound==3 && round3[network.brains.get(activeBrains[index]).emotion-1][activeBrains[index]].duration()<timer)) {
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
        if (currentRound==4) finished=true;
        currentRound = min(currentRound, 3); // For testing
        ambients[currentRound-2].stop();
        ambients[currentRound-1].amp(0.03);
        ambients[currentRound-1].play();
      }
    }
  }

  void talk(int brainIndex, int emotion) {
    SoundFile s = (currentRound == 1) ? round1[emotion-1] : ((currentRound==2) ? round2[emotion-1][brainIndex] : round3[emotion-1][brainIndex]); // Get the correct soundfile
    s.play(); // Start playing the soundfile
    amp.input(s); // Start analyzing the amplitude of the soundfile
  }
}