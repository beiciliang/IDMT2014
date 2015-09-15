// Draw the two tanks (including cannons)
void drawTanks() {
  /* TO IMPLEMENT IN STEP 1 */
  //background(200);
  fill(252, 123, 71);
  noStroke();
  arc(tank1X, tank1Y, tankDiameter, tankDiameter, PI, TWO_PI);
  stroke(252, 123, 71);
  strokeWeight(4);
  line(tank1X, tank1Y-tankDiameter/2, 
  tank1X+cannonLength*cos(tank1CannonAngle), 
  tank1Y-tankDiameter/2-cannonLength*sin(tank1CannonAngle));
  
  fill(38, 211, 30);
  noStroke();
  arc(tank2X, tank2Y, tankDiameter, tankDiameter, PI, TWO_PI);
  stroke(38, 211, 30);
  strokeWeight(4);
  line(tank2X, tank2Y-tankDiameter/2, 
  tank2X+cannonLength*cos(tank2CannonAngle), 
  tank2Y-tankDiameter/2-cannonLength*sin(tank2CannonAngle));
  
  // Draw the two tanks as semicircles using the positions and sizes at the top of the file
  // Tanks should be different colours
  // Also be sure to draw the cannons, using the angles given at the top of the file
}

