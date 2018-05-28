/*
 1=Happy
 2=Sad
 3=Angry
 4=Neutral
 5=Funny
 */

class Sound {
  ArrayList<SoundFile> brainLines = new ArrayList<SoundFile>();

  boolean startTalking = false;

  boolean talking = false;
  int[] activeBrains = {0, 0, 0};
  int index = 0;

  Sound(ArrayList<SoundFile> brainLines_) {
    brainLines=brainLines_;
  }

  void run() {
    if (startTalking) {
      int j=0;
      for (int i=0; i<network.totalBrains; i++) if (network.brains.get(i).state==1) {
        activeBrains[j]=i;
        j++;
      }
      startTalking = false;
      talking = true;
      talk(activeBrains[0], network.brains.get(activeBrains[0]).emotion);
    }
    if (talking) {
      if (brainLines.get(network.brains.get(activeBrains[0]).emotion).isPlaying()==1) {
        println("test");
        index++;
        talk(activeBrains[index], network.brains.get(activeBrains[index]).emotion);
      }
    }
  }

  void talk(int brainIndex, int emotion) {
    brainLines.get(emotion-1).play();
  }
}