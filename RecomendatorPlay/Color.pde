class Color {
  private color col;
  
  public Color (float R, float G, float B) {
    this.col = color (R, G, B);
  }
  
  public Color (float R, float G, float B, float A) {
    this.col = color (R, G, B, A);
  }
  
  public Color (color col) {
    this.col = col;
  }
  
  public color getColor () {
    return col;
  }
  
  public void setColor (color col) {
    this.col = col;
  }
  
}