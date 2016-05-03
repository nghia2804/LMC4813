
/**
 * A simple finite state machine class used for the game logic
 *
 * @author Edwin Choate
 */
public class FSM {
  
  
  private GameState startState;
  private GameState worldMapState;
  private GameState modeSetupState;
  private GameState levelSetupState;
  private GameState africaLevelState;
  private GameState indiaLevelState;
  private GameState currentState;
  
  public FSM() {
    this.startState = new GameState("start", 0);
    this.worldMapState = new GameState("worldmap", 1);
    this.levelSetupState = new GameState("levelsetup", 2);
    this.africaLevelState = new GameState("africalevel", 3);
    this.modeSetupState = new GameState("modesetup", 4);
    this.indiaLevelState = new GameState("indialevel", 5);
    this.currentState = this.startState;
    
    this.startState.setNext(worldMapState);
    this.startState.setPrev(startState);
    
    this.worldMapState.setNext(modeSetupState);
    this.worldMapState.setPrev(startState);
    
    this.modeSetupState.setNext(levelSetupState);
    this.modeSetupState.setPrev(worldMapState);
    
    this.levelSetupState.setNext(africaLevelState);
    this.levelSetupState.setPrev(worldMapState);
    
    this.africaLevelState.setNext(worldMapState);
    this.africaLevelState.setPrev(levelSetupState);
    
    this.indiaLevelState.setNext(worldMapState);
    this.indiaLevelState.setPrev(levelSetupState);
  }
  
  public GameState currentState() {
    return this.currentState; 
  }
  
  public GameState nextState() {
    this.currentState = this.currentState.getNext();
    println("moved to " + this.currentState);
    return this.currentState;
  }
  
  public GameState prevState() {
    this.currentState = this.currentState.getPrev(); 
    println("moved to " + this.currentState);
    return this.currentState;
  }
  
  
}