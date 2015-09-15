// Interactive Digital Multimedia Techniques
// Queen Mary University of London, 2014

// This is a global variable: it holds its value across different
// calls to draw() and can be accessed in any function.
int position;

void setup() {
  size(800, 600);
  background(128);
  
  // Start position at 0. Could also put this above ("int position = 0;")
  position = 0;
}

void draw() {
  fill(0);      // fill changes the color of the interior of the shape
  noStroke();   // noStroke removes the outer line

  // Does position represent the horizontal or the vertical location?
  ellipse(position, 300, 30, 30);
  
  // By changing position from one frame to the next, we animate the shape
  position += 40;
}

