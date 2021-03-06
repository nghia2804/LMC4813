import ddf.minim.spi.*;
import ddf.minim.signals.*;
import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.ugens.*;
import ddf.minim.effects.*;


Minim minim2 = new Minim(this);
AudioPlayer player;
AudioMetaData meta;
BeatDetect beat;
BeatListener bl; //Initiate beatListener for minim to detect the beats


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