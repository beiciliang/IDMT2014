// Draw the projectile, if one is currently in motion
void drawProjectile() {
  if(!projectileInMotion)  // Don't draw anything if there's no projectile in motion
    return;
  noStroke();
  fill(255, 255, 0);
  ellipse(projectilePositionX, projectilePositionY, 8, 8);
}
