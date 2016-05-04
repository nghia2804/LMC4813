color[] colorArray = new color[6];
PFont f;

class InputViz{
  int vizLen;
  int numberOfBars = 11;
  int strikeMark=6;
  
  int tempo;
  int leftAlign;
  int topAlign;
  float period;
  int drumSize = 100;
  int drumSize2 = 75;
  int drumSpace;
  int Switch = 0;
  
  //mark variables
  int diameter = 20;
  float positionX;
  float speed;
  
  //drum variables
  int drumTopAlign;
  int animationCount = 0;
  
  InputViz(int tempo, int vizLen){
    this.tempo = tempo;
    this.period = 60000/tempo;
    this.vizLen = vizLen/numberOfBars;
    this.leftAlign = (width - vizLen)/2;
    this.topAlign = height / 10;
    this.positionX = leftAlign + diameter/2;
    this.speed = (vizLen*numberOfBars - diameter)/period;
    this.drumTopAlign = height - drumSize * 2 + 50;
    
  }
  
  void initializeViz(){
    // Initialize colors
    colorArray[0] = color(236,105,118);
    colorArray[1] = color(249,242,164);
    colorArray[2] = color(239,135,182);
    colorArray[3] = color(150,214,247);
    colorArray[4] = color(191,135,186);
    colorArray[5] = color(193,213,97);
    
    f = createFont("Arial",16,true);
  }
  
  void drawTutorialMode(Instrument[] drumset, int[][] positionArray){
    
    int len = drumset.length;
    textFont(f,32);                  // STEP 3 Specify font to be used
    fill(0);                         // STEP 4 Specify font color 
    for (int i = 0; i < len; i++){
      if (drumset[i].isStruck == true) {
        animationCount = animationCount+1;
        fill(colorArray[i]);
        noStroke();
        ellipse(positionArray[i][0], positionArray[i][1], drumSize2+animationCount, drumSize2+animationCount);
        if (animationCount == 7){
          drumset[i].isStruck = false;
          //color colDjembe = color(221, 205, 177);
          //fill(colDjembe);
          //ellipse(positionArray[i][0], positionArray[i][1], drumSize2+animationCount, drumSize2+animationCount);
          
          animationCount = 0;
        }
      } else {
        fill(colorArray[i]);
        noStroke();
        ellipse(positionArray[i][0], positionArray[i][1], drumSize2, drumSize2);
      }
    }
  
  }
  
  void drawViz(Instrument[] drumset, int time){
    int len = drumset.length;
    textFont(f,32);                  // STEP 3 Specify font to be used
    fill(0);                         // STEP 4 Specify font color 
    //text("Point: " + point,600,50);
  
    //Calcualte the space between drums
    drumSpace = (width - len*drumSize)/(len+1);
    
    for (int i = 0; i < len; i++){
        // drum i
      ((Instrument)drumset[i]).drawInstrument(i * drumSize + drumSpace*(i+1), drumTopAlign - (drumSize + 30), drumSize, drumSize);
        
      if (drumset[i].isStruck == true) {
        animationCount = animationCount+2; //<>//
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