// Draw the terrain under the tanks

void drawGround() {
  /* TO IMPLEMENT IN STEP 1 */
  
  // Draw the ground
  stroke(100, 100, frameCount % 256);  
  strokeWeight(1);
  for(float lineX = 0; lineX < width; lineX ++){
    line(lineX, groundLevel[int(lineX)], lineX, height);  // Draw a verical line at each X location
  }
  
  // Draw the sky
  stroke(153, 224, 245);
  strokeWeight(1);
  for(float skyX = 0; skyX < width; skyX++){
    line(skyX, 0, skyX, groundLevel[int(skyX)]);
  }
  
  // Draw a colorful ribbon under the lowest level of the ground
  for(float i = 0; i < 60; i++) {
    for(float j = 0; j < 30; j++) {
      float red = map(i, 0, 60, 0, 255);
      float green = map(j, 0, 30, 0, 255);
      float blue = frameCount % 256;
      noStroke();
      fill(red, green, blue);
      rect(width*i/60, max(groundLevel)+height*j/30, width/30, height/15);
    }
  }
 
}
