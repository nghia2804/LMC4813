

class Instrument {
  String name;
  String culture;
  String discription;
  String imgLocation;
  String soundLocation;
  Boolean isStruck;
  PImage thumbnail;
  AudioSnippet drumAudio;

  Instrument(String name, String imgLocation, String soundLocation){
    this.name = name;
    this.imgLocation = imgLocation;
    this.soundLocation = soundLocation;
    this.isStruck = false;
    this.thumbnail = loadImage(imgLocation);
  }  
  void setCulture(String culture){
    this.culture = culture;
  }
  
  void setDiscription(String discription){
    this.discription = discription;
  }
  
  void setAudio(){
    this.drumAudio = minim.loadSnippet(this.soundLocation);
    System.out.println("Set audio" + this.name); //<>//
  }
  
  void drawInstrument(int xPos, int yPos, int w, int h) {
    imageMode(CORNER);
    image(this.thumbnail, xPos, yPos, w, h);
  }
  
  String getCulture(){
    return this.culture;
  }
  
  String getDiscription(){
    return this.discription;
  }
  
  String getsoundLocation(){
    return this.soundLocation;
  }
  
  PImage getThumbnail() {
    return this.thumbnail; 
  }
  
  Boolean isStruck(){
    return isStruck;
  }
  
  
}