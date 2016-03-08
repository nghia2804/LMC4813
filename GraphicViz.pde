class GraphicViz{
  int vizLen;
  int numberOfBars = 11;
  int strikeMark=6;
  
  int tempo;
  int leftAlign;
  int topAlign;
  float period;
  int drumSize = 150;
  int drumSpace;
  int Switch = 0;
  
  //mark variables
  int diameter = 20;
  float positionX;
  float speed;
  
  GraphicViz(int tempo, int vizLen){
    this.tempo = tempo;
    this.period = 60000/tempo;
    this.vizLen = vizLen/numberOfBars;
    this.leftAlign = (width - vizLen)/2;
    this.topAlign = height / 10;
    this.positionX = leftAlign + diameter/2;
    this.speed = (vizLen*numberOfBars - diameter)/period;
    
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
  
  void drawViz(boolean[] drumstruck, int time){
    int len = drumstruck.length;
    int drumTopAlign = height * 1/ 4;
    
    //Calcualte the space between drums
    drumSpace = (width - len*drumSize)/(len+1);
    
    for (int i = 0; i < len; i++){
        // drum i
      if (drumstruck[0] == true) {
        fill(0);
        drumstruck[0] = false;
      } else {
        fill(255);
      }
      fill(50);
      stroke(50);
      ellipse((drumSpace*(i+1)+drumSize*(i)), drumTopAlign, drumSize, drumSize);
    }
    
  }
  
}