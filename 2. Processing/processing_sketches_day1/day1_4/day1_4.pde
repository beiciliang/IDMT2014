// Interactive Digital Multimedia Techniques
// Queen Mary University of London, 2014

void setup() {
  size(800, 600);
  
  // background() fills the window with a solid colour
  // it can be called in setup() or in draw()
  // with one argument, it is a grayscale value (0-255)
  background(128);
}

void draw() {
  // fill() changes the colour of the shape interior
  // parameters are R, G, B
  
  fill(255, 0, 0);
  ellipse(200, 400, 20, 20);
  
  fill(0, 255, 0);
  ellipse(400, 300, 30, 30);  
  
  fill(0, 0, 255);
  ellipse(600, 200, 40, 40); 

  // What colour would another ellipse here be?  
}

