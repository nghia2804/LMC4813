
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
public static final int MAX_INSTRUMENTS = 6;
int numberOfInstruments = MAX_INSTRUMENTS;
String[] africanInstruments = {"axatse", "balaphone", "bougarabou", "caxixi", "djembe",
"djun-djun", "embaire", "ewe-drum", "gankogui", "sabar-drum", "slit-drum", "talking-drum",
"udu-drum"};
String[] indianInstruments = {"dafli-drum", "dholak-drum", "ghatam-drum", "jaltarang",
"kanjira", "khartal", "morsing", "tabla"};

//Array of Instruments
Instrument[] drumset = new Instrument[numberOfInstruments];

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
Boolean isBgDrawn = false;

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
  
  PImage africaBackground = loadImage("img/africa/bg-img-africa.jpg");
  image(africaBackground, 0, 0, width, height);

  //Initialize Instruments
  for (int i = 0; i < numberOfInstruments; i++) {
    int pick = (int)Math.floor(Math.random() * africanInstruments.length);
    String instrument = africanInstruments[pick];
    drumset[i] = new Instrument(instrument, "img/africa/" + instrument + ".png", "SoundSamples/kick1.wav");
  }
  
  

  //Initialize Instrument Audio & Graphics
  for (int i = 0; i < numberOfInstruments; i++) {
    //initialize sound
    drumset[i].setAudio();

  }
  r.initializeRhythm();
  r.drawRhythm();
}

void draw() {

  color dirt = color(218, 162, 113);
  fill(dirt);
  stroke(dirt);
  rect(0, height - 200, width, 200);
  
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
      isSongMute = false;
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

  for (int i = 0; i < numberOfInstruments; i++) {
    drumset[i].drumAudio.close();
  }
  minim.stop();
  super.stop();
}