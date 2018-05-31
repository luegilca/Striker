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
    float[] rotation = rotationDetector.getRotation( );
    float rx = 0.0;
    float ry = 0.0;
    float rz = 0.0;
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
    return new MotionEvent6( 0, 0, 0, rx, ry, rz );
  }
}