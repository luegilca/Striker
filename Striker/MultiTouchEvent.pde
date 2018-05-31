public class MultiTouchEvent {
  // Public attrs that can be queried for each touch point:
  public float motionX, motionY;
  public float pmotionX, pmotionY;
  public float size, psize;
  public int id;
  public boolean touched = false;
  public boolean released = false;
 
  // Executed when this index has been touched:
  void update(MotionEvent me, int index) {
    // me : The passed in MotionEvent being queried
    // index : the index of the item being queried
 
    pmotionX = motionX;
    pmotionY = motionY;
    psize = size;
    
    motionX = me.getX( index );
    motionY = me.getY( index );
    size = me.getSize( index );
    id = me.getPointerId(index);
 
    int pointerIndex, pointerId;
 
    // Cada MotionEvent tiene asociada una ACTION, que puede ser ACTION_UP o ACTION_DOWN.
    // Esta parte del código nos permite distinguir entre unas y otras, y así
    // incorporar la detección de "release"
    switch( me.getAction( ) & MotionEvent.ACTION_MASK ) {
      case MotionEvent.ACTION_DOWN:
        touched = true;
        released = false;
        break;
      case MotionEvent.ACTION_UP:
        touched = false;
        released = true;
        break;
      case MotionEvent.ACTION_MOVE:
        touched = true;
        released = false;
        break;
      case MotionEvent.ACTION_POINTER_DOWN:
        pointerIndex = (me.getAction() & MotionEvent.ACTION_POINTER_INDEX_MASK) >> MotionEvent.ACTION_POINTER_INDEX_SHIFT;
        pointerId = me.getPointerId(pointerIndex);  
        if (pointerId == id) {
          touched = true;
          released = false;        
        }
        break;
      case MotionEvent.ACTION_POINTER_UP:
        pointerIndex = (me.getAction() & MotionEvent.ACTION_POINTER_INDEX_MASK) >> MotionEvent.ACTION_POINTER_INDEX_SHIFT;
        pointerId = me.getPointerId(pointerIndex);    
        if (pointerId == id) {
          touched = false;
          released = true;
        }
        break;
    }
  }
 
  // Executed if this index hasn't been touched:
  void update() {
    pmotionX = motionX;
    pmotionY = motionY;
    psize = size;
    if (touched) {
      released = true;
      touched = false;
    }
    else released = false;
  }
  
  @Override
  public String toString( ) {
    return "ID: " + id + " prev <" + pmotionX + "," + pmotionY + "," + psize + "> motion<" 
    + motionX + "," + motionY + "," + size 
    + "> --> TOUCHED: " + touched + " - RELEASED:" + released;
  }
}