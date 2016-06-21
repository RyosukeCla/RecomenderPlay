class Data {
  private Vector data;
  private Vector attributions;
  
  public Data (Vector data, int clustersNumber) {
    this.data = data;
    this.attributions = new Vector (clustersNumber);
  }
  
  public Data (Data data) {
    this.data = new Vector (data.getData ());
    this.attributions = new Vector (data.getAttributions ());
  }
  
  public void setAttributions (Vector attributions) {
    this.attributions.set (attributions);
  }
  
  public void setAttributionAt (int index, float value) {
    this.attributions.setAt (index, value);
  }
  
  public void setRandomAttributions () {
    this.attributions.toRandom();
  }
  
  public Vector getAttributions () {
    return this.attributions;
  }
  
  public Vector getData () {
    return this.data;
  }
}