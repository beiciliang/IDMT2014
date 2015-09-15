// Simple example of rotate() and translate()
// IDMT 15 October 2014
float rotateAngle = 0;

void setup() {
  size(400,400); 
}

void draw() {
  background(100); 

  // translate() moves the centre of the coordinate system.
  // here, we move the drawing point down and right, so that
  // (0, 0) becomes the centre of the window.
  // (width and height are special variables indicating the
  // window size.)
  
  translate(width/2,height/2);
  
  // This saves the current drawing matrix so we can recover it later
  // and undo any further transformations we make.
 
  pushMatrix();
  // rotate() spins the coordinate system around the (0, 0) point.
  // which way does it go? Clockwise or counter-clockwise?
  rotate(rotateAngle);

  rectMode(CENTER);
  stroke(0);
  fill(255,0,0);
  
  // Because of rectMode(CENTER) above, this specifies the rectangle
  // by centre point (0,0) and size (100,100)
  rect(0, 0, 100, 100);

  rotateAngle -= 0.1;
  if(rotateAngle > TWO_PI){
    rotateAngle = -TWO_PI;
  }
   
  // This restores the drawing state to the last call of pushMatrix()
  popMatrix(); 
  
  // Try uncommenting this code. Is this shape translated? rotated? why?
  fill(0,255,0);
  rect(0, 0, 50, 50);
}
