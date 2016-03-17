
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
BeatDetect b;

//Timer
int time;

//sound variables-------------

int numberOfInstrument = 2;

//Array of Instruments
Instrument[] drumset = new Instrument[numberOfInstrument];

//Array of Instruments' Audiofiles
AudioSnippet[] drumAudio = new AudioSnippet[numberOfInstrument];

// track when a drum has been struck
boolean[] drumstruck = new boolean[numberOfInstrument];

// rhythm variables-----------
Rhythm r;

//Graphic Viz-----------------
GraphicViz viz;

//Makeymakey variables--------
MakeyMakey makey = new MakeyMakey(200, 350, 400);  

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
  
  // ...
  minim = new Minim(this);

  //Initialize Instruments
  drumset[0] = new Instrument("Drum1", "SoundSamples/bongo1.wav");
  drumset[1] = new Instrument("Drum2", "SoundSamples/bongo7.wav");

  //Initialize Instrument Audio & Graphics
  for (int i = 0; i < numberOfInstrument; i++) {
    //initialize sound
    drumAudio[i] = minim.loadSnippet(drumset[i].soundLocation);

    //
    drumstruck[i] = false;
  }
  r.initializeRhythm();
  r.drawRhythm();
}

void draw() {
  background(200);
  
  
  // draw the drums: if a draw has just been struck
  // then fill it with color as visual feedback for the user
  viz.drawMark(time);
  viz.drawGid();
  viz.drawViz(drumstruck, time);
  
  // Makeymakey draw
  makey.drawMakey();
  
  b.detect(song.mix);
  
  strokeWeight(32);
  if (b.isOnset()) {
    stroke(#000000);
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
  } else if (key == CODED) {
    switch (keyCode) {
      case UP:
        println("keyCode " + keyCode + " pressed!");
        makey.redrawUpBtn(color(0, 255, 0));
        drumstruck[0] = true;
        drumAudio[0].play(0);
        break;
      case DOWN:
        println("keyCode " + keyCode + " pressed!");
        makey.redrawDownBtn(color(0, 255, 0));
        drumstruck[1] = true;
        drumAudio[1].play(0);
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

void stop() {

  for (int i = 0; i < numberOfInstrument; i++) {
    drumAudio[i].close();
  }
  minim.stop();
  super.stop();
}