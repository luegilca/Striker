import java.util.*;

import android.view.MotionEvent;

import frames.core.*;
import frames.primitives.*;
import frames.processing.*;
import frames.input.*;
import frames.input.event.*;

public PointList list;
private final int INVALID_POINTER_ID = -1;
private final int MAX_TOUCHES = 3; 

void setup( ){
  fullScreen( );
  orientation(LANDSCAPE);
  list = new PointList( );
}

void draw( ) {
  background( 18 );
  list.paint( );
}

boolean surfaceTouchEvent( MotionEvent me ) {
  //Getting all the data
  int action = me.getAction(); 
  float x    = me.getX();
  float y    = me.getY();
  int index  = action >> MotionEvent.ACTION_POINTER_INDEX_SHIFT;  
  int id     = me.getPointerId(index);
  
  switch( action & MotionEvent.ACTION_MASK ) {
    case MotionEvent.ACTION_DOWN:
      list.insert( id, x, y );
      break;
      
    case MotionEvent.ACTION_UP:
      list.delete( id );
      break;
      
    case MotionEvent.ACTION_MOVE:
      int count = me.getPointerCount( );  
      for (int i=0; i < count; i++) {
        id = me.getPointerId(i);
        x  = me.getX(i);
        y  = me.getY(i);
        list.update( id, x, y );
      }
      break;
      
    case MotionEvent.ACTION_POINTER_DOWN:
      list.insert( id, x, y );
      break;
             
    case MotionEvent.ACTION_POINTER_UP:      
      list.delete(id);
      break;

    case MotionEvent.ACTION_CANCEL:
      list.clearList( );
      id = INVALID_POINTER_ID;
      break;
  }  
  return super.surfaceTouchEvent(me);
}