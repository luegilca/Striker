public class AndroidShape extends Shape {  
  public AndroidShape(Scene scene) {
    super(scene);
    scene.drawAxes();
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
    println( ev.shortcut().id( ) + " " + ev.shortcut().modifiers());
    //if (ev.shortcut().matches(new Shortcut(TOUCH_ID)))
    //  translateRotateXYZ(ev);
    //if (ev.shortcut().matches(new Shortcut(RIGHT)))
    //  translate(ev);
    //if (ev.shortcut().matches(new Shortcut(LEFT)))
    //  rotate(ev);
    //if (ev.shortcut().matches(new Shortcut(CENTER)))
    //  rotate(ev);
    ////if (ev.shortcut().matches(new Shortcut(processing.event.MouseEvent.WHEEL)))
    //  if (isEye() && graph().is3D())
    //    translateZ(ev);
    //  else
    //    scale(ev)
  }
}
