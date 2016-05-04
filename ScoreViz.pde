class ScoreViz {
  int value, max, x, y, w, h;
  color backing, bar;
  ScoreViz(){
    value = 0;
    max = 25;
    x = 150;
    y = 30;
    w = 350;
    h = 25;
    backing = color(255,0,0);
    bar = color(0,255,0);
  }
  void drawViz(){
    fill(backing);
    stroke(0);
    rect(x,y,w,h);
    fill(bar);
    rect(x,y,map(value,0,max,0,w),h);
  }
  
  void increaseValue(){
    value = value + 1 ;
    if (value > max){
      value = max;
    }
  }
  
  int getValue(){
    return this.value;
  }
}