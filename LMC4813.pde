
/**
 * LMC 4813 Final Project
 * 
 * Edwin Choate
 * Nghia Huynh  
 * Sally Xia
 * 
 */
 
// import Minim
import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.analysis.*;

Minim minim = new Minim(this);
AudioPlayer song;
Boolean isSongMute = false;
BeatDetect b;

//Timer
int time;

//sound variables-------------

int numberOfInstrument = 4;

//Array of Instruments
Instrument[] drumset = new Instrument[numberOfInstrument];

// rhythm variables-----------
Rhythm r;

//Graphic Viz-----------------
GraphicViz viz;

//Makeymakey variables--------
//MakeyMakey(int xPosition, int yPosition, int screenWidth)
MakeyMakey makey = new MakeyMakey(50, 500, 100);  


// Point
int point = 0;
int beatMillis = 0;

void setup() {  
  size(800, 600);
  smooth();
  
  
  time = 0;
  
  song = minim.loadFile("80 BPM - Simple Straight Beat - Drum Track.mp3", 2048);
  song.play();
  
  // a beat detection object song SOUND_ENERGY mode with a sensitivity of 10 milliseconds
  b = new BeatDetect();
  
  //Initialize rhythm with tempo (beats/minute)
  r = new Rhythm(60);
  
  //
  viz = new GraphicViz(60,400);
  viz.initializeViz();
  
  // ...
  minim = new Minim(this);

  //Initialize Instruments
  drumset[0] = new Instrument("Drum1", "SoundSamples/kick1.wav");
  drumset[1] = new Instrument("Drum2", "SoundSamples/snare2.wav");
  drumset[2] = new Instrument("Drum1", "SoundSamples/hat3.wav");
  drumset[3] = new Instrument("Drum2", "SoundSamples/rim4.wav");

  //Initialize Instrument Audio & Graphics
  for (int i = 0; i < numberOfInstrument; i++) {
    //initialize sound
    drumset[i].setAudio();

  }
  r.initializeRhythm();
  r.drawRhythm();
}

void draw() {
  background(121,148,177);
  
  
  // draw the drums: if a draw has just been struck
  // then fill it with color as visual feedback for the user
  //viz.drawMark(time);
  //viz.drawGid();
  
  viz.drawViz(drumset, time);
  
  // Makeymakey draw
  makey.drawMakey();
  
  b.detect(song.mix);
  
  strokeWeight(32);
  if (b.isOnset()) {
    stroke(#000000);
    beatMillis = millis();
    println(beatMillis);
  } else {
    stroke(#FFFFFF);
  }
  line(0, 0, width, 0);
  line(0, 0, 0, height);
  line(width, 0, width, height);
  line(0, height, width, height);
  strokeWeight(1);
  
  
  time++;
}

  

void keyPressed() {
  
  if (key == ' ') {
    println("spacebar pressed!");
    makey.redrawSpaceBtn(color(0, 255, 0));
    if (isSongMute == false){ 
      song.mute();
      isSongMute= true;
    } else { 
      song.unmute();
    }
      
  } else if (key == CODED) {
    switch (keyCode) {
      case UP:
        println("keyCode " + keyCode + " pressed!");
        makey.redrawUpBtn(color(0, 255, 0));
        drumset[0].isStruck = true;
        drumset[0].drumAudio.play(0);
        getPoint();
        break;
      case DOWN:
        println("keyCode " + keyCode + " pressed!");
        makey.redrawDownBtn(color(0, 255, 0));
        drumset[1].isStruck = true;
        drumset[1].drumAudio.play(0);
        getPoint();
        break;
      case LEFT:
        println("keyCode " + keyCode + " pressed!");
        makey.redrawLeftBtn(color(0, 255, 0));
        drumset[2].isStruck = true;
        drumset[2].drumAudio.play(0);
        getPoint();
        break;
      case RIGHT:
        println("keyCode " + keyCode + " pressed!");
        makey.redrawRightBtn(color(0, 255, 0));
        drumset[3].isStruck = true;
        drumset[3].drumAudio.play(0);
        getPoint();
        break;
      default:
        break;
    }
  }
}

void getPoint(){
  if ((millis() - beatMillis ) > 300) {
    point = point + 10;
  }
}

void mouseClicked() {
   println("mouse clicked!");
   makey.redrawClickBtn(color(0, 255, 0));
}

void stop() {

  for (int i = 0; i < numberOfInstrument; i++) {
    drumset[i].drumAudio.close();
  }
  minim.stop();
  super.stop();
}