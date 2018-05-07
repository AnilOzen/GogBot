ArrayList<Brain> brains = new ArrayList<Brain>();

int totalBrains = 5;

void setup() {
  size(800, 800);
  for (int i=0; i<totalBrains; i++) {
    brains.add(new Brain(300*cos(map(i, 0, totalBrains, -HALF_PI, HALF_PI+PI)), 300*sin(map(i, 0, totalBrains, -HALF_PI, HALF_PI+PI)), i));
  }
}

void draw() {
  translate(width/2, height/2);
  background(0);
  strokeWeight(10);
  stroke(127);
  for (Brain b : brains) for (Brain o : brains) line(b.loc.x, b.loc.y, o.loc.x, o.loc.y);
  noStroke();
  for (Brain b : brains) b.run();
  int total = 0;
  for (Brain b : brains) if (b.state==1) total++;
  if(total == 3) {
    noFill();
    stroke(255);
    beginShape();
    for (Brain b: brains) if(b.state==1) vertex(b.loc.x,b.loc.y);
    endShape(CLOSE);
  }
}

void mousePressed() {
  int total = 0;
  for (Brain b : brains) if (b.state==1) total++;
  for (Brain b : brains) if (dist(mouseX-width/2, mouseY-height/2, b.loc.x, b.loc.y)<30) b.state = (total<3) ? (b.state+1) %2 : 0;
}