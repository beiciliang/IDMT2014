// Interactive Digital Multimedia Techniques
// Queen Mary University of London, 2014
int totalSize = 0;
boolean doTheNextThing = true;
float centreX = width/2, centreY = height/2;

void setup() {
  size(400, 400);
}

void draw() {
  background(100);
 
  // Draw a nifty explosion that gets bigger over time
  goBoom();
}

void goBoom() {
  ellipseMode(CENTER);
  
  // BUG! Why won't this work as planned?
  //for(totalSize = 0; totalSize < 100; totalSize++) {
  if(totalSize < 100){
    float yellowValue = map(totalSize, 0, 100, 0, 255);
    float diameter = map(totalSize, 0, 100, 0, 300);
    
    fill(255, yellowValue, 0);
    ellipse(centreX, centreY, diameter, diameter);
    
    totalSize++;
  }
  else if(doTheNextThing){
    rect(0, 0, 100, 100);
    
    doTheNextThing = false;
  }
}

void mousePressed(){
  totalSize = 0;
  doTheNextThing = true;
  centreX = mouseX;
  centreY = mouseY;
}
