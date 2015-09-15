float gBlue = 0;

void setup() {
  size(800, 600);
}

void draw() {

  background(128);
  noStroke();
  
  /*circlegrid(gBlue);
  gBlue++;
  if(gBlue > 255)
  gBlue = 0;*/
  circleGrid(frameCount % 256);
  
}

void circleGrid(float blue){
  float i,j;
  float red, green;
  for(i = 50; i < width; i += 50) {
    for(j = 50; j < height; j += 50) {
      red = map(i, 0, width, 0,255);
      green =  map(i, 0, height, 0, 255);
      fill(red, green, blue);
      ellipse(i, j, 40, 40);
    }  
  }
}
