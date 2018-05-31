public class RotationGestureDetector implements GestureDetector {
    private float mAngle;
    private float toleranceX, toleranceY;
    
    public RotationGestureDetector( ) {
      this.toleranceX = 8;
      this.toleranceY = 8;
    }
    
    public RotationGestureDetector( float _toleranceX, float _toleranceY ) {
      this.toleranceX = _toleranceX;
      this.toleranceY = _toleranceY;
    }

    public float getAngle() {
        return mAngle;
    }
    
    public boolean onTouchEvent( MotionEvent me ){
      switch ( me.getActionMasked( ) ) {
        case MotionEvent.ACTION_POINTER_DOWN:
          println( "POINTERDOWN" );
          break;
        case MotionEvent.ACTION_MOVE:
          println( "MOVING" );
          println( "is moving first?: " + changedPosition( eventList[ 0 ] ));
          println( "is moving secondo?: " + changedPosition( eventList[ 1 ] ) );
          //Attempting XY Rotations
          // Pinned first finger
          float[] rotation = null;
          if( ( !changedPosition( eventList[ 0 ] ) && changedPosition( eventList[ 1 ] ) ) ) {
             //Rotate X or Y
             rotation  = xyRotation( eventList[ 1 ] );             
          }
          else if( !changedPosition( eventList[ 1 ] ) && changedPosition( eventList[ 0 ] ) ) {
             //Rotate X or Y
             rotation = xyRotation( eventList[ 0 ] );             
          }
          //Z rotation, both fingers moving
          else if( changedPosition( eventList[ 0 ] ) && changedPosition( eventList[ 1 ] ) ) {
             //Rotate X or Y
             rotation = zRotation( eventList[ 0 ], eventList[ 1 ] );             
          }
          println( rotation );
          break;
        case MotionEvent.ACTION_POINTER_UP:
          println( "POINTERUP" );
          break;
          
      }
      return true;
    }
    
    private float[] zRotation( MultiTouchEvent first, MultiTouchEvent second ) {
      println( "ROTATING in Z" );
      direction = "Z";
      float fX = first.motionX;
      float fY = first.motionY;
      float sX = second.motionX;
      float sY = second.motionY;
      double delta_x = ( fX - sX );
      double delta_y = ( fY - sY );
      double radians = Math.atan2( delta_y, delta_x );
      // -1 for X, 0 for Y, 1 for Z
      return new float[]{ 1.0, (float) Math.toDegrees(radians)};
    }
    
    private float[] xyRotation( MultiTouchEvent e ) {
      float pX = e.pmotionX;
      float pY = e.pmotionY;
      float x = e.motionX;
      float y = e.motionY;
      float amount = 0.0;
      // -1 for X, 0 for Y, 1 for Z
      float orientation = 0.0;
      
      if( changedXPosition( e ) ) {
        println( "ROTATING in X" );
        direction = "X";
        amount = Math.abs( pX - x );
        orientation = -1.0;
      }
      else if( changedYPosition( e ) ) {
        println( "ROTATING in Y" );
        direction = "Y";
        amount = Math.abs( pY - x );
        orientation = 0.0;
      }
      return new float[]{ orientation, amount }; 
    }
    
    private boolean changedXPosition( MultiTouchEvent e ) {
      return Math.abs( e.motionX - e.pmotionX ) > toleranceX;
    }
    private boolean changedYPosition( MultiTouchEvent e ) {
      return Math.abs( e.motionY - e.pmotionY ) > toleranceY;
    }
    private boolean changedPosition( MultiTouchEvent e ) {
      return changedXPosition( e ) || changedYPosition( e );
    }
}