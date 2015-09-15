// Draw the status text on the top of the screen

void drawStatus() {
  textSize(20);
  textAlign(LEFT);
  fill(100, 100, frameCount % 256);  // Change the color of the text
  
  if(playerHasWon == 1)
    text("Player 1 Wins!", 10, 30);
  else if(playerHasWon == 2)
    text("Player 2 Wins!", 10, 30);
  else if(player1Turn) { // player1Turn == true means it's player 1's turn
    text("Player 1's turn", 10, 30);
     textAlign(RIGHT);   
    text("Angle: " + tank1CannonAngle + " Strength: " + tank1CannonStrength + " Wind: " + wind, width - 10, 30);
  }
  else {                 // player1Turn == false
    text("Player 2's turn", 10, 30);
    textAlign(RIGHT);
    text("Angle: " + tank2CannonAngle + " Strength: " + tank2CannonStrength + " Wind: " + wind, width - 10, 30);
  }
}
