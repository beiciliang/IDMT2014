// Draw the terrain under the tanks
void drawGround() {
  /* TO IMPLEMENT IN STEP 1 */
  stroke(127);
  strokeWeight(1);
  line(0, groundLevel[0], width*0.2-1, groundLevel[int(width*0.2-1)]);
  line(width*0.2, groundLevel[int(width*0.2)], width*0.8-1, groundLevel[int(width*0.8-1)]);
  line(width*0.8, groundLevel[int(width*0.8)], width-1, groundLevel[int(width-1)]);
  
  // See the groundLevel[] variable to know where to draw the ground
  // Ground should be drawn in a dark gray
}
