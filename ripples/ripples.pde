//
int cols, rows;


// algorithm
int[][] current;
int[][] previous;
float damping = 0.99999;
PImage img;

void setup() {
  img = loadImage("./water.jpg");
  size(512, 512);
  cols = width;
  rows = height;
  
  initArrayFromImage();
}

void initArrayFromImage() {
  previous = new int[cols][rows];
  current = new int[cols][rows];
  
  /* 
  
  img.loadPixels();
 
  for(int x = 1; x < cols-1; x++) {
    for(int y = 1; y < rows-1; y++) {
      int index = x + y * cols;
      previous[x][y] = img.pixels[index];
      current[x][y] = img.pixels[index];
    }
  }
  */
}

void mouseDragged() {
  current[mouseX][mouseY] = 500;
}

void draw() {
  //image(img,0,0); 
  
  loadPixels();
  for(int x = 1; x < cols-1; x++) {
    for(int y = 1; y < rows-1; y++) {
    
      current[x][y] = (previous[x-1][y] + previous[x+1][y] + previous[x][y+1] + previous[x][y-1]) / 2 - current[x][y];
      current[x][y] = floor(current[x][y] * damping);
      int index = x + y * cols;
      pixels[index] = color(current[x][y]);
    }
  }
  
  // display the current buffer
  updatePixels();
  
  // swap the buffers
  int[][] temp = previous;
  previous = current;
  current = temp;
}
