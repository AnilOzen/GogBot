/*
 1=Happy
 2=Sad
 3=Angry
 4=Neutral
 5=Funny
 */

class Network {
  ArrayList<Brain> brains = new ArrayList<Brain>();
  int totalBrains = 5;
  Serial bPort;

  int[][] results = { // Emotion table
    {1, 4, 3, 1, 5}, 
    {4, 2, 2, 2, 4}, 
    {3, 2, 3, 3, 1}, 
    {1, 2, 3, 4, 5}, 
    {5, 4, 1, 5, 5}};

  Network(Serial bPort_) { // brain port
    // Add new brains
    bPort=bPort_;
    for (int i=0; i<totalBrains; i++) brains.add(new Brain(i%5));
  }

  void run() {
    drawUI();
  }

  void drawUI() {
    // Fancy UI stuff
    translate(width/2, height/2);
    background(0);
    strokeWeight(10);
    stroke(127);
    for (Brain b : brains) for (Brain o : brains) line(b.loc.x, b.loc.y, o.loc.x, o.loc.y);
    noStroke();
    for (Brain b : brains) b.display();
    int total = 0;
    for (Brain b : brains) if (b.state==1) total++;
    if (total == 3) {
      noFill();
      stroke(255);
      beginShape();
      for (Brain b : brains) if (b.state==1) vertex(b.loc.x, b.loc.y);
      endShape(CLOSE);
    }
    colorMode(RGB);
    noStroke();
    fill(255, 0, 0);
    if (total==3) fill(0, 255, 0);
    ellipse(width/2-100, -height/2+100, 70, 70);
    fill(255);
    text(getTotalPoints(), -width/2+100, -height/2+100);
  }

  void mousePress() {
    // Count the number of selected brains
    int total = 0;
    for (Brain b : brains) if (b.state==1) total++;
    
    // Connect the brains, limit the maximum selected brains to 3
    for (Brain b : brains) if (dist(mouseX-width/2, mouseY-height/2, b.loc.x, b.loc.y)<30) b.state = (total<3) ? (b.state+1) %2 : 0;

    // Execute if the button is pressed and the total selected brains is 3
    if (dist(mouseX, mouseY, width-100, 100)<70 && total==3) {
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

    // Disable all of the connections
    for (Brain brain : brains) brain.state=0;
  }

  int getTotalPoints() { // Calculate total points
    int totalPoints=0;
    for (Brain b : brains) {
      if (b.emotion==1) totalPoints+=2; 
      if (b.emotion==2) totalPoints-=1; 
      if (b.emotion==3) totalPoints-=2; 
      if (b.emotion==4) totalPoints+=0; 
      if (b.emotion==5) totalPoints+=1;
    }
    return totalPoints;
  }
}