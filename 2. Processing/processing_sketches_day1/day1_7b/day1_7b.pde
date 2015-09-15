// Interactive Digital Multimedia Techniques
// Queen Mary University of London, 2014

void setup() {
  size(800, 600);
  background(128);
}

void draw() {
  fill(0);      // fill changes the color of the interior of the shape
  noStroke();   // noStroke removes the outer line

  // This while() loop draws multiple shapes
  // Remember, you CANNOT use for() or while() for animation!

  int position = 0;
  while(position <= 800) {
    // Does position represent the horizontal or the vertical location?
    ellipse(position, 300, 30, 30);
    position += 40;
  }
}

