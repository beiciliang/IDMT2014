/*
 * IDMT Mini-Assignment 2: Tank Wars
 * Players take turns launching projectiles at each other
 * The first player to strike the other player's tank wins
 * The angle and strength of the projectile launch can be controlled by arrow keys
 * The wind displayed at the top will affect the horizontal projectile velocity
 * The projectile will explode when it collides with something
 *
 * created by Beici Liang, Oct 15, 2014
 */

// Basic information on the terrain and the tanks

float[] groundLevel;  // Y coordinate of the ground for each X coordinate
float tank1X, tank1Y, tank2X, tank2Y; // Positions of the two tanks
float tankDiameter = 40;  // Diameter of the tanks
float cannonLength = 20;  // How long the cannon on each tank extends
float gravity = 0.05;      // Strength of gravity
float wind = random(-0.05, 0.05);   // Initialize a random trength of wind

// Current state of the game

int playerHasWon = 0; // 1 if player 1 wins, 2 if player 2 wins, 0 if game in progress
boolean player1Turn = true;  // true if it's player 1's turn; false otherwise
float tank1CannonAngle = PI/2, tank2CannonAngle = PI/2; // Direction the tank cannons are pointing
float tank1CannonStrength = 3, tank2CannonStrength = 3; // Strength of intended projectile launch

// Location of the projectile

boolean projectileInMotion = false;
float projectilePositionX, projectilePositionY;
float projectileVelocityX, projectileVelocityY;

int boomSize = 0;   // Set a variable for explosion

PImage img;

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
  
  img = loadImage("sun.png");
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
  goBoom();    // Draw an explosion that gets bigger over time
  
  //Upload an image of sun and make it rotate
  pushMatrix();
  translate(250, 70);
  rotate(frameCount/200.0);
  imageMode(CENTER);
  image(img, 0, 0, img.width/2, img.height/2);
  popMatrix();
  
}

// Advance the turn to the next player

void nextPlayersTurn() {
  player1Turn = !player1Turn;
}

// Handle a key press: update the status of the current player's tank

void keyPressed() {
  if(playerHasWon != 0)  // Stop the game when someone has won
    return;
  if(projectileInMotion) // No keys respond while the projectile is firing
    return;
    
  /* TO IMPLEMENT IN STEP 2 */ 
  // Use the key variable to check which key was pressed.
  // Arrow keys don't have a printable character, so they show up as CODED 
  if(player1Turn){    // When player1's turn
    if(key == CODED){      
      if(keyCode == RIGHT){
        tank1CannonAngle -= PI/90;  // The cannon will rotate two degrees to the right when the right arrow is pressed
      }
      else if(keyCode == LEFT){
        tank1CannonAngle += PI/90;  // The cannon will rotate two degrees to the left when the left arrow is pressed
      }
      else if(keyCode == UP){
        tank1CannonStrength += 0.2;  // Add 0.2 to the strength of cannon when the up arrow is pressed
      }
      else if(keyCode == DOWN){
        tank1CannonStrength -= 0.2;  // Minus 0.2 to the strength of cannon when the down arrow is pressed
      }
    }
    else if(key == ' '){    // Begin to fires the projectile when the space bar is pressed
      
      // The projectile is at the muzzle of the cannon
      projectilePositionX = tank1X+cannonLength*cos(tank1CannonAngle);
      projectilePositionY = tank1Y-tankDiameter/2-cannonLength*sin(tank1CannonAngle);
           
      // The lauching velocity is proportional to the strength
      projectileVelocityX = tank1CannonStrength*cos(tank1CannonAngle);
      projectileVelocityY = -tank1CannonStrength*sin(tank1CannonAngle);
      
      projectileInMotion = !projectileInMotion;  // turn the projectileInMotion to true
    }
  }
  
  else{    // When player2's turn
   if(key == CODED){
      if(keyCode == RIGHT){
        tank2CannonAngle -= PI/90;
      }
      else if(keyCode == LEFT){
        tank2CannonAngle += PI/90;
      }
      else if(keyCode == UP){
        tank2CannonStrength += 0.2;
      }
      else if(keyCode == DOWN){
        tank2CannonStrength -= 0.2;
      }
    }
    else if(key == ' '){
      projectilePositionX = tank2X+cannonLength*cos(tank2CannonAngle);
      projectilePositionY = tank2Y-tankDiameter/2-cannonLength*sin(tank2CannonAngle);
      projectileVelocityX = tank2CannonStrength*cos(tank2CannonAngle);
      projectileVelocityY = -tank2CannonStrength*sin(tank2CannonAngle); 
      projectileInMotion = !projectileInMotion;      
    }
  }  
}
