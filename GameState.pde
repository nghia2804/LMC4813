
/**
 * A class that represents a generic game state. Instances of this class are 
 * used by the FSM class to establish a finite state machine transition matrix
 *
 * @author Edwin Choate
 */

public class GameState {
  
  private String name;       // the name of the game state - this is game-specific
  private int value;         // integer value for the state - splash screen should be 0 and so on...
  private GameState next;
  private GameState prev;
  
  public GameState(String name, int value) {
    this.name = name;
    this.value = value;
  }
  
  public String getName() {
    return this.name;
  }
  
  public int getVal() {
    return this.value; 
  }
  
  public GameState getNext() {
    return this.next; 
  }
  
  public void setNext(GameState next) {
    this.next = next;
  }
  
  public GameState getPrev() {
    return this.prev;
  }
  
  public void setPrev(GameState prev) {
    this.prev = prev;
  }
  
  public String toString() {
    return this.name; 
  }
  
}