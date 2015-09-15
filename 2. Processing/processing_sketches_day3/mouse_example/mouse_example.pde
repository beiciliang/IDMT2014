// Interactive Digital Multimedia Techniques
// Queen Mary University of London, 2014
int x, y;

void setup() {
  size(480, 120);
  fill(0, 102);   // what do these two numbers mean? check the reference!
  smooth();
  noStroke();
}

void draw() {
  background(204);
    
  ellipse(x, y, 9, 9);

}

void mousePressed() {
  // Why does this ellipse disappear?
  // ellipse(mouseX, mouseY, 9, 9);
   x = mouseX;
   y = mouseY;
  println("Mouse pressed! (" + mouseX + ", " + mouseY + ")"); 
}

