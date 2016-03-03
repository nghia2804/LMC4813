/**
 * LMC 4813 Final Project
 * 
 * Edwin Choate
 * Nghia Huynh  
 * Sally Xia
 * 
 */
 
void setup () {
  size(720, 340);
}

void draw () {
  createMakey(100, 10, 256);
}

void keyPressed () {
   
}

void mouseClicked() {
   
}

/**
 * draws a MakeyMakey on the canvas
 * 
 * @param xPos the x position of the MakeyMakey
 * @param yPos the y position of the MakeyMakey
 * @param w the width of the MakeyMakey
 */
void createMakey (int x, int y, int w) {
  int h = w / 2;  // the MakeyMakey has a 2:1 width:height ratio
  
  // MakeyMakey colors!
  color makeyWhite, makeyRed, makeySilver;
  makeyWhite = color(254, 254, 254);
  makeyRed = color(255, 38, 0);
  makeySilver = color(192, 191, 190);
  
  // draws the white rectangle
  fill(makeyWhite);
  stroke(makeyWhite);
  rect(x, y, w, h);
  
  // draws the red parts of the MakeyMakey
  fill(makeyRed);
  stroke(makeyRed);
  rect(x, (y + (5.0 * h) / 6), w, h / 5.7); // red stripe on bottom
  rect((x + 0.22 * w), (y + 0.06 * h), (0.10 * w), (0.667 * h)); // vertical line of d-pad
  rect((x + 0.105 * w), (y + 0.30 * h), (0.667 * h), (0.10 * w)); // horizontal line of d-pad
  ellipseMode(CORNER);
  ellipse((x + 0.53 * w), (y + 0.22 * h), (0.375 * h), (0.375 * h)); // first circular button 
  ellipse((x + 0.75 * w), (y + 0.22 * h), (0.375 * h), (0.375 * h)); // second circular buttom
}