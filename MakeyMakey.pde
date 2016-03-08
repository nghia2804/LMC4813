
class MakeyMakey {

  int xPosition, yPosition, screenWidth, screenHeight;
  
  color makeyRed = color(255, 38, 0);
  color makeyWhite = color(254, 254, 254);
  color makeySilver = color(192, 191, 190);
  
  public MakeyMakey(int xPosition, int yPosition, int screenWidth) {
    this.xPosition = xPosition;
    this.yPosition = yPosition;
    this.screenWidth = screenWidth;
    this.screenHeight = screenWidth / 2;  
  }
  
  /**
   * draws a MakeyMakey on the canvas
   * 
   * @param xPos the x position of the MakeyMakey
   * @param yPos the y position of the MakeyMakey
   * @param w the width of the MakeyMakey
   */
  void drawMakey () {
    // draws the white rectangle
    fill(this.makeyWhite);
    stroke(this.makeyWhite);
    rect(this.xPosition, this.yPosition, this.screenWidth, this.screenHeight);
    
    // draws the red parts of the MakeyMakey
    fill(makeyRed);
    stroke(makeyRed);
    rect(this.xPosition, (this.yPosition + (5.0 * this.screenHeight) / 6), this.screenWidth, this.screenHeight / 5.7); // red stripe on bottom
    rect((this.xPosition + 0.22 * this.screenWidth), (this.yPosition + 0.06 * this.screenHeight), (0.10 * this.screenWidth), (0.667 * this.screenHeight)); // vertical line of d-pad
    rect((this.xPosition + 0.105 * this.screenWidth), (this.yPosition + 0.30 * this.screenHeight), (0.667 * this.screenHeight), (0.10 * this.screenWidth)); // horizontal line of d-pad
    ellipseMode(CORNER);
    ellipse((this.xPosition + 0.53 * this.screenWidth), (this.yPosition + 0.22 * this.screenHeight), (0.375 * this.screenHeight), (0.375 * this.screenHeight)); // first circular button 
    ellipse((this.xPosition + 0.75 * this.screenWidth), (this.yPosition + 0.22 * this.screenHeight), (0.375 * this.screenHeight), (0.375 * this.screenHeight)); // second circular buttom
  }
  
  int getX () {
    return this.xPosition;
  }
  
  int getY () {
    return this.yPosition;
  }
  
  void setX (int xPosition) {
    this.xPosition = xPosition;
  }
  
  void setY (int yPosition) {
    this.yPosition = yPosition;
  }
  
  void redrawClickBtn (color c) {
    fill(c);
    stroke(c);
    ellipse((this.xPosition + 0.75 * this.screenWidth), (this.yPosition + 0.22 * this.screenHeight), (0.375 * this.screenHeight), (0.375 * this.screenHeight));
  }
  
  void redrawSpaceBtn (color c) {
    fill(c);
    stroke(c);
    ellipse((this.xPosition + 0.53 * this.screenWidth), (this.yPosition + 0.22 * this.screenHeight), (0.375 * this.screenHeight), (0.375 * this.screenHeight));
  }
  
  void redrawUpBtn (color c) {
    fill(c);
    stroke(c);
    rect((this.xPosition + 0.22 * this.screenWidth), (this.yPosition + 0.06 * this.screenHeight), (0.10 * this.screenWidth), (0.667 * this.screenHeight) / 2); 
  }
  
  void redrawDownBtn (color c) {
    fill(c);
    stroke(c);
    rect((this.xPosition + 0.22 * this.screenWidth), (this.yPosition + 0.06 * this.screenHeight + (0.667 * this.screenHeight) / 2), (0.10 * this.screenWidth), (0.667 * this.screenHeight) / 2); 
  }
  
  void redrawLeftBtn (color c) {
    fill(c);
    stroke(c);
    rect((this.xPosition + 0.105 * this.screenWidth), (this.yPosition + 0.30 * this.screenHeight), (0.667 * this.screenHeight) / 2, (0.10 * this.screenWidth));
  }
  
  void redrawRightBtn (color c) {
    fill(c);
    stroke(c);
    rect((this.xPosition + 0.105 * this.screenWidth + (0.667 * this.screenHeight) / 2), (this.yPosition + 0.30 * this.screenHeight), (0.667 * this.screenHeight) / 2, (0.10 * this.screenWidth));
  }
  
}