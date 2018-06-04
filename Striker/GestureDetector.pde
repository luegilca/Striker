public class GestureDetector{
    private float[] rotation;
    private float[] translation;
    
    public GestureDetector( ) {
      this.rotation = new float[ 2 ];
      this.translation = new float[ 2 ];
    }
    
    public float[] getRotation( ) {
      return this.rotation; 
    }
    
    public float[] getTranslation( ) {
      return this.translation; 
    }
    
    public boolean onTouchEvent( MotionEvent me ){
      switch ( me.getActionMasked( ) ) {
        case MotionEvent.ACTION_DOWN:
        case MotionEvent.ACTION_POINTER_DOWN:
          reset( );
          break;
        case MotionEvent.ACTION_MOVE:
          if( me.getPointerCount( ) == 2 ) { 
            //Both fingers moving
            if( Helper.changedPosition( eventList[ 0 ], coordTolerance ) && Helper.changedPosition( eventList[ 1 ], coordTolerance ) ) {
              //Motion could be: Z - rotation or
              // If motion is pinching: Z - translation
              zRotation( eventList[ 0 ], eventList[ 1 ] );              
            }            
            //Pinned one finger
            else {
              if( ( !Helper.changedPosition( eventList[ 0 ], coordTolerance ) && Helper.changedPosition( eventList[ 1 ], coordTolerance ) ) ) {
                 //Rotate X or Y
                 xyRotation( eventList[ 1 ] );
              }
              //else if ( ( Helper.changedPosition( eventList[ 0 ], coordTolerance ) && !Helper.changedPosition( eventList[ 1 ], coordTolerance ) ) ) {
              //   //Rotate X or Y
              //   xyRotation( eventList[ 0 ] );
              //}
            }            
          }
          else if( me.getPointerCount( ) == 1 ) {
            xyTranslation( eventList[ 0 ] );
          }
          break;
        case MotionEvent.ACTION_POINTER_UP:
        case MotionEvent.ACTION_UP:
          reset( );
          break;  
      }
      return true;
    }
    
    private void reset( ) {
      direction = null;
      direction2 = null;
      rotation[ 0 ] = 0;
      rotation[ 1 ] = 0;
      translation[ 0 ] = 0;
      translation[ 1 ] = 0;
    }
    
    private void zRotation( MultiTouchEvent first, MultiTouchEvent second ) {
      float fX = second.pmotionX, fY = second.pmotionY, sX = first.pmotionX, sY = first.pmotionY, 
          nfX = second.motionX, nfY = second.motionY, nsX = first.motionX, nsY = first.motionY;      
      float angle = 0.0;
      float distance = 0.0;
      angle = Helper.angleBetweenLines( fX, fY, sX, sY, nfX, nfY, nsX, nsY );
      float prevDistance = distance( fX, fY, sX, sY );
      distance = distance( nfX, nfY, nsX, nsY );   
      if( angle < 0 ) 
        angle += rotationCalibration; 
      else 
        angle -= rotationCalibration;
      
      if( Math.abs(angle) > rotationCalibration ) {         
        direction = "Z in " + angle + " degrees";
        direction2 = null;        
        rotation[ 0 ] = 1.0;
        rotation[ 1 ] = angle;
        translation[ 0 ] = 1.0;
        translation[ 1 ] = 0.0;
      }
      else {
        direction = null;
        //Getting closer
        if( prevDistance > distance ) distance *= -1;
        if( Float.isNaN( distance ) ) distance = 0.0;
        direction2 = "Z with " + distance + " distance";
        event = "" + distance;
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
      
      if( Helper.changedXPosition( e, coordTolerance ) ) {
        amount = pX - x;
        direction = "X in " + amount + " degrees";
        orientation = -1.0;
      }
      else if( Helper.changedYPosition( e, coordTolerance ) ) {
        amount = -1 * (pY - y);
        direction = "Y in " + amount + " degrees";
        orientation = 0.0;
      }
      rotation[ 0 ] = orientation;
      rotation[ 1 ] = amount / 10;
      translation[ 0 ] = 0.0;
      translation[ 1 ] = 0.0;
    }
    
    private void xyTranslation( MultiTouchEvent first ) {
      float distance = 0.0;
      //X translation
      if( Helper.changedXPosition( first, coordTolerance ) ) {
        distance = first.pmotionX - first.motionX;
        direction2 = "X in " + distance + "units";
        translation[ 0 ] = -1.0;
        translation[ 1 ] = distance;
        rotation[ 0 ] = 0.0;
        rotation[ 1 ] = 0.0;
      }
      //Y translarion
      else if( Helper.changedYPosition( first, coordTolerance ) ) {
        distance = first.pmotionY - first.motionY;
        direction2 = "Y in " + distance + "units";
        translation[ 0 ] = 0.0;
        translation[ 1 ] = distance;
        rotation[ 0 ] = 0.0;
        rotation[ 1 ] = 0.0;
      } 
    }
    
    private float distance( float fX, float fY, float sX, float sY ) {
      double delta_x = ( fX - sX );
      double delta_y = ( fY - sY );
      return (float)Math.sqrt( delta_x * delta_x - delta_y * delta_y ) / distTolerance;
    }
}
