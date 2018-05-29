import android.view.MotionEvent;

public class MultiTouchAgent extends Agent {
  private float[] sensitivity;
  
  public MultiTouchAgent( Scene scene ){
    super( scene.inputHandler( ) );
    sensitivity = new float[]{ 10, 10, 10, 10 , 10, 10 };
  }
  
  public void setSensitivity( float[] _sensitivity ) {
    this.sensitivity = _sensitivity;
  }
  
  
  
  @Override
  public MotionEvent6 handleFeed( ) {
    return new MotionEvent6(
      0,0,0,0,0,0
    );
  }
}