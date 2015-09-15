// Draw the projectile, if one is currently in motion

void drawProjectile() {
  if(!projectileInMotion)  // Don't draw anything if there's no projectile in motion
    return;
  
  // Draw the projectile as a black circle
  noStroke();
  fill(0);
  ellipse(projectilePositionX, projectilePositionY, 8, 8);
}
