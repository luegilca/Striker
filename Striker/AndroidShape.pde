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
  public void interact(frames.input.Event event) {
    // The SN_ID shortcut is fired by agent6 (the one handling the space-navigator)
    //if (event.shortcut().matches(new Shortcut(SN_ID)))
    //  // its safe to call node methods having 6-DOFs or less.
    //  translateRotateXYZ(event);
    //if (event.shortcut().matches(new Shortcut(RIGHT)))
    //  translate(event);
    //if (event.shortcut().matches(new Shortcut(LEFT)))
    //  rotate(event);
    //if (event.shortcut().matches(new Shortcut(CENTER)))
    //  rotate(event);
    //if (event.shortcut().matches(new Shortcut(processing.event.MouseEvent.WHEEL)))
    //  if (isEye() && graph().is3D())
    //    translateZ(event);
    //  else
        //scale(event);
  }
}