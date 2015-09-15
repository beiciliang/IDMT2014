// Move the projectile and check for a collision
void updateProjectilePositionAndCheckCollision() {
  if(!projectileInMotion)
    return;
    
  /* TO IMPLEMENT IN STEP 3: UPDATE POSITION */
  // Tasks: increment the position according to the velocity
  // For later: the velocity according to gravity (and optionally wind)  
  
  if(projectileInMotion){
    projectilePositionX += projectileVelocityX;
    projectilePositionY += projectileVelocityY;
    
  /* TO IMPLEMENT IN STEP 4: GRAVITY */
  // Update the velocity of the projectile according to the value of gravity at the top of the file
    projectileVelocityY += gravity;
  }
   
  /* TO IMPLEMENT IN STEP 5: COLLISION DETECTION */
  // Compare the location of the projectile to the ground and to the two tanks
  // When the projectile hits something, it stops moving (change projectileInMotion)
  // When the projectile hits the ground, it's the next player's turn
  // When the projectile hits a tank, the other player wins
  if((projectileVelocityX < 0 && projectilePositionX <= 4) || 
     (projectileVelocityX > 0 && projectilePositionX >= (width-4)) ||
     (projectileVelocityY < 0 && projectilePositionY <= 4) ||
     (projectileVelocityY > 0 && projectilePositionY >= groundLevel[(int)projectilePositionX])){
       
    projectileInMotion = !projectileInMotion;
  
    if(sqrt(sq(projectilePositionX-tank2X)+sq(projectilePositionY-tank2Y)) <= tankDiameter/2)
      playerHasWon = 1;
    else if(sqrt(sq(projectilePositionX-tank1X)+sq(projectilePositionY-tank1Y)) <= tankDiameter/2)
      playerHasWon = 2;
    else{
    nextPlayersTurn();
    }
  }
}
    
    /*
    if((projectilePositionX > tank2X-tankDiameter/2) && (projectilePositionX < tank2X+tankDiameter/2)){
      playerHasWon = 1;
    }
    else if((projectilePositionX > tank1X-tankDiameter/2) && (projectilePositionX < tank1X+tankDiameter/2)){
      playerHasWon = 2;
    }
    else{
      nextPlayersTurn();
    }
    */
    
 


