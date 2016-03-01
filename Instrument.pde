

class Instrument{
  String name;
  String culture;
  String discription;
  String soundLocation;

  Instrument(String name, String soundLocation){
    this.name = name;
    this.soundLocation = soundLocation;

  }  
  void setCulture(String culture){
    this.culture = culture;
  }
  
  void setDiscription(String discription){
    this.discription = discription;
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
  
  
}