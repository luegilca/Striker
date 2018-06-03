public class AndroidScene extends Scene {
  public AndroidScene(PApplet pApplet) {
    this(pApplet, pApplet.g);
  }
  
  public AndroidScene(PApplet pApplet, PGraphics pGraphics) {
    super(pApplet, pGraphics, 0, 0);
  }
  
  @Override
  public void loadConfig( ) {
    if( this.isOffscreen( ) )
      System.out.println("Warning: no config loaded! Off-screen graph config requires loadConfig(String fileName) to be called");
    else{
      JSONObject json = null;
      try {
        String sysPath = getActivity( ).getFilesDir( ).toString( ) + "/data/";
        json = pApplet().loadJSONObject( sysPath + "config.json" );
      } 
      catch( Exception e ){
        System.out.println("No such config.json found!");
      }
      if( json != null ) {
        setRadius( json.getFloat("radius") );
        String type = json.getString("type");
        setType(type.equals("PERSPECTIVE") ? Type.PERSPECTIVE :
            type.equals("ORTHOGRAPHIC") ? Type.ORTHOGRAPHIC : type.equals("TWO_D") ? Type.TWO_D : Type.CUSTOM);
        eye().setWorldMatrix(_toFrame(json.getJSONObject("eye")));
      }
    }
  }
  
  @Override
  public void dispose() {
    System.out.println("Debug: saveConfig() (i.e., dispose()) called!");
    if (!this.isOffscreen())
      this.saveConfig();
  }
  
  @Override
  public void saveConfig() {
    if (this.isOffscreen())
      System.out.println("Warning: no config saved! Off-screen graph config requires saveConfig(String fileName) to be called");
    else
      this.saveConfig("config.json");
  } 
  
  @Override
  public void saveConfig( String filename ){    
    JSONObject json = new JSONObject( );
    json.setFloat( "radius", radius( ) );
    json.setString( "type", type( ).name( ) );
    json.setJSONObject( "eye", _toJSONObject( eye( ) ) );
    
    String sysPath = getActivity( ).getFilesDir( ).toString( ) + "/data/";
    pApplet( ).saveJSONObject( json, sysPath + "config.json");
  }
}