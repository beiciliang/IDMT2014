void setup() {
  size(800, 600);
}

void draw() {
  float i, j;
  
  background(128);
  noStroke();
  
  for(i = 50; i < 800; i += 50) {
    for(j = 50; j < 600; j += 50) {
      fill(i * 255 / 800, j * 255 / 600, 0);
      ellipse(i, j, 40, 40);
    }  
  }
}
