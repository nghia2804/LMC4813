color[] colorArray = new color[6];
PFont f;

class GraphicViz{
  int vizLen;
  int numberOfBars = 11;
  int strikeMark=6;
  
  int tempo;
  int leftAlign;
  int topAlign;
  float period;
  int drumSize = 100;
  int drumSpace;
  int Switch = 0;
  
  //mark variables
  int diameter = 20;
  float positionX;
  float speed;
  
  //drum variables
  int drumTopAlign;
  int animationCount = 0;
  
  GraphicViz(int tempo, int vizLen){
    this.tempo = tempo;
    this.period = 60000/tempo;
    this.vizLen = vizLen/numberOfBars;
    this.leftAlign = (width - vizLen)/2;
    this.topAlign = height / 10;
    this.positionX = leftAlign + diameter/2;
    this.speed = (vizLen*numberOfBars - diameter)/period;
    this.drumTopAlign = height * 2/ 4;
    
  }
  
  void initializeViz(){
    // Initialize colors
    colorArray[0] = color(236,105,118);
    colorArray[1] = color(193,213,97);
    colorArray[2] = color(239,135,182);
    colorArray[3] = color(150,214,247);
    colorArray[4] = color(191,135,186);
    colorArray[5] = color(249,242,164);
    f = createFont("Arial",16,true);
  }
  
  void drawGid(){
    for (int i = 1; i <= numberOfBars; i++) {
      if ( Math.abs(i-strikeMark)<=2){
        fill(0,255,0,255-(255/2)*Math.abs(i-strikeMark)+50);
      } else {
        fill(200);
      }
      stroke(50);
      rect( leftAlign+vizLen*(i-1), topAlign, vizLen, vizLen);
    }
  }
  void drawMark(int time){
    
    if(positionX>=(leftAlign+vizLen*numberOfBars-diameter/2)){
    Switch=1;
  }
  if(positionX == leftAlign+ diameter/2){
    Switch=0;
  }
      if(Switch==0){
      positionX = positionX + speed; //position=position+1;
}
      else{
        positionX = positionX - speed;
  }
  fill(255,0,0);
  stroke(255,0,0);
  ellipse(positionX,topAlign-vizLen/2-diameter/2,diameter,diameter);    
  }
  
  void drawViz(Instrument[] drumset, int time){
    int len = drumset.length;
    textFont(f,32);                  // STEP 3 Specify font to be used
    fill(0);                         // STEP 4 Specify font color 
    text("Point: " + point,600,50);
  
    //Calcualte the space between drums
    drumSpace = (width - len*drumSize)/(len+1);
    
    for (int i = 0; i < len; i++){
        // drum i
      if (drumset[i].isStruck == true) {
        animationCount = animationCount+2;
        fill(colorArray[i]);
        noStroke();
        ellipse((drumSpace*(i+1)+drumSize*(i)), drumTopAlign, drumSize+animationCount, drumSize+animationCount);
        if (animationCount == 14){
          drumset[i].isStruck = false;
          animationCount = 0;
        }
      } else {
        fill(colorArray[i]);
        noStroke();
        ellipse((drumSpace*(i+1)+drumSize*(i)), drumTopAlign, drumSize, drumSize);
      }
    }
  }
}