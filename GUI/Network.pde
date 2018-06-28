/*
 1=Happy
 2=Sad
 3=Angry
 4=Neutral
 5=Passionate
 */

class Network {
  int state = 0;

  ArrayList<Brain> brains = new ArrayList<Brain>();
  int totalBrains = 5;
  long secs = 0;
  long secsRst = 0;

  int[][] results = { // Emotion table
    {1, 4, 3, 1, 5}, 
    {4, 2, 2, 2, 4}, 
    {3, 2, 3, 3, 1}, 
    {1, 2, 3, 4, 5}, 
    {5, 4, 1, 5, 5}};
  int[] emotionPoints = {1, -1, -2, 0, 2};

  ArrayList<Integer> buttonHist = new ArrayList<Integer>();

  Network() { // brain port
    for (int i=0; i<totalBrains; i++) brains.add(new Brain(i%5)); // Add the brains
    for (int i=0; i<10; i++) buttonHist.add(1);
  }

  void run() {
    if (state == 0) {
      if (secs > (hint1.duration()+2)) {
        secsRst = floor(millis()/1000);
        hint1.play();
      }
      if (frameCount % 5 == 0) {
        buttonHist.remove(0);
        buttonHist.add((communication.latestMessage.charAt(7)=='1') ? 1 : 0);
      }
      boolean pressed2secs = true;
      for (Integer i : buttonHist) if (i==1) pressed2secs = false;
      if (pressed2secs) begin();
    }
    secs = floor(millis()/1000)-secsRst;
    drawUI();
    if (communication.latestMessage.length()>0) {
      for (int i=0; i<totalBrains; i++) if (!sound.talking) brains.get(i).state = (communication.latestMessage.charAt(i+1)=='1') ? 1 : 0;
      int totalSelected = 0;
      for (Brain b : brains) if (b.state==1) totalSelected++;
      if (communication.latestMessage.charAt(7)=='0' && totalSelected==3 && !sound.talking && sound.introBool2 && !sound.finished) {
        intro.stop();
        sound.startTalking = true;
      }
    }
  }

  void drawUI() {
    // Fancy UI stuff
    translate(width/2, height/2);
    background(0);
    textSize(50);
    String str = "";
    for (int i=0; i<900; i++)str+=round(random(0, 1));
    fill(255, 30);
    text(str, -width/2, -height/2, width, height);
    strokeWeight(10);
    stroke(80);
    for (Brain b : brains) for (Brain o : brains) line(b.loc.x, b.loc.y, o.loc.x, o.loc.y);
    noStroke();
    for (Brain b : brains) b.display();
    int total = 0;
    for (Brain b : brains) if (b.state==1) total++;
    if (total == 3) {
      noFill();
      stroke(255, 180);
      beginShape();
      for (Brain b : brains) if (b.state==1) vertex(b.loc.x, b.loc.y);
      endShape(CLOSE);
    }
    colorMode(RGB);
    noStroke();
    fill((total==3) ? color(0, 255, 0) : color(255, 0, 0));
    ellipse(0, 0, 70, 70);

    for (int i=0; i<5; i++) {
      int[] cols= {285, 120, 235, 50, 0};
      colorMode(HSB);
      fill((cols[i]*255)/360, 255, 255);
      rect(-width/2+60, -height/2+60+i*40, 100, 40);
    }

    fill(255);
    rect(-width/2+60, -height/2+60+map(-(getTotalPoints()), -10, 10, 0, 200), 100, 10);
    text(getTotalPoints(), -width/2+200, -height/2+60+map(-(getTotalPoints()), -10, 10, 0, 200));

    fill(255);
    if (sound.introBool) text("ROUND: " + sound.currentRound, width/2-180, -height/2+100);
    if (!sound.introBool) text("Intro", width/2-180, -height/2+100);
    textSize(40);
    fill(255, 200);
    if (sound.introBool) text((sound.currentRound==1) ? "AI" : (sound.currentRound==2) ? "WW III" : "IDENTITY", width/2-180, -height/2+160);

    for (int i=0; i<5; i++) {
      int[] cols= {285, 120, 235, 50, 0};
      colorMode(HSB);
      fill((cols[i]*255)/360, 255, 255);
      ellipse(-width/2+50, height/2-250+i*40, 20, 20);
      fill(255, 200);
      textSize(20);
      textAlign(LEFT, CENTER);
      String[] emos = {"Passionate", "Happy", "Neutral", "Sad", "Angry"};
      text(emos[i], -width/2+80, height/2-250+i*40);
    }

    textAlign(CENTER, CENTER);
    textSize(100);
    if (sound.finished) text("DONE", 0, 0);
  }

  void mousePress() {
    // Count the number of selected brains
    int total = 0;
    for (Brain b : brains) if (b.state==1) total++;

    // Connect the brains, limit the maximum selected brains to 3
    for (Brain b : brains) if (dist(mouseX-width/2, mouseY-height/2, b.loc.x, b.loc.y)<30) b.state = (total<3) ? (b.state+1) %2 : 0;

    // Execute if the button is pressed and the total selected brains is 3
    if (dist(mouseX, mouseY, width/2, height/2)<70 && total==3) {
      //sound.startTalking = true;
      updateEmotions();
    }
  }

  void updateEmotions() {
    // Put the 3 brains in a new Array for easier accesability
    ArrayList<Brain> b = new ArrayList<Brain>();
    for (int i=0; i<totalBrains; i++) if (brains.get(i).state==1) b.add(brains.get(i));

    // For each brain in the 3-network, look up the combined emotion of the other brain and combine that combined emotion with the emotion of the brain you're checking
    // Store the new emotion in a variable first so the next calculations aren't messed up
    int combEmo0 = results[b.get(1).emotion-1][b.get(2).emotion-1];
    int newEmo0 = results[b.get(0).emotion-1][combEmo0-1];

    int combEmo1 = results[b.get(0).emotion-1][b.get(2).emotion-1];
    int newEmo1 = results[b.get(1).emotion-1][combEmo1-1];

    int combEmo2 = results[b.get(0).emotion-1][b.get(1).emotion-1];
    int newEmo2 = results[b.get(2).emotion-1][combEmo2-1];

    // Set the new emotions
    b.get(0).updateEmotion(newEmo0);
    b.get(1).updateEmotion(newEmo1);
    b.get(2).updateEmotion(newEmo2);
  }

  int getTotalPoints() { // Calculate total points
    int totalPoints=0;
    for (Brain b : brains) totalPoints+=emotionPoints[b.emotion-1]; // Get the points for each emotion from the emotionPoints array
    return totalPoints;
  }

  void reset() {
    for (int i=0; i<brains.size(); i++) brains.get(i).emotion = i+1;
    for (SoundFile s : round1) s.stop();
    for (int i=0; i<round2[0].length; i++) for (SoundFile s : round2[i]) s.stop();
    for (int i=0; i<round3[0].length; i++) for (SoundFile s : round3[i]) s.stop();
    sound.startTalking = false;
    sound.talking=false;
    sound.index=0;
    sound.currentRound=1;
    intro.stop();
    intro2.stop();
    for (Brain b : brains) b.amplitude=0;
    secsRst = floor(millis()/1000);
    //intro.play();
    sound.introBool = false;
    sound.finished=false;
    sound.introBool2 = false;
    sound.intro2secs = 0;
    state = 0;
    buttonHist = new ArrayList<Integer>();
    for(int i=0;i<10;i++) buttonHist.add(1);
  }

  void begin() {
    hint1.stop();
    reset();
    intro.play();
    state = 1;
  }
}