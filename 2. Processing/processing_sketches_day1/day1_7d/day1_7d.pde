// Interactive Digital Multimedia Techniques
// Queen Mary University of London, 2014

int position;

void setup() {
  size(800, 600);
  background(128);
  position = 0;
}

void draw() {
  fill(0);      // fill changes the color of the interior of the shape
  noStroke();   // noStroke removes the outer line

  // Does position represent the horizontal or the vertical location?
  ellipse(position, 300, 30, 30);
  
  // Same as previous sketch, but shape moves more slowly...
  // Notice that it leaves copies of itself behind as it goes
  position += 2;
}

