// Notice the [] syntax. This means these are arrays, but we don't
// know how big they are until we initalise them in setup(). 
float[] shapeRotations;
float[] shapeSizes;

// Look up PVector and color in the reference!
PVector[] shapeLocations;
color[] shapeColors;

int numberOfShapes = 50;
float rotateAngle = 0;


void setup() {
  // Create the window
  size(400, 400);
  
  // Allocate the arrays to hold the proper number of shapes
  // This makes the right amount of space in memory to hold all
  // these variables, but doesn't yet say what the contents are.
  shapeRotations = new float[numberOfShapes];
  shapeSizes = new float[numberOfShapes];
  shapeLocations = new PVector[numberOfShapes];
  shapeColors = new color[numberOfShapes];
  
  // Initialise the contents of each array
  for(int i = 0; i < numberOfShapes; i++) {
    shapeRotations[i] = random(0.0, TWO_PI);  // Random rotation from 0 to 2*pi
    shapeSizes[i] = pow(5.0, random(-1.0, 1.0)); // Distribute the log of this value uniformly...
    shapeLocations[i] = new PVector(random(-width / 2, width / 2), random(-height / 2, height / 2));
    shapeColors[i] = color(random(0, 255), random(0, 255), random(0, 255));
  }
}

void draw() {
  background(100);  // Gray background
  
  translate(width / 2, height / 2);  // Center coordinate (0,0) in the middle of the window
  rectMode(CENTER);

  
  for(int i = 0; i < numberOfShapes; i++) {
    pushMatrix(); // Save the current rendering parameters before we change them

    // The canonical linear transformations: rotation, translation (moving the center), and
    // scaling (changing the size).

    translate(shapeLocations[i].x, shapeLocations[i].y);
    rotate(shapeRotations[i]+rotateAngle);    
    scale(shapeSizes[i]);
    
    stroke(0);
    fill(shapeColors[i]);
    rect(0, 0, 30, 30);
    
    

    popMatrix(); // Restore the old rendering parameters
  }
    rotateAngle += .01;
}
