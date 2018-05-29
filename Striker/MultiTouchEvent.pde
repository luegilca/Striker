public class MultiTouchEvent {
  public PointList list;
  private final int INVALID_POINTER_ID = -1;
  private final int MAX_TOUCHES = 3;  
  
  public MultiTouchEvent( ) {
    this.list = new PointList( );
  }
  
}