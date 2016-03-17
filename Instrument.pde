

class Instrument{
  String name;
  String culture;
  String discription;
  String soundLocation;
  Boolean isStruck;
  AudioSnippet drumAudio;

  Instrument(String name, String soundLocation){
    this.name = name;
    this.soundLocation = soundLocation;
    this.isStruck = false;

  }  
  void setCulture(String culture){
    this.culture = culture;
  }
  
  void setDiscription(String discription){
    this.discription = discription;
  }
  
  void setAudio(){
    this.drumAudio = minim.loadSnippet(this.soundLocation);
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
  
  Boolean isStruck(){
    return isStruck;
  }
  
  
}