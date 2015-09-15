// Draw the explosion when the projectile hits something

void goBoom(){
  if((projectileVelocityX < 0 && projectilePositionX <= 4) ||  // The left border
     (projectileVelocityX > 0 && projectilePositionX >= (width-4)) ||  //the right border
     (projectileVelocityY < 0 && projectilePositionY <= 4) ||  // The top border
     (projectileVelocityY > 0 && projectilePositionY >= groundLevel[(int)projectilePositionX])){  // The ground
       
       // The explosion gets bigger and turns from red to yellow over time
       if(boomSize < 100){
         float yellowValue = map(boomSize, 0, 100, 0, 255);
         float diameter = map(boomSize, 0, 100, 0, 30);
         noStroke();
         fill(255, yellowValue, 0);
         ellipseMode(CENTER);
         ellipse(projectilePositionX, projectilePositionY, diameter, diameter);
         boomSize++;
       }
  }
}
