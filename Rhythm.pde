import ddf.minim.*;
import ddf.minim.analysis.*;

class Rhythm{
  float[] beatArray;
  int tempo;
  int period; // in miliseconds
  
  Rhythm(int tempo){
    this.tempo = tempo;
    this.period = 60000/tempo; 
  }
  
  Boolean isStruckRight(int time){
    //delay 0.2second12
    if ((time%period) < 200){
      return true;
    } else {
      return false;
    }
  }
  
}