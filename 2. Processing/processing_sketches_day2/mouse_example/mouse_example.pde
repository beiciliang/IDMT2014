// Example 05-05 from "Getting Started with Processing" 
// by Reas & Fry. O'Reilly / Make 2010

void setup() {
  size(480, 120);
  fill(0, 102);   // what do these two numbers mean? check the reference!
  smooth();
  noStroke();
}

void draw() {
  background(204);
  //ellipse(mouseX, mouseY, 9, 9);
}

void mousePressed() {
  ellipse(mouseX, mouseY, 9, 9);
  println("Mouse pressed! (" + mouseX + ", " + mouseY + ")");
}
