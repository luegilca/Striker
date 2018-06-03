public class GestureDetector{
    private float mAngle;
    private float toleranceX, toleranceY, distanceTolerance;
    private float[] rotation;
    private float[] translation;
    
    public GestureDetector( ) {
      this.toleranceX = 6;
      this.toleranceY = 6;
      this.distanceTolerance = 100;
      this.rotation = new float[ 2 ];
      this.translation = new float[ 2 ];
    }
    
    public GestureDetector( float _toleranceX, float _toleranceY, float _distanceTolerance ) {
      this.toleranceX = _toleranceX;
      this.toleranceY = _toleranceY;
      this.distanceTolerance = _distanceTolerance;
      this.rotation = new float[ 2 ];
      this.translation = new float[ 2 ];
    }
    
    public float[] getRotation( ) {
      return rotation; 
    }
    
    public float[] getTranslation( ) {
      return translation; 
    }
    
    public boolean onTouchEvent( MotionEvent me ){
      switch ( me.getActionMasked( ) ) {
        case MotionEvent.ACTION_POINTER_DOWN:
          direction = null;
          direction2 = null;
          break;
        case MotionEvent.ACTION_MOVE:
          if( me.getPointerCount( ) == 2 ) { 
            //Both fingers moving
            if( changedPosition( eventList[ 0 ] ) && changedPosition( eventList[ 1 ] ) ) {
              //Motion could be: Z - rotation or
              // If motion is pinching: Z - translation
              zMotions( eventList[ 0 ], eventList[ 1 ] );
              
            }            
            //Pinned one finger
            else {
              if( ( !changedPosition( eventList[ 0 ] ) && changedPosition( eventList[ 1 ] ) ) ) {
                 //Rotate X or Y
                 xyRotation( eventList[ 1 ] );
              }
              else if( !changedPosition( eventList[ 1 ] ) && changedPosition( eventList[ 0 ] ) ) {
                 //Rotate X or Y
                 xyRotation( eventList[ 0 ] ); 
              }
            }            
          }
          else if( me.getPointerCount( ) == 1 ) {
            
          }
          break;
        case MotionEvent.ACTION_POINTER_UP:
          direction = null;
          direction2 = null;
          rotation[ 0 ] = 0;
          rotation[ 1 ] = 0;
          translation[ 0 ] = 0;
          translation[ 1 ] = 0;
          break;   
        case MotionEvent.ACTION_UP:
          direction = null;
          direction2 = null;
          rotation[ 0 ] = 0;
          rotation[ 1 ] = 0;
          translation[ 0 ] = 0;
          translation[ 1 ] = 0;
          break;  
      }
      return true;
    }
    
    private float distance( float fX, float fY, float sX, float sY ) {
      double delta_x = ( fX - sX );
      double delta_y = ( fY - sY );
      return (float)Math.sqrt( delta_x * delta_x - delta_y * delta_y ) / distTolerance;
    }
    
    private void zMotions( MultiTouchEvent first, MultiTouchEvent second ) {
      float fX = second.pmotionX, fY = second.pmotionY, sX = first.pmotionX, sY = first.pmotionY, 
          nfX = second.motionX, nfY = second.motionY, nsX = first.motionX, nsY = first.motionY;      
      float angle = 0.0;
      float distance = 0.0;
      angle = angleBetweenLines ( fX, fY, sX, sY, nfX, nfY, nsX, nsY );
      distance = distance( nfX, nfY, nsX, nsY );    
      
      if( Math.abs(angle) > rotationCalibration ) {  
        if( angle < 0 ) angle += rotationCalibration; 
        else angle -= rotationCalibration;
        direction = "Z in " + angle + " degrees";
        direction2 = null;        
        rotation[ 0 ] = 1.0;
        rotation[ 1 ] = angle;
        translation[ 0 ] = 1.0;
        translation[ 1 ] = 0.0;
      }
      else {
        direction = null;
        direction2 = "Z with " + distance + " distance";
        rotation[ 0 ] = 1.0;
        rotation[ 1 ] = 0.0;
        translation[ 0 ] = 1.0;
        translation[ 1 ] = distance;
      }      
    }
    
    private void xyRotation( MultiTouchEvent e ) {
      float pX = e.pmotionX;
      float pY = e.pmotionY;
      float x = e.motionX;
      float y = e.motionY;
      float amount = 0.0;
      float orientation = 0.0;
      
      if( changedXPosition( e ) ) {
        amount = Math.abs( pX - x );
        direction = "X in " + amount + " degrees";
        orientation = -1.0;
      }
      else if( changedYPosition( e ) ) {
        amount = Math.abs( pY - y );
        direction = "Y in " + amount + " degrees";
        orientation = 0.0;
      }
      rotation[ 0 ] = orientation;
      rotation[ 1 ] = amount;
    }
    
    //Adaptation from method found in: https://stackoverflow.com/questions/10682019/android-two-finger-rotation
    private float angleBetweenLines (float fX, float fY, float sX, float sY, float nfX, float nfY, float nsX, float nsY) {
      float angle1 = ( float ) Math.atan2( ( fY - sY ), ( fX - sX ) );
      float angle2 = ( float ) Math.atan2( ( nfY - nsY ), ( nfX - nsX ) );

      float angle = ( ( ( float ) Math.toDegrees( angle1 - angle2 ) ) % 360 ) * 18;
      if (angle < -180.f) angle += 360.0f;
      if (angle > 180.f) angle -= 360.0f;
      return angle;
    }
    
    private boolean changedXPosition( MultiTouchEvent e ) {
      return Math.abs( e.motionX - e.pmotionX ) > coordTolerance;
    }
    private boolean changedYPosition( MultiTouchEvent e ) {
      return Math.abs( e.motionY - e.pmotionY ) > coordTolerance;
    }
    private boolean changedPosition( MultiTouchEvent e ) {
      return changedXPosition( e ) || changedYPosition( e );
    }
}
