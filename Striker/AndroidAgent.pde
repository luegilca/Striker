public class AndroidAgent extends Agent {
  private float[] sensitivity;
  
  public AndroidAgent( Scene scene ) {
    super( scene.inputHandler( ) );    
    sensitivity = new float[]{ 10, 10, 10, 10 , 10, 10 };
  }
  
  public void setSensitivity( float[] _sensitivity ) {
    this.sensitivity = _sensitivity;
  }
  
  @Override
  public MotionEvent6 handleFeed( ) {  
    float rx = 0.0, ry = 0.0, rz = 0.0;
    float tx = 0.0, ty = 0.0, tz = 0.0;
    float[] rotation = gestureDetector.getRotation( );
    float[] translation = gestureDetector.getTranslation( );
    
    switch( (int)rotation[ 0 ] ) {      
      case -1:
        rx = rotation[ 1 ];
        break;
      case 0:
        ry = rotation[ 1 ];
        break;
      case 1:
        rz = rotation[ 1 ];
        break;
    }
    switch( (int)translation[ 0 ] ) {      
      case -1:
        tx = translation[ 1 ];
        break;
      case 0:
        ty = translation[ 1 ];
        break;
      case 1:
        tz = translation[ 1 ];
        break;
    }
    return new MotionEvent6( tx, ty, tz, rx, ry, rz, frames.input.Event.NO_MODIFIER_MASK, TOUCH_ID );
  }
}
