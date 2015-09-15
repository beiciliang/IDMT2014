// Interactive Digital Multimedia Techniques
// Queen Mary University of London, 2014

void setup() {
  size(800, 600);
  background(128);
}

void draw() {
  fill(0);      // fill changes the color of the interior of the shape
  stroke(255);  // stroke changes the color of the border of the shape
  
  // In mode CORNER, parameters are:
  // (X, Y) for upper left corner, width, height
  rectMode(CORNER);
  rect(100, 100, 200, 300);
  
  // In mode CENTER, parameters are:
  // (X, Y) for middle of shape, width, height
  rectMode(CENTER);
  fill(255);
  stroke(0);
  
  // What colour is this rectangle?
  
  rect(100, 100, 50, 50);
}

