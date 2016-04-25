
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

FSM fsm = new FSM();
GameState gameState = fsm.currentState();


// Point
int point = 0;
int beatMillis = 0;
Boolean isBgDrawn = false;

void setup() {  
  size(800, 600);
  smooth();
  
  PImage titleScreen = loadImage("img/title-screen.jpg");
  image(titleScreen, 0, 0, width, height);
  
  time = 0;
  
  //song = minim.loadFile("80 BPM - Simple Straight Beat - Drum Track.mp3", 2048);
  //song.play();
  
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

  switch (gameState.getVal()) {
    case 0: // start state
      
    break; // end start state 
    case 1: // worldmap state
      
    break; // end worldmap state
    case 2: // level setup state
    
    break; // end level setup state
    
    case 3: // level state
    
      PImage africaBackground = loadImage("img/africa/bg-img-africa.jpg");
      image(africaBackground, 0, 0, width, height);
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
      } else {
        stroke(#FFFFFF);
      }
      line(0, 0, width, 0);
      line(0, 0, 0, height);
      line(width, 0, width, height);
      line(0, height, width, height);
      strokeWeight(1);
      
      
      time++;
      
    break; // end level state
    
    default:
    break;
  }
  
  
  
}

  

void keyPressed() {
  
  
  switch (gameState.getVal()) {
    case 0: // start state
    
      if (key == ' ') {
        
      } else if (key == ENTER) {
        gameState = fsm.nextState();
      } else if (key == CODED) {
        switch (keyCode) {
          case UP:
          
          break;
          case DOWN:
          
          break;
          case LEFT:
          
          break;
          case RIGHT:
          
          break;
          default:
          break;
        }
      }
    
    break; // end start state 
    case 1: // worldmap state
    
          if (key == ' ') {
        
          } else if (key == CODED) {
            switch (keyCode) {
              case UP:
              
              break;
              case DOWN:
              
              break;
              case LEFT:
              
              break;
              case RIGHT:
              
              break;
              default:
              break;
            }
          }
    
    break; // end worldmap state
    case 2: // level setup state
    
          if (key == ' ') {
            
          } else if (key == CODED) {
            switch (keyCode) {
              case UP:
              
              break;
              case DOWN:
              
              break;
              case LEFT:
              
              break;
              case RIGHT:
              
              break;
              default:
              break;
            }
          }
    
    break; // end level setup state
    case 3: // level state
    
          if (key == ' ') {
        
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
                makey.redrawUpBtn(color(0, 255, 0));
                drumset[0].isStruck = true;
                drumset[0].drumAudio.play(0);
                getPoint();
              break;
              case DOWN:
                makey.redrawDownBtn(color(0, 255, 0));
                drumset[1].isStruck = true;
                drumset[1].drumAudio.play(0);
                getPoint();
              break;
              case LEFT:
                makey.redrawLeftBtn(color(0, 255, 0));
                drumset[2].isStruck = true;
                drumset[2].drumAudio.play(0);
                getPoint();
              break;
              case RIGHT:
                makey.redrawRightBtn(color(0, 255, 0));
                drumset[3].isStruck = true;
                drumset[3].drumAudio.play(0);
                getPoint();
              break;
              default:
              break;
            }
          }
    
    break; // end level state
    default:
    break;
  }
  
  
}

void getPoint(){
  if ((millis() - beatMillis ) > 300) {
    point = point + 10;
  }
}

void mouseClicked() {
  
  switch (gameState.getVal()) {
    case 0: // start state
    
    break; // end start state 
    case 1: // worldmap state
    
    break; // end worldmap state
    case 2: // level setup state
    
    break; // end level setup state
    
    case 3: // level state
      makey.redrawClickBtn(color(0, 255, 0));
    break;
    default:
    break;
  }
  
   
}

void stop() {

  for (int i = 0; i < numberOfInstruments; i++) {
    drumset[i].drumAudio.close();
  }
  minim.stop();
  super.stop();
}