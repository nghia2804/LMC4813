<<<<<<< HEAD
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
Minim minim;

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
MakeyMakey makey = new MakeyMakey(10, 10, 512);

void setup() {  
  size(800, 800);
  smooth();
  
  time = 0;
  
  //Initialize rhythm with tempo (beats/minute)
  r = new Rhythm(100);
  
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
}

void draw() {
  background(255);
  
  // Makeymakey draw
  makey.drawMakey();
  
  
  // draw the drums: if a draw has just been struck
  // then fill it with color as visual feedback for the user
  viz.drawMark(time);
  viz.drawGid();
  viz.drawViz(drumstruck, time);
  
  
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
        if (r.isStruckRight(time)){
          //fill green
          fill(0,255,0);
        } else {
          //fill red
          fill(255,0,0);
        }
        ellipse(200, 250, 350, 350);
        break;
      case DOWN:
        println("keyCode " + keyCode + " pressed!");
        makey.redrawDownBtn(color(0, 255, 0));
        drumstruck[1] = true;
        drumAudio[1].play(0);
        if (r.isStruckRight(time)){
          //fill green
          fill(0,255,0);
        } else {
          //fill red
          fill(255,0,0);
        }
        ellipse(600, 250, 350, 350);
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



void stop() {

  for (int i = 0; i < numberOfInstrument; i++) {
    drumAudio[i].close();
  }
  minim.stop();
  super.stop();
}