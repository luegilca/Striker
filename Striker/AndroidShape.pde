public class AndroidShape extends Shape {  
  public AndroidShape(Scene scene) {    
    super(scene);
  }
  
  public AndroidShape(Node node) {
    super(node);
  }
  
  public AndroidShape(Scene scene, PShape pShape) {
    super(scene, pShape);
  }

  // this one gotta be overridden because we want a copied node
  // to have the same behavior as its original.
  protected AndroidShape(Scene otherScene, AndroidShape otherShape) {
    super(otherScene, otherShape);
  }

  @Override
  public AndroidShape get() {
    return new AndroidShape(this.graph(), this);
  }

  // behavior is here
  @Override
  public void interact(frames.input.Event ev) {
    if( ev.shortcut( ).matches( new Shortcut(TOUCH_ID ) ) ) {
      MotionEvent6 motion = ( MotionEvent6 )ev;
      float tx = motion.dx( );
      float ty = motion.dy( );
      float tz = motion.dz( );
      float rx = motion.drx( );
      float ry = motion.dry( );
      float rz = motion.drz( );
      this.rotate( new Quaternion( rx, ry, rz ) );
      this.translate( new Vector( tx, ty, tz ) );
    }
  }
}
