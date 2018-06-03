public class PointList {
  private HashMap<Integer, mPoint> list;
  
  public PointList( ) {
    list = new HashMap<Integer, mPoint>( );
  }
  
  public synchronized void paint( ) {
    if( list.keySet( ).size( ) == 0 )
      return;
    Set<Integer> keyList = list.keySet( );
    Iterator<Integer> it = keyList.iterator( );
    int counter = 0;
    mPoint anchor = null;
    LinkedList<mPoint> lili = new LinkedList<mPoint>();
    while( it.hasNext( ) ) {
      anchor = list.get( it.next( ) );
      lili.add( anchor );
      anchor.paint();
      counter++;
    }
    
    if( lili.size( ) > 1 ) {
      Object[] array = lili.toArray();
      for( int i = 0; i < array.length; i++ ) {
        for( int j = i + 1; j < array.length; j++ ) {
          drawLine( (mPoint) array[i], (mPoint) array[j] );
        }
      }
    }
    
    textSize(30);
    text("Active elements: " + counter, 10, 25 );
  }
  
  synchronized void drawLine( mPoint a, mPoint b ) {
    line( a.getPosX( ), a.getPosY( ), b.getPosX( ), b.getPosY( ) );
  }
  
  synchronized void delete( int id ) {
    if ( list.get( id ) != null )
      list.remove( id );
  }
  
  synchronized void clearList( ){
    list.clear();
  }
  
  synchronized void insert( int id, float x, float y ) {
    if( list.get(id) == null )
      list.put(id, new mPoint( id, x, y ) );
  }
  
  synchronized void update(int id, float x, float y) {
    list.get( id ).setPosX( x );
    list.get( id ).setPosY( y );
    list.get( id ).setPosId( id );
  }
}