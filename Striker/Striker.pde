import java.util.*;

import android.view.MotionEvent;
import android.view.View;

import frames.core.*;
import frames.primitives.*;
import frames.processing.*;
import frames.input.*;
import frames.input.event.*;

private MultiTouchEvent[] eventList;
private final int MAX_TOUCHES = 2;
private final int INVALID_POINTER_ID = -1;

private Scene scene;
private AndroidAgent agent;
private AndroidShape eye, object;

String direction = null;

private RotationGestureDetector rotationDetector = new RotationGestureDetector(); 

void setup( ){
  fullScreen( P3D, 1 );
  noStroke();
  orientation(LANDSCAPE);
  initialize( );
  scene = new Scene( this );
  agent = new AndroidAgent( scene );
  
  eye = new AndroidShape( scene );
  scene.setEye( eye );
  scene.setFieldOfView(PI / 3);
  
  //object = new Shape( scene, createShape(RECT,100,100,100,50) );
  //object.scale(1);
  //smooth();
  
  //scene.setDefaultGrabber( eye );
  //scene.setRadius(260);
  //scene.fitBallInterpolation( );
}

void draw( ) {
  background( color( 0, 91, 171 ) );  
  lights();
  pushMatrix( );
  textSize( 100 );
  text( "ROTATING in " + direction, 100, 100 );
  translate(width/2, height/2);
  rotateY(frameCount*PI/200);
  box(200);
  popMatrix();
  if (mousePressed == true) {
    // ...for each possible touch event...
    for(int i=0; i < MAX_TOUCHES; i++) {
      // If that event been touched...
      if(eventList[i].touched == true) {
        // DO SOMETHING WITH IT HERE:
        ellipse( eventList[i].motionX, eventList[i].motionY, 50, 50 );
        //println( eventList[i] );
      }
    }
  }
  //scene.traverse( ); 
}

private void initialize( ) {
  eventList = new MultiTouchEvent[ MAX_TOUCHES ];
  for( int i = 0; i < MAX_TOUCHES; i++ ){
    eventList[ i ] = new MultiTouchEvent( );
  }
}
 
boolean surfaceTouchEvent( MotionEvent me ) {
  // Find number of touch points:
  int pointers = me.getPointerCount( );
 
  //  Update MultiTouch that 'is touched':
  for( int i = 0; i < MAX_TOUCHES; i++ ){
    if( i < pointers ){
      eventList[ i ].update( me, i );
    }
    // Update MultiTouch that 'isn't touched':
    else {
      eventList[ i ].update();
    }
  }
 
  // If you want the variables for motionX/motionY, mouseX/mouseY etc.
  // to work properly, you'll need to call super.surfaceTouchEvent().
  rotationDetector.onTouchEvent( me );
  return super.surfaceTouchEvent(me);
}