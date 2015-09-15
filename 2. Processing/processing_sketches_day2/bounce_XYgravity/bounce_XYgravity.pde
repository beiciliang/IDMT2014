// Interactive Digital Multimedia Techniques
// Queen Mary University of London, 2014

// TASK: Expand this sketch to have the ball move and bounce
// in both the X and Y directions!

float ballDiameter = 30;
float positionX, positionY;
float velocityX, velocityY;
float accelerationY;
float bounciness;

void setup() {
  size(800, 600);
  background(128);
  positionX = 0;
  velocityX = 3;
  positionY = 0;
  velocityY = 3;
  accelerationY = 2;
  bounciness = 0.99;
}

void draw() {
  background(128);
  fill(0);      // fill changes the color of the interior of the shape
  noStroke();   // noStroke removes the outer line

  // Does position represent the horizontal or the vertical location?
  ellipse(positionX, positionY, ballDiameter, ballDiameter);
  positionX += velocityX;
  positionY += velocityY;
 
  // && means "and"
  if((velocityX > 0 && positionX > width - ballDiameter/2) || (velocityX < 0 && positionX < ballDiameter/2))
    velocityX = -velocityX;
  if((velocityY > 0 && positionY > height - ballDiameter/2) || (velocityY < 0 && positionY < ballDiameter/2))
    {
      velocityY = -velocityY * bounciness;
      positionY = constrain(positionY, ballDiameter/2, height-ballDiameter/2);
    }
  else
    velocityY += accelerationY;
}

