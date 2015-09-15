// Interactive Digital Multimedia Techniques
// Queen Mary University of London, 2014

// TASK: When the mouse is clicked, move the ball to that
// location.

float ballDiameter = 30;
float positionX, positionY;
float velocityX, velocityY;
float accelerationY = 1.0;
float bounciness = 0.95;

void setup() {
  size(800, 600);
  background(128);
  positionX = 0;
  velocityX = 3;
  positionY = 100;
  velocityY = 5;  
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
  if((velocityX > 0 && positionX > width - ballDiameter/2) || 
     (velocityX < 0 && positionX < ballDiameter/2))
    velocityX = -velocityX;
  if((velocityY > 0 && positionY > height - ballDiameter/2) || 
     (velocityY < 0 && positionY < ballDiameter/2)) {
    velocityY = -velocityY * bounciness;
    positionY = height - ballDiameter / 2;
  }
  else
    velocityY += accelerationY;
}

