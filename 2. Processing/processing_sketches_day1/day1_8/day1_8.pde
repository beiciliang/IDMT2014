// Interactive Digital Multimedia Techniques
// Queen Mary University of London, 2014

int position;

void setup() {
  size(800, 600);
  background(128);
  position = 0;
}

void draw() {
  // *** This is the important line:
  background(128);
  // By redrawing the background each call to draw(), the shape no longer
  // leaves behind copies of itself as it moves
  
  fill(0);      // fill changes the color of the interior of the shape
  noStroke();   // noStroke removes the outer line

  // Does position represent the horizontal or the vertical location?
  ellipse(position, 300, 30, 30);
  
  // Move more slowly than the last sketch...
  position += 2;
}

