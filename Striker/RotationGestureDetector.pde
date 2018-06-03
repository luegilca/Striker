//public class RotationGestureDetector {
//  private static final int INVALID_POINTER_ID = -1;
//  private float fX, fY, sX, sY;
//  private int ptrID1, ptrID2;
//  private float mAngle;

//  private OnRotationGestureListener mListener;

//  public float getAngle() {
//    return mAngle;
//  }

//  public RotationGestureDetector(OnRotationGestureListener listener){
//    mListener = listener;
//    ptrID1 = INVALID_POINTER_ID;
//    ptrID2 = INVALID_POINTER_ID;
//  }

//    public boolean onTouchEvent(MotionEvent event){
//      switch (event.getActionMasked()) {
//        case MotionEvent.ACTION_DOWN:
//          ptrID1 = event.getPointerId(event.getActionIndex());
//          break;
//        case MotionEvent.ACTION_POINTER_DOWN:
//          ptrID2 = event.getPointerId(event.getActionIndex());
//          sX = event.getX(event.findPointerIndex(ptrID1));
//          sY = event.getY(event.findPointerIndex(ptrID1));
//          fX = event.getX(event.findPointerIndex(ptrID2));
//          fY = event.getY(event.findPointerIndex(ptrID2));
//          break;
//        case MotionEvent.ACTION_MOVE:
//          //Two fingers are moving
//          float nfX, nfY, nsX, nsY;
//          nsX = event.getX(event.findPointerIndex(ptrID1));
//              nsY = event.getY(event.findPointerIndex(ptrID1));
//              nfX = event.getX(event.findPointerIndex(ptrID2));
//              nfY = event.getY(event.findPointerIndex(ptrID2));
              
//              direction2 = " : " + fX + ", "+ fY + ", "+ sX + ", "+ sY + ", "+ nfX + ", "+ nfY + ", "+ nsX + ", "+ nsY;
//          if(ptrID1 != INVALID_POINTER_ID && ptrID2 != INVALID_POINTER_ID ){
              
//              nsX = event.getX(event.findPointerIndex(ptrID1));
//              nsY = event.getY(event.findPointerIndex(ptrID1));
//              nfX = event.getX(event.findPointerIndex(ptrID2));
//              nfY = event.getY(event.findPointerIndex(ptrID2));
              
//              //direction2 = " : " + fX + ", "+ fY + ", "+ sX + ", "+ sY + ", "+ nfX + ", "+ nfY + ", "+ nsX + ", "+ nsY;
//              // Both fingers are changing, means Z rotation
//              if( isChangingPosition( nsX, sX, nsY, sY ) && isChangingPosition( nfX, fX, nfY, fY ) ){
//                mAngle = angleBetweenLines(fX, fY, sX, sY, nfX, nfY, nsX, nsY);
  
//                if (mListener != null && mAngle > rotationCalibration) {                  
//                    mAngle -= rotationCalibration;
//                    //direction = "Z, in: " + mAngle + " degrees";
//                    mListener.OnRotation(this);
//                }
//              }
//              //One finger is not changing, means X or Y rotation
//              else {
//                if( isChangingPosition( fX, nfX, fY, nfY ) ){
//                  direction2 = "First finger";
//                }
//                else if( isChangingPosition( sX, nsX, sY, nsY )  ){
//                  direction2 = "Second finger";
//                }
//              }
              
              
//          }
//          break;
//        case MotionEvent.ACTION_UP:
//          ptrID1 = INVALID_POINTER_ID;
//          break;
//        case MotionEvent.ACTION_POINTER_UP:
//          ptrID2 = INVALID_POINTER_ID;
//          break;
//        case MotionEvent.ACTION_CANCEL:
//          ptrID1 = INVALID_POINTER_ID;
//          ptrID2 = INVALID_POINTER_ID;
//          break;
//      }
//      return true;
//    }

//    private float angleBetweenLines (float fX, float fY, float sX, float sY, float nfX, float nfY, float nsX, float nsY) {
//      float angle1 = (float) Math.atan2( (fY - sY), (fX - sX) );
//      float angle2 = (float) Math.atan2( (nfY - nsY), (nfX - nsX) );

//      float angle = ((float)Math.toDegrees(angle1 - angle2)) % 360;
//      if (angle < -180.f) angle += 360.0f;
//      if (angle > 180.f) angle -= 360.0f;
//      return angle;
//    }    
    
//    private boolean isChangingXPosition( float x, float px ) {
//      if( Math.abs( x - px ) > coordTolerance )
//        return true;
//      return false;
//    }
//    private boolean isChangingYPosition( float y, float py ) {
//      if( Math.abs( y - py ) > coordTolerance )
//        return true;
//      return false;
//    }
//    private boolean isChangingPosition( float x, float px, float y, float py ) {
//      return isChangingXPosition( x, px ) || isChangingYPosition( y, py );
//    }
//}

//public static interface OnRotationGestureListener {
//  public void OnRotation(RotationGestureDetector rotationDetector);
//}
