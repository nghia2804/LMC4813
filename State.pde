import java.awt.Graphics;
import java.awt.event.KeyListener;
import java.awt.event.MouseListener;

public abstract class State {

  private boolean paused = false;
  private StateChangeListener listener = null;
  private State previousState = null;
  private KeyListener keyListener = null;
  private MouseListener mouseListener = null;
  
  public abstract void init();
  public abstract void render( Graphics g );
  public abstract void cleanup();
  protected abstract void concreteUpdate( long dt );
  
  public State() {
    super();
    // TODO Auto-generated constructor stub
  }
  
  public final void update( long dt ) {
    if( !paused ) {
      concreteUpdate( dt );
    }
  }
  
  public StateChangeListener getListener() {
    return listener;
  }

  public void setListener(StateChangeListener listener) {
    this.listener = listener;
  }

  public State getPreviousState() {
    return previousState;
  }
  
  public void setPreviousState(State previousState) {
    this.previousState = previousState;
  }
  
  public final boolean isPaused() {
    return paused;
  }

  public final void setPaused(boolean paused) {
    this.paused = paused;
  }
  
  public final KeyListener getKeyListener() {
    return keyListener;
  }
  
  public final void setKeyListener(KeyListener keyListener) {
    this.keyListener = keyListener;
  }
  
  public final MouseListener getMouseListener() {
    return mouseListener;
  }
  
  public final void setMouseListener(MouseListener mouseListener) {
    this.mouseListener = mouseListener;
  }

  
}

/**
 * This interface is used to tell the Context object of the StateMachine when 
 * to move to the next state.
 */
public interface StateChangeListener {

  public void stateChanged( State nextState );

  public void exit();
}