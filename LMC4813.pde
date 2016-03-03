// Final Project
// Nghia
// Edwin

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
  
  
  // draw the drums: if a draw has just been struck
  // then fill it with color as visual feedback for the user
  viz.drawMark(time);
  viz.drawGid();
  viz.drawViz(drumstruck, time);
  
  
  time++;
}

  

void keyPressed() {
  if (key == '1') {
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
  } else if (key == '2') {
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
  }
}


void stop() {

  for (int i = 0; i < numberOfInstrument; i++) {
    drumAudio[i].close();
  }
  minim.stop();
  super.stop();
}