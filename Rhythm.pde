import ddf.minim.spi.*;
import ddf.minim.signals.*;
import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.ugens.*;
import ddf.minim.effects.*;



AudioPlayer player;
AudioMetaData meta;
BeatDetect beat;
BeatListener bl; //Initiate beatListener for minim to detect the beats
PFont f; // Font for kick 


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
  
  void initializeRhythm(){
    frameRate(35);
    player = minim.loadFile("SoundSamples/Blank Space.mp3");
    meta = player.getMetaData();
    beat = new BeatDetect(player.bufferSize(), player.sampleRate());
    beat.setSensitivity(100);
    //player.loop();
    //player.play();
    bl = new BeatListener(beat, player);   //feature inside minim to detect beat
  }
  
  void drawRhythm(){
    beat.detect(player.mix);
    int bsize = player.bufferSize();  //define buffersize as an integer
    if (beat.isKick()){
      println("Kick");
    ////Displaying word.   
    //int kickSize = 60;
    //float x1 = (100)*cos(28*PI/bsize);
    //float y1 = (100)*sin(28*PI/bsize);
    //fill(#F8FFCC);
    //f = createFont("OriyaMN-48", kickSize);
    //textSize(kickSize);
    //textFont(f);
    //text("Kick", x1, y1);
    }
  }
}

//initiate BeatListener to enable further beat detection 
class BeatListener implements AudioListener
{
  private BeatDetect beat;
  private AudioPlayer source;
  
  BeatListener(BeatDetect beat, AudioPlayer source)
  {
    this.source = source;
    this.source.addListener(this);
    this.beat = beat;
  }
  
  void samples(float[] samps)
  {
    beat.detect(source.mix);
  }
  
  void samples(float[] sampsL, float[] sampsR)
  {
    beat.detect(source.mix);
  }
}