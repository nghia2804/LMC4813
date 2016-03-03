/**
 * LMC 4813 Final Project
 * 
 * Edwin Choate
 * Nghia Huynh  
 * Sally Xia
 * 
 */
 
MakeyMakey makey = new MakeyMakey(10, 10, 512);
 
void setup () {
  size(720, 340);
  
  
}

void draw () {
  makey.drawMakey();
}




void keyPressed () {
  
  if (key == ' ') {
    println("spacebar pressed!");
    makey.redrawSpaceBtn(color(0, 255, 0));
  } else if (key == CODED) {
    switch (keyCode) {
      case UP:
        println("keyCode " + keyCode + " pressed!");
        makey.redrawUpBtn(color(0, 255, 0));
        break;
      case DOWN:
        println("keyCode " + keyCode + " pressed!");
        makey.redrawDownBtn(color(0, 255, 0));
        break;
      case LEFT:
        println("keyCode " + keyCode + " pressed!");
        makey.redrawLeftBtn(color(0, 255, 0));
        break;
      case RIGHT:
        println("keyCode " + keyCode + " pressed!");
        makey.redrawRightBtn(color(0, 255, 0));
        break;
      default:
        break;
    }
  }
}

void mouseClicked() {
   println("mouse clicked!");
   makey.redrawClickBtn(color(0, 255, 0));
}