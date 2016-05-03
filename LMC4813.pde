
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
"djun-djun", "embaire", "gankogui", "sabar-drum", "slit-drum", "talking-drum",
"udu-drum"};
String[] indianInstruments = {"dholak-drum", "jaltarang",
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
boolean hasDrawnDjembeScreen;

// Background images
PImage titleScreen;
PImage worldMapAfrica;
PImage worldMapIndia;
PImage levelSetupBg;
PImage numOne, numTwo, numThree, numFour, numFive, numSix;
PImage africaBackground;
PImage africaSelectTutorial;
PImage africaSelectFreeplay;
PImage indiaBackground;
PImage indiaSelectTutorial;
PImage indiaSelectFreeplay;
PImage djembeLevelBackground;
PImage djembeIntroImg;


color bgBlue = color(171, 245, 254);

// Helper vars
String selectedCulture;
String selectedMode;

// Point
int point = 0;
int beatMillis = 0;
Boolean isBgDrawn = false;

void setup() {  
  size(800, 600);
  smooth();
  
  canDrawBg = true;
  hasDrawnDjembeScreen = false;
  
  
  time = 0;
  
  titleSong = minim.loadFile("./SoundSamples/title-music.mp3", 2048);
  
  africaBgMusic = minim.loadFile("./SoundSamples/title-music.mp3", 2048);
  
  // ...
  minim = new Minim(this);
}

void draw() {

  switch (gameState.getVal()) {
    case 0: // start state
      
      if (canDrawBg) {
        titleScreen = loadImage("img/title-screen-new.jpg");
        image(titleScreen, 0, 0, width, height);
        canDrawBg = false;
      }
      
    break; // end start state 
    case 1: // worldmap state
      
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
    
      if (canDrawBg) {
        africaBackground = loadImage("img/bg-img-africa.jpg");
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
    
    case 4: // mode setup state
    
      if (selectedCulture == "india") { // india setup
        
        if (selectedMode == "tutorial") {
          if (canDrawBg) {
            indiaSelectTutorial = loadImage("img/bg-img-south-asia-tutorial-sel.jpg");
            image(indiaSelectTutorial, 0, 0, width, height);
            canDrawBg = false;
          }
        } else { // selected mode is 'freeplay'
          if (canDrawBg) {
            indiaSelectFreeplay = loadImage("img/bg-img-south-asia-freeplay-sel.jpg");
            image(indiaSelectFreeplay, 0, 0, width, height);
            canDrawBg = false;
          }
        }
        
      } else { // africa setup
        
        if (selectedMode == "tutorial") {
          if (canDrawBg) {
            africaSelectTutorial = loadImage("img/bg-img-africa-tutorial-sel.jpg");
            image(africaSelectTutorial, 0, 0, width, height);
            canDrawBg = false;
          }
        } else {
          if (canDrawBg) {
            africaSelectFreeplay = loadImage("img/bg-img-africa-freeplay-sel.jpg");
            image(africaSelectFreeplay, 0, 0, width, height);
            canDrawBg = false;
          }
        }
        
        
        
      }
    
    break; // end mode setup state
    
    case 5: // india level state
      if (canDrawBg) {
        println("drawing india bg");
        indiaBackground = loadImage("img/bg-img-south-asia.jpg");
        image(indiaBackground, 0, 0, width, height);
        canDrawBg = false;
      }

      
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
    break; // end of india level state
    
    case 6: // djembe tutorial level state 
      if (canDrawBg) {
        djembeLevelBackground = loadImage("img/bg-img-djembe.jpg");
        image(djembeLevelBackground, 0, 0, width, height); 
        canDrawBg = false;
      }
    break; // end djembe tutorial level state
    
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
    drumset[i] = new Instrument(instrument, "img/" + instrument + ".png", "sound/" + instrument + ".wav");
  }
  
  

  //Initialize Instrument Audio & Graphics
  for (int i = 0; i < drumCount; i++) {
    //initialize sound
    drumset[i].setAudio();

  }
  r.initializeRhythm();
  r.drawRhythm(); 
  
}

void setupIndianLevel(int drumCount) {
  
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
    int pick = (int)Math.floor(Math.random() * indianInstruments.length);
    String instrument = indianInstruments[pick];
    drumset[i] = new Instrument(instrument, "img/" + instrument + ".png", "sound/" + instrument + ".wav");
  }
  
  

  //Initialize Instrument Audio & Graphics
  for (int i = 0; i < drumCount; i++) {
    //initialize sound
    drumset[i].setAudio();

  }
  r.initializeRhythm();
  r.drawRhythm(); 
  
}


void setupDjembeLevel(int drumCount) {
   
}


void keyPressed() {
  
  if (key == BACKSPACE) {
    gameState = fsm.prevState();
    canDrawBg = true;  
  } 
  
  switch (gameState.getVal()) {
    case 0: // start state
    
      if (key == ' ') {
        
      } else if (key == ENTER) {
        gameState = fsm.nextState();
        canDrawBg = true;
        selectedCulture = "africa";
        selectedMode = "tutorial";
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
          } else if (key == ENTER) {
            
            if (selectedMode == "freeplay" && numberOfInstruments >= 1 && numberOfInstruments <= 6) {
              gameState = fsm.nextState();
              canDrawBg = true;
              
              if (selectedCulture == "africa") {
                setupAfricaLevel(numberOfInstruments);
              } else {
                setupIndianLevel(numberOfInstruments); 
              }
              
              canDrawBg = true;
              
            } else if (selectedMode == "tutorial" && selectedCulture == "africa" && numberOfInstruments >= 3 && numberOfInstruments <= 6) {
              gameState = fsm.goToDjembeLevel();
              canDrawBg = true;
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
    case 4: // mode setup state
      
      if (key == ENTER) {
        if (selectedCulture == "india") {
          if (selectedMode == "tutorial") {
            println("Sorry... this tutorial level is not implemented yet!");  
          } else { // freeplay mode india
            gameState = fsm.nextState();
            canDrawBg = true;
          }
        } else { // selected culture africa
          if (selectedMode == "tutorial") {
            if (!hasDrawnDjembeScreen) {
              djembeIntroImg = loadImage("img/screen-djembe.jpg");
              image(djembeIntroImg, 0, 0, width, height);
              canDrawBg = false;
              hasDrawnDjembeScreen = true;
            } else {
              gameState = fsm.nextState(); 
              canDrawBg = true;
            }
            
          } else { // freeplay mode africa
            gameState = fsm.nextState();
            canDrawBg = true;
          }
        }
      } else {
        switch (keyCode) {
          case UP:
            selectedMode = "tutorial";
            canDrawBg = true;
          break;
          case DOWN:
            selectedMode = "freeplay";
            canDrawBg = true;
          break;
          default: 
          
          break;
        }
      }
      
    break; // end mode setup state
    
    case 6: // djembe tutorial level state
      
    break; // end djembe tutorial level state
    
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

void delay(int delay) {
  int time = millis();
  while(millis() - time <= delay);
}

void stop() {

  for (int i = 0; i < numberOfInstruments; i++) {
    drumset[i].drumAudio.close();
  }
  minim.stop();
  super.stop();
}