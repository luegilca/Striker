public static class Helper{
  public static boolean changedXPosition( MultiTouchEvent e, float tolerance ) {
    return Math.abs( e.motionX - e.pmotionX ) > tolerance;
  }
  public static boolean changedYPosition( MultiTouchEvent e, float tolerance ) {
    return Math.abs( e.motionY - e.pmotionY ) > tolerance;
  }
  public static boolean changedPosition( MultiTouchEvent e, float tolerance ) {
    return changedXPosition( e, tolerance ) || changedYPosition( e, tolerance );
  }
  
  //Adaptation from method found in: https://stackoverflow.com/questions/10682019/android-two-finger-rotation
  public static float angleBetweenLines (float fX, float fY, float sX, float sY, float nfX, float nfY, float nsX, float nsY) {
    float angle1 = ( float ) Math.atan2( ( fY - sY ), ( fX - sX ) );
    float angle2 = ( float ) Math.atan2( ( nfY - nsY ), ( nfX - nsX ) );

    float angle = ( ( ( float ) Math.toDegrees( angle1 - angle2 ) ) % 360 ) * 25;
    if (angle < -180.f) angle += 360.0f;
    if (angle > 180.f) angle -= 360.0f;
    return angle;
  }
}
