import java.util.*;

import android.content.Context;
import android.app.Activity;
import android.view.MotionEvent;
import android.view.View;

import processing.data.JSONArray;
import processing.data.JSONObject;

import frames.core.*;

import frames.primitives.*;
import frames.primitives.Vector;
import frames.processing.*;
import frames.input.*;
import frames.input.event.*;

MultiTouchEvent[] eventList;
final int MAX_TOUCHES = 2;
final int INVALID_POINTER_ID = -1;
final int TOUCH_ID = 102; 

float rotationCalibration = 15;
float coordTolerance = 0.5;
float distTolerance = 20;

AndroidScene scene;
AndroidAgent agent;
AndroidShape eye;
Shape object;

String direction = null;
String direction2 = null;
String event = null;

boolean debugMessages = true;

GestureDetector gestureDetector = new GestureDetector( ); 
PImage textureImg;
PShape dice;

void setup( ) {
  fullScreen( P3D, 1 );
  frameRate(60);
  orientation(LANDSCAPE);
  initialize( );

  scene = new AndroidScene(this);
  agent = new AndroidAgent( scene );
  
  eye = new AndroidShape( scene );
   
  textureImg = loadImage( "dice.png" );
  dice = loadShape( "dice.obj" );
  dice.setTexture( textureImg );
  
  object = new Shape( scene, dice );
  //object.translate(new frames.primitives.Vector(0, 0, 0));
  eye.rotate(new Quaternion(new Vector(0, 0, 1), PI));
  object.scale(100);
  
  scene.setEye( eye );
  scene.setFieldOfView(PI / 3);
  
  scene.setDefaultGrabber( object );
  scene.setRadius(260);
  scene.fitBallInterpolation( );
  
}

void draw( ) {  
  background( color( 0, 92, 107 ) );//background( color( 0, 91, 171 ) );
  scene.drawAxes();  
  scene.traverse( );
  interactionAgent( );  
}


void push() {
  pushStyle();
  pushMatrix();
}

void pop() {
  popStyle();
  popMatrix();
}

private void initialize( ) {
  eventList = new MultiTouchEvent[ MAX_TOUCHES ];
  for ( int i = 0; i < MAX_TOUCHES; i++ ) {
    eventList[ i ] = new MultiTouchEvent( );
  }
}

boolean surfaceTouchEvent( MotionEvent me ) {
  // Find number of touch points:
  int pointers = me.getPointerCount( );

  //  Update MultiTouch that 'is touched':
  for ( int i = 0; i < MAX_TOUCHES; i++ ) {
    if ( i < pointers ) {
      eventList[ i ].update( me, i );
    }
    // Update MultiTouch that 'isn't touched':
    else {
      eventList[ i ].update();
    }
  }

  // If you want the variables for motionX/motionY, mouseX/mouseY etc.
  // to work properly, you'll need to call super.surfaceTouchEvent().
  gestureDetector.onTouchEvent( me );
  return super.surfaceTouchEvent(me);
}

void interactionAgent( ) {
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
  
  object.rotate( new Quaternion( rx, ry, rz ) );
  object.translate( tx, ty, tz );
  
  if( debugMessages ) {
    scene.beginScreenCoordinates( );
    textSize( 30 );
    text( "Motion:rotation in " + direction, 100, 100 );
    text( "Motion:translation in " + direction2, 100, 130 );
    text( "Vector:rotation " + Arrays.toString(rotation), 100, 160 );
    text( "Vector:translation " + Arrays.toString(translation), 100, 190 );
    scene.endScreenCoordinates( );
  }  
}
