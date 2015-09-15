// Draw the status text on the top of the screen
void drawStatus() {
  textSize(24);
  textAlign(LEFT);
  fill(0);
  
  if(playerHasWon == 1)
    text("Player 1 Wins!", 10, 30);
  else if(playerHasWon == 2)
    text("Player 2 Wins!", 10, 30);
  else if(player1Turn) { // player1Turn == true means it's player 1's turn
    text("Player 1's turn", 10, 30);
     textAlign(RIGHT);   
    text("Angle: " + tank1CannonAngle + " Strength: " + tank1CannonStrength, width - 10, 30);
  }
  else {                 // player1Turn == false
    text("Player 2's turn", 10, 30);
    textAlign(RIGHT);
    text("Angle: " + tank2CannonAngle + " Strength: " + tank2CannonStrength, width - 10, 30);
  }
}
