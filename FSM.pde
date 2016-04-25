
/**
 * A simple finite state machine class used for the game logic
 *
 * @author Edwin Choate
 */
public class FSM {
  
  
  private GameState startState;
  private GameState worldMapState;
  private GameState levelSetupState;
  private GameState levelState;
  private GameState currentState;
  
  public FSM() {
    this.startState = new GameState("start", 0);
    this.worldMapState = new GameState("worldmap", 1);
    this.levelSetupState = new GameState("levelsetup", 2);
    this.levelState = new GameState("level", 3);
    this.currentState = this.startState;
    
    this.startState.setNext(worldMapState);
    this.startState.setPrev(null);
    
    this.worldMapState.setNext(levelSetupState);
    this.worldMapState.setPrev(startState);
    
    this.levelSetupState.setNext(levelState);
    this.levelSetupState.setPrev(worldMapState);
    
    this.levelState.setNext(worldMapState);
    this.levelState.setPrev(levelSetupState);
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