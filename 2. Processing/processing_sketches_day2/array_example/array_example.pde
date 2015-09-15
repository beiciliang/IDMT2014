// Interactive Digital Multimedia Techniques
// Queen Mary University of London, 2014

float[] grays = {0, 30, 60, 90, 120, 150, 180, 210};

void setup() {
  size(800, 600);
}


void draw() {
  background(128);
  noStroke();

  for(int i = 0 ; i < 8 ; i++) {
    fill(grays[i]);
    int xPosition = 50 + 100*i;
    ellipse(xPosition, 300, 50, 50);  
  }
  
  // The code below does the same thing
  // as the for() loop above:
  
  /*fill(grays[0]);
  ellipse(50, 300, 50, 50);
  fill(grays[1]);
  ellipse(150, 300, 50, 50);
  fill(grays[2]);
  ellipse(250, 300, 50, 50);
  fill(grays[3]);
  ellipse(350, 300, 50, 50);  
  fill(grays[4]);
  ellipse(450, 300, 50, 50);
  fill(grays[5]);
  ellipse(550, 300, 50, 50);
  fill(grays[6]);
  ellipse(650, 300, 50, 50);
  fill(grays[7]);
  ellipse(750, 300, 50, 50);  */  
}
