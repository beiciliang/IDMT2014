// Why does this need to be declared as a global variable?
float rotation = 0.0;

void setup() {
  size(400,400); 
}

void draw() {
  background(100); 

  translate(width/2,height/2);
  
  pushMatrix();
  
  rotate(rotation);
  
  // scale() zooms the window in and out around the (0,0) point. 1.0 is the
  // standard scaling factor. > 1 makes everything appear larger, < 1 makes
  // everything smaller.
  scale(rotation + .0001);
  
  rectMode(CENTER);
  stroke(0);
  fill(255,0,0);
  for(int i = 0; i < 10; i++) {
    for(int j = 0; j < 10; j++) {
      // What's going on in these calculations below? Can you see how the centre point
      // of each rectangle is calculated and why?
      rect(-(width/2) + width*i/10, -(height/2) + height*j/10, width/15, height/15);
    }
  }

  rotation += PI/200.0;
  if(rotation > 2.0*PI)
    rotation = 0.0;
  
  popMatrix(); 
    
  // Why doesn't this text move, and how could we make it move with the other shapes?
  fill(0);
  text("This text doesn't move", 0, 0);   
}
