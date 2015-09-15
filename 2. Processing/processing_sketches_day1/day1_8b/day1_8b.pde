// Example 05-02 from "Getting Started with Processing" 
// by Reas & Fry. O'Reilly / Make 2010

int position;

void setup() {
  size(800, 600);
  background(128);
  position = 0;
}

void draw() {
  background(128);
  fill(0);      // fill changes the color of the interior of the shape
  noStroke();   // noStroke removes the outer line

  // Does position represent the horizontal or the vertical location?
  ellipse(position, 300, 30, 30);
  position += 0.5;
}

