
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
AudioPlayer africaBgMusic;
AudioPlayer titleSong;
Boolean isAfricaSongMute = false;
BeatDetect b;

//Timer
int time;

//sound variables-------------
public static final int MAX_INSTRUMENTS = 6;
int numberOfInstruments = 0;
String[] africanInstruments = {"axatse", "balaphone", "bougarabou", "caxixi", "djembe",
"djun-djun", "embaire", "ewe-drum", "gankogui", "sabar-drum", "slit-drum", "talking-drum",
"udu-drum"};
String[] indianInstruments = {"dafli-drum", "dholak-drum", "ghatam-drum", "jaltarang",
"kanjira", "khartal", "morsing", "tabla"};

//Array of Instruments
Instrument[] drumset;

// rhythm variables-----------
Rhythm r;

//Graphic Viz-----------------
GraphicViz viz;

//Makeymakey variables--------
//MakeyMakey(int xPosition, int yPosition, int screenWidth)
MakeyMakey makey = new MakeyMakey(50, 500, 100);  
MakeyMakey setupMakey = new MakeyMakey(220, 240, 320);

// Booleans for representing which MakeyMakey buttons are enabled at a given point in time
boolean makeyUpEnabled, makeyDownEnabled, makeyLeftEnabled, makeyRightEnabled, makeySpaceEnabled, makeyClickEnabled;

FSM fsm = new FSM();
GameState gameState = fsm.currentState();

boolean canDrawBg;

// Background images
PImage titleScreen;
PImage worldMapAfrica;
PImage worldMapIndia;
PImage levelSetupBg;
PImage numOne, numTwo, numThree, numFour, numFive, numSix;
PImage africaBackground;

color bgBlue = color(171, 245, 254);

// Helper vars
String selectedCulture;

// Point
int point = 0;
int beatMillis = 0;
Boolean isBgDrawn = false;

void setup() {  
  size(800, 600);
  smooth();
  
  canDrawBg = true;
  
  
  time = 0;
  
  titleSong = minim.loadFile("./SoundSamples/title-music.mp3", 2048);
  titleSong.loop();
  
  africaBgMusic = minim.loadFile("./SoundSamples/title-music.mp3", 2048);
  
  // ...
  minim = new Minim(this);
}

void draw() {

  switch (gameState.getVal()) {
    case 0: // start state
      titleSong.play();
      
      if (canDrawBg) {
        titleScreen = loadImage("img/title-screen.jpg");
        image(titleScreen, 0, 0, width, height);
        canDrawBg = false;
      }
      
    break; // end start state 
    case 1: // worldmap state
      titleSong.play();
      
      if (selectedCulture == "india") {
        if (canDrawBg) {
          worldMapIndia = loadImage("img/world-map-sel-india.jpg");
          image(worldMapIndia, 0, 0, width, height);
          canDrawBg = false;
        }
      } else {
        if (canDrawBg) {
          worldMapAfrica = loadImage("img/world-map-sel-africa.jpg");
          image(worldMapAfrica, 0, 0, width, height);
          canDrawBg = false;
        }
      }
      
      
    break; // end worldmap state
    case 2: // level setup state
      titleSong.play();
      
      if (canDrawBg) {
        levelSetupBg = loadImage("img/level-setup-screen.jpg");
        image(levelSetupBg, 0, 0, width, height);
        canDrawBg = false;
      }
      
      setupMakey.drawMakey();
      
      color yellow = color(225, 225, 0);
      
      if (makeyUpEnabled) {
        setupMakey.redrawUpBtn(yellow);
      }
      
      if (makeyDownEnabled) {
        setupMakey.redrawDownBtn(yellow);
      }
      
      if (makeyLeftEnabled) {
        setupMakey.redrawLeftBtn(yellow); 
      }
      
      if (makeyRightEnabled) {
        setupMakey.redrawRightBtn(yellow); 
      }
      
      if (makeySpaceEnabled) {
        setupMakey.redrawSpaceBtn(yellow); 
      }
      
      if (makeyClickEnabled) {
        setupMakey.redrawClickBtn(yellow);
      }
        
      int x, y, w, h;
      x = 550;
      y = 430;
      w = 64;
      h = w;
      
      fill(bgBlue);
      stroke(bgBlue);
      rect(x, y, w, h);
      
      switch (numberOfInstruments) {

        case 1:
          numOne = loadImage("img/number-01.png");
          image(numOne, x, y, w, h);
        break;
        case 2:
          numTwo = loadImage("img/number-02.png");
          image(numTwo, x, y, w, h);
        break;
        case 3:
          numThree = loadImage("img/number-03.png");
          image(numThree, x, y, w, h);
        break;
        case 4:
          numFour = loadImage("img/number-04.png");
          image(numFour, x, y, w, h);
        break;
        case 5:
          numFive = loadImage("img/number-05.png");
          image(numFive, x, y, w, h);
        break;
        case 6:
          numSix = loadImage("img/number-06.png");
          image(numSix, x, y, w, h);
        break;
      }
    
      
    break; // end level setup state
    
    case 3: // africa level state
      titleSong.pause();
    
      if (canDrawBg) {
        africaBackground = loadImage("img/africa/bg-img-africa.jpg");
        image(africaBackground, 0, 0, width, height);
        canDrawBg = false;
      }
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
      
      //b.detect(song.mix);
      
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
      
    break; // end africa level state
    
    default:
    break;
  }
  
  
  
}

  
void setupAfricaLevel(int drumCount) {
  
  drumset = new Instrument[drumCount];
  
  // a beat detection object song SOUND_ENERGY mode with a sensitivity of 10 milliseconds
  b = new BeatDetect();
  
  //Initialize rhythm with tempo (beats/minute)
  r = new Rhythm(60);
  
  //
  viz = new GraphicViz(60,400);
  viz.initializeViz();

  //Initialize Instruments
  for (int i = 0; i < drumCount; i++) {
    int pick = (int)Math.floor(Math.random() * africanInstruments.length);
    String instrument = africanInstruments[pick];
    drumset[i] = new Instrument(instrument, "img/africa/" + instrument + ".png", "SoundSamples/kick1.wav");
  }
  
  

  //Initialize Instrument Audio & Graphics
  for (int i = 0; i < drumCount; i++) {
    //initialize sound
    drumset[i].setAudio();

  }
  r.initializeRhythm();
  r.drawRhythm(); 
  
}


void keyPressed() {
  
  
  switch (gameState.getVal()) {
    case 0: // start state
    
      if (key == ' ') {
        
      } else if (key == ENTER) {
        gameState = fsm.nextState();
        canDrawBg = true;
        selectedCulture = "africa";
        africaBgMusic.play();
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
        
          } else if (key == ENTER) {
            println(selectedCulture + " was selected");
            gameState = fsm.nextState();
            canDrawBg = true;
          } else if (key == BACKSPACE) {
            gameState = fsm.prevState();
            canDrawBg = true;
          } else if (key == CODED) {
            switch (keyCode) {
              case UP:
              
              break;
              case DOWN:
              
              break;
              case LEFT:
                selectedCulture = "africa";
                canDrawBg = true;
              break;
              case RIGHT:
                selectedCulture = "india";
                canDrawBg = true;
              break;
              default:
              break;
            }
          }
    
    break; // end worldmap state
    case 2: // level setup state
    
          if (key == ' ') {
            makeySpaceEnabled = !makeySpaceEnabled;
          } else if (key == BACKSPACE) {
            gameState = fsm.prevState();
            canDrawBg = true;
          } else if (key == ENTER) {
            
            if (numberOfInstruments >= 1 && numberOfInstruments <= 6) {
              gameState = fsm.nextState();
              canDrawBg = true;
              
              setupAfricaLevel(numberOfInstruments);
              
            }
            
          } else if (key == CODED) {
            switch (keyCode) {
              case UP:
                makeyUpEnabled = !makeyUpEnabled;
              break;
              case DOWN:
                makeyDownEnabled = !makeyDownEnabled;
              break;
              case LEFT:
                makeyLeftEnabled = !makeyLeftEnabled;
              break;
              case RIGHT:
                makeyRightEnabled = !makeyRightEnabled;
              break;
              default:
              break;
            }
          }
          
          boolean[] enables = { makeyUpEnabled, makeyDownEnabled, makeyLeftEnabled, makeyRightEnabled, 
            makeySpaceEnabled, makeyClickEnabled };
            
          numberOfInstruments = 0; // reset drum count
           
          for (int i = 0; i < enables.length; i++) {
            numberOfInstruments += ( (enables[i]) ? 1 : 0 );
          }
    
    break; // end level setup state
    case 3: // africa level state
    
          if (key == ' ') {
        
            makey.redrawSpaceBtn(color(0, 255, 0));
            if (isAfricaSongMute == false){ 
              africaBgMusic.mute();
              isAfricaSongMute= true;
            } else { 
              africaBgMusic.unmute();
              isAfricaSongMute = false;
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
                if (numberOfInstruments >= 2) {
                  makey.redrawDownBtn(color(0, 255, 0));
                  drumset[1].isStruck = true;
                  drumset[1].drumAudio.play(0);
                  getPoint();
                }
              break;
              case LEFT:
                if (numberOfInstruments >= 3) {
                  makey.redrawLeftBtn(color(0, 255, 0));
                  drumset[2].isStruck = true;
                  drumset[2].drumAudio.play(0);
                  getPoint();
                }
              break;
              case RIGHT:
                if (numberOfInstruments >= 4) {
                  makey.redrawRightBtn(color(0, 255, 0));
                  drumset[3].isStruck = true;
                  drumset[3].drumAudio.play(0);
                  getPoint();
                }
              break;
              default:
              break;
            }
          }
    
    break; // end africa level state
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
    
      makeyClickEnabled = !makeyClickEnabled;
            
      boolean[] enables = { makeyUpEnabled, makeyDownEnabled, makeyLeftEnabled, makeyRightEnabled, 
            makeySpaceEnabled, makeyClickEnabled };      
            
      numberOfInstruments = 0; // reset drum count
       
      for (int i = 0; i < enables.length; i++) {
        numberOfInstruments += ( (enables[i]) ? 1 : 0 );
      }
    
    break; // end level setup state
    
    case 3: // africa level state
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