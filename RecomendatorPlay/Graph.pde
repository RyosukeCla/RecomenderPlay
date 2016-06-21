class Graph {
  private PVector pos;
  private PVector size;
  private color textCol;
  private String name;
  private ArrayList<Function> functions;
  private ArrayList<Color> colors;
  private ArrayList<View> views;
  private float delta;
  private PVector rangeX;
  private PVector rangeY;

  private String axisNameX;
  private String axisNameY;

  private color lineCol;

  public Graph (String name) {
    this.name = name;
    this.pos = new PVector (0, 0);
    this.size = new PVector (100, 50);
    this.textCol = color (255, 230);
    this.delta = 1.0;
    this.rangeX = new PVector (0.0, 1.0);
    this.rangeY = new PVector (0.0, 1.0);
    this.lineCol = color (180, 50, 70);
    this.axisNameX = "x";
    this.axisNameY = "y";
    this.functions = new ArrayList<Function> ();
    this.colors = new ArrayList<Color> ();
    this.views = new ArrayList<View> ();
  }

  public void addFunction (Function function) {
    this.functions.add (function);
  }
  
  public void addColor (Color col) {
    this.colors.add (col);
  }
  
  public void addView (View view) {
    this.views.add (view);
  }

  public void setRangeX (float left, float right) {
    this.rangeX.x = left;
    this.rangeX.y = right;
  }

  public void setRangeY (float left, float right) {
    this.rangeY.x = left;
    this.rangeY.y = right;
  }

  public void setAxisName (String x, String y) {
    this.axisNameX = x;
    this.axisNameY = y;
  }

  public void setDelta (float delta) {
    this.delta = delta;
  }

  public void setPosition (float x, float y) {
    this.pos.x = x;
    this.pos.y = y;
  }

  public void setSize (float x, float y) {
    this.size.x = x;
    this.size.y = y;
  }

  public void setTextColor (color col) {
    this.textCol = col;
  }

  public void setName (String name) {
    this.name = name;
  }

  public void update () {
    pushMatrix ();
    translate (this.pos.x, this.pos.y);
    strokeWeight (1);
    fill(255, 255, 255, 20);
    rect (0, 0, this.size.x, this.size.y);
    stroke (this.lineCol);

    if (this.functions.size() != 0) {
      for (float x = this.rangeX.x; x < this.rangeX.y; x += this.delta) {
        for (int i = 0; i < this.functions.size(); i++) {
          if (this.colors.size() > i) {
            stroke (this.colors.get(i).getColor());
          }
          float y1 = this.functions.get(i).function (x);
          float y2 = this.functions.get(i).function (x+this.delta);
          y1 = map (y1, this.rangeY.x, this.rangeY.y, 0.0, this.size.y);
          y2 = map (y2, this.rangeY.x, this.rangeY.y, 0.0, this.size.y);
          if (y1 < 0) {
            y1 = 0;
          }
          if (y2 < 0) {
            y2 = 0;
          }
          if (y1 > this.size.y) {
            y1 = this.size.y;
          }
          if (y2 > this.size.y) {
            y2 = this.size.y;
          }
          float x1 = map (x, this.rangeX.x, this.rangeX.y, 0.0, this.size.x);
          float x2 = map (x+this.delta, this.rangeX.x, this.rangeX.y, 0.0, this.size.x);
          if (this.views.size() > i) {
            this.views.get(i).view (x1, this.size.y - y1, x2, this.size.y - y2);
          } else {
            line (x1, this.size.y - y1, x2, this.size.y - y2);
          }
          
          
        }
      }
    }

    stroke(255, 255, 255, 255);
    fill (0, 0);
    rect (0, 0, this.size.x, this.size.y);

    fill(this.textCol);
    textSize(10);
    textAlign(CENTER, CENTER);
    text (this.axisNameX, this.size.x / 2, this.size.y + 10.0);
    pushMatrix();
    rotate (-PI/2.0);
    translate (-this.size.y / 2.0, -10.0);
    text (this.axisNameY, 0.0, 0.0);
    popMatrix();
    textSize (10);
    text (this.rangeX.x, 0.0, -10.0);
    text (this.rangeX.y, this.size.x, -10.0);
    textAlign (LEFT, CENTER);
    text (this.rangeY.x, this.size.x, this.size.y - 5.0);
    text (this.rangeY.y, this.size.x, 5.0);
    textSize (12);
    text (this.name, this.size.x + 10.0, this.size.y / 2.0);

    popMatrix ();
  }
}