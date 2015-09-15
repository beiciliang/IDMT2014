// Draw the two tanks (including cannons)

void drawTanks() {
  /* TO IMPLEMENT IN STEP 1 */
  
  // Draw the tank1 as an orange semicircle without stroke
  fill(252, 123, 71); 
  noStroke();
  arc(tank1X, tank1Y, tankDiameter, tankDiameter, PI, TWO_PI); 
  
  // Draw the cannon of tank1 as an orange line
  stroke(252, 123, 71);
  strokeWeight(6);
  line(tank1X, tank1Y-tankDiameter/2, 
  tank1X+cannonLength*cos(tank1CannonAngle), 
  tank1Y-tankDiameter/2-cannonLength*sin(tank1CannonAngle));
  
  // Draw the tank2 as a green semicircle without stroke
  fill(38, 211, 30);
  noStroke();
  arc(tank2X, tank2Y, tankDiameter, tankDiameter, PI, TWO_PI);
  
  // Draw the cannon of tank2 as a green line
  stroke(38, 211, 30);
  strokeWeight(6);
  line(tank2X, tank2Y-tankDiameter/2, 
  tank2X+cannonLength*cos(tank2CannonAngle), 
  tank2Y-tankDiameter/2-cannonLength*sin(tank2CannonAngle));
  
  // Tank1 will trun black if hitted by the projectile
  if(sqrt(sq(projectilePositionX-tank1X)+sq(projectilePositionY-tank1Y)) <= tankDiameter/2){
    fill(0); 
    noStroke();
    arc(tank1X, tank1Y, tankDiameter, tankDiameter, PI, TWO_PI); 
    stroke(0);
    strokeWeight(6);
    line(tank1X, tank1Y-tankDiameter/2, 
    tank1X+cannonLength*cos(tank1CannonAngle), 
    tank1Y-tankDiameter/2-cannonLength*sin(tank1CannonAngle)); 
  }
  
  // Tank2 will trun black if hitted by the projectile
  if(sqrt(sq(projectilePositionX-tank2X)+sq(projectilePositionY-tank2Y)) <= tankDiameter/2){
    fill(0);
    noStroke();
    arc(tank2X, tank2Y, tankDiameter, tankDiameter, PI, TWO_PI);
    stroke(0);
    strokeWeight(6);
    line(tank2X, tank2Y-tankDiameter/2, 
    tank2X+cannonLength*cos(tank2CannonAngle), 
    tank2Y-tankDiameter/2-cannonLength*sin(tank2CannonAngle));
  }
  
}

