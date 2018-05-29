public class Point {
  private float posX, posY;
  private int id;
  private int textSize;
  
  public Point( int _id, float _posX, float _posY ) {
    this.id = _id;
    this.posX = _posX;
    this.posY = _posY;
    this.textSize = 30;
  }
  
  public Point( int _id, float _posX, float _posY, int _textSize ) {
    this.id = _id;
    this.posX = _posX;
    this.posY = _posY;
    this.textSize = _textSize;
  }
  
  public float getPosX( ) {
    return posX;
  }
  
  public float getPosY( ) {
    return posY;
  }
  
  public float getPosId( ) {
    return this.id;
  }
  
  public void setPosX( float _posX ) {
    this.posX = _posX;
  }
  
  public void setPosY( float _posY ) {
    this.posY = _posY;
  }
  
  public void setPosId( int _id ) {
    this.id = _id;
  }
  
  public void paint( ) {
    fill( 120 );
    textSize( textSize );
    ellipse( posX, posY, 150, 150 );
    text( "X: " + posX + " Y: " + posY, posX - 100, posY - 100 );
    text( "ID: " + id, posX - 100, posY - 100 );
    fill( 200 );
    ellipse( posX, posY, 20, 20 );
  }
}