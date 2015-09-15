// Move the projectile and check for a collision

void updateProjectilePositionAndCheckCollision() {
  if(!projectileInMotion)
    return;
    
  /* TO IMPLEMENT IN STEP 3: UPDATE POSITION */
  // Increment the position according to the velocity
  // The velocity is according to gravity and wind
  
  if(projectileInMotion){
    projectilePositionX += projectileVelocityX;
    projectilePositionY += projectileVelocityY;
    
  /* TO IMPLEMENT IN STEP 4: GRAVITY */
  // Update the velocity of the projectile according to the value of gravity and wind
    projectileVelocityY += gravity;
    projectileVelocityX += wind;
  }
   
  /* TO IMPLEMENT IN STEP 5: COLLISION DETECTION */
  // Compare the location of the projectile to the boundary and to the two tanks

  if((projectileVelocityX < 0 && projectilePositionX <= 4) ||  // The left border
     (projectileVelocityX > 0 && projectilePositionX >= (width-4)) ||  //the right border
     (projectileVelocityY < 0 && projectilePositionY <= 4) ||  // The top border
     (projectileVelocityY > 0 && projectilePositionY >= groundLevel[(int)projectilePositionX])){  // The ground
   
    projectileInMotion = !projectileInMotion;  // When the projectile hits something, it stops moving
  
    //If the projectile is within the area of the tank's semicircle, the other player wins
    if(sqrt(sq(projectilePositionX-tank2X)+sq(projectilePositionY-tank2Y)) <= tankDiameter/2){
      playerHasWon = 1;  
    }
    else if(sqrt(sq(projectilePositionX-tank1X)+sq(projectilePositionY-tank1Y)) <= tankDiameter/2){
      playerHasWon = 2;
    }
    
    // If the projectile does not hit the tank, it's the next player's turn
    // Reset the value of wind, strength and boomSize
    else{
      nextPlayersTurn();
      wind = random(-0.05, 0.05);
      tank1CannonStrength = 3;
      tank2CannonStrength = 3;
      boomSize = 0;
    }
  }
}
