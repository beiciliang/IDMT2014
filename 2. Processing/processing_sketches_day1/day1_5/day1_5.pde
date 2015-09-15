// Interactive Digital Multimedia Techniques
// Queen Mary University of London, 2014

void setup() {
  size(800, 600);
  background(128);
}

void draw() {
  fill(0);      // fill changes the colour of the interior of the shape
  stroke(255);  // stroke changes the colour of the border of the shape
  
  // What colours will the above lines produce?
  
  // By default, rectMode is CORNER. Parameters:
  // (X, Y) for upper left corner, width, height
  rect(100, 100, 200, 300);
}

