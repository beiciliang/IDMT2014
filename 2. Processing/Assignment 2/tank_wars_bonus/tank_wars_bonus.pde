/*
 * IDMT Mini-Assignment 2 BONUS
 *
 * Tank Wars: a simple game of throwing projectiles
 * This is a skeleton with a few basic pieces filled
 * in. You will need to fill in the rest to make the 
 * game work.
 */

// Basic information on the terrain and the tanks

float[] groundLevel;  // Y coordinate of the ground for each X coordinate
float tank1X, tank1Y, tank2X, tank2Y; // Positions of the two tanks
float tankDiameter = 30;  // Diameter of the tanks
float cannonLength = 20;  // How long the cannon on each tank extends
float gravity = 0.05;      // Strength of gravity

// Current state of the game

int playerHasWon = 0; // 1 if player 1 wins, 2 if player 2 wins, 0 if game in progress
boolean player1Turn = true;  // true if it's player 1's turn; false otherwise
float tank1CannonAngle = PI/2, tank2CannonAngle = PI/2; // Direction the tank cannons are pointing
float tank1CannonStrength = 3, tank2CannonStrength = 3; // Strength of intended projectile launch

// Location of the projectile

boolean projectileInMotion = false;
float projectilePositionX, projectilePositionY;
float projectileVelocityX, projectileVelocityY;
float clickPositionX, clickPositionY, dragPositionX, dragPositionY;

void setup() {
  size(960, 480);  // Set the screen size
  
  // Initialize the ground level
  groundLevel = new float[width];
  float player1Height = random(height/2, height-5);
  float player2Height = random(height/2, height-5);
  for(float i = 0; i < width * 0.2; i++) {
    groundLevel[(int)i] = player1Height;
  }
  for(float i = width * 0.2; i < width * 0.8; i++) {
    groundLevel[(int)i] = player1Height + (player2Height - player1Height) * (i - width*0.2)/(width*0.6);
  }
  for(float i = width * 0.8; i < width; i++) {
    groundLevel[(int)i] = player2Height;    
  }
  
  // Set the location of the two tanks so they rest on the ground at opposite sides
  tank1X = width * 0.1;
  tank1Y = player1Height;
  tank2X = width * 0.9;
  tank2Y = player2Height;
}

void draw() {
  // Main draw loop. Farm out the individual tasks to other functions
  // for clarity (though it could be equivalently implemented entirely in this function.)
  
  background(200);
  
  drawGround();
  drawTanks();
  drawProjectile();
  drawStatus();
  
  updateProjectilePositionAndCheckCollision();
}

// Advance the turn to the next player
void nextPlayersTurn() {
  player1Turn = !player1Turn;
}

void mousePressed(){
  if(playerHasWon != 0)  // Stop the game when someone has won
    return;
  if(projectileInMotion) // No keys respond while the projectile is firing
    return;
  if(player1Turn){
    clickPositionX = mouseX;
    clickPositionY = mouseY;
    tank1CannonAngle = atan2((tank1Y-tankDiameter/2)-clickPositionY, tank1X-clickPositionX);
    projectilePositionX = tank1X+cannonLength*cos(tank1CannonAngle);
    projectilePositionY = tank1Y-tankDiameter/2-cannonLength*sin(tank1CannonAngle);
  }
  else{
    clickPositionX = mouseX;
    clickPositionY = mouseY;
    tank2CannonAngle = atan2((tank2Y-tankDiameter/2)-clickPositionY, tank2X-clickPositionY);
    projectilePositionX = tank2X+cannonLength*cos(tank2CannonAngle);
    projectilePositionY = tank2Y-tankDiameter/2-cannonLength*sin(tank2CannonAngle);
  }
}
void mouseDragged(){
  dragPositionX = mouseX;
  dragPositionY = mouseY;
  if(player1Turn){
    tank1CannonStrength = tank1CannonStrength+0.01*sqrt(sq(dragPositionX-clickPositionX)+sq(dragPositionY-clickPositionY));
  }
  else{
    tank2CannonStrength = tank2CannonStrength+sqrt(sq(dragPositionX-clickPositionX)+sq(dragPositionY-clickPositionY));
  }
}
void mouseReleased(){
  if(player1Turn){
    projectileVelocityX = tank1CannonStrength*cos(tank1CannonAngle);
    projectileVelocityY = -tank1CannonStrength*sin(tank1CannonAngle);
  }
  else{
    projectileVelocityX = tank2CannonStrength*cos(tank2CannonAngle);
    projectileVelocityY = -tank2CannonStrength*sin(tank2CannonAngle);
  }
  projectileInMotion = !projectileInMotion;
  tank1CannonStrength = 3;
  tank2CannonStrength = 3;
}
  
 
