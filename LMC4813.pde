// Final Project
// Nghia
// Edwin

// import Minim
import ddf.minim.*;
Minim minim;

//sound variables-------------

int numberOfInstrument = 2;

//Array of Instruments
Instrument[] drumset = new Instrument[numberOfInstrument];

//Array of Instruments' Audiofiles
AudioSnippet[] drumAudio = new AudioSnippet[numberOfInstrument];

// track when a drum has been struck
boolean[] drumstruck = new boolean[numberOfInstrument];

void setup() {  
  size(800, 800);
  smooth();
  
  // ...
  minim = new Minim(this);
  
  //Initialize Instruments
  drumset[0] = new Instrument("Drum1", "SoundSamples/bongo1.wav");
  drumset[1] = new Instrument("Drum2", "SoundSamples/bongo7.wav");
  
  //Initialize Instrument Audio & Graphics
  for (int i = 0; i < numberOfInstrument; i++){
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

  // drum 1
  if (drumstruck[0] == true) {
    fill(0);
    drumstruck[0] = false;
  } else {
    fill(255);
  }
  ellipse(200, 250, 300, 300);

  // drum 2
  if (drumstruck[1] == true) {
    fill(0);
    drumstruck[1] = false;
  } else {
    fill(255);
  }
  ellipse(600, 250, 300, 300);
}
  
  void keyPressed() {
  if (key == '1') {
    drumstruck[0] = true;
    drumAudio[0].play(0);
  }
  else if (key == '2') {
    drumstruck[1] = true;
    drumAudio[1].play(0);
  }
}


void stop() {
  
  for (int i = 0; i < numberOfInstrument; i++){
    drumAudio[i].close();
  }
  minim.stop();
  super.stop();
}

void playSound(Instrument instrument){
}