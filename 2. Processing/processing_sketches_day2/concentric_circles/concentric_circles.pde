// Example 05-02 from "Getting Started with Processing" 
// by Reas & Fry. O'Reilly / Make 2010

void setup() {
  size(800, 600);
  background(128);
}

void draw() {
  // Draw the background (gray)
  background(128);
  
  // Call our function and pass arguments
  concentricCircles(400, 300, 200);
}

// This function draws 10 concentric circles at the given
// location (x,y), with the largest diameter given in the
// third argument
void concentricCircles(float x, float y, float diameter) {
  float currentDiameter;
  float fillColor = 0;
  
  noStroke();  // Turn off the stroke around the outside of the circle
  
  // Draw 10 concentric circles of varying shades of gray
  // FIXME: there's a bug in this code.  What is it?
  for(currentDiameter = diameter; currentDiameter >= 0;
      currentDiameter -= (diameter/10.0)) {
      fill(fillColor);
      ellipse(x, y, currentDiameter, currentDiameter);
      fillColor += 20;
  }
}

