class ClustersModel {
  private ArrayList <Vector> clusters;
  private ArrayList <Data> datas;
  private float m;
  
  public ClustersModel (int clustersNumber, float m, ArrayList <Vector> datas) {
    this.datas = new ArrayList <Data> ();
    this.setDatas (clustersNumber, datas);
    this.clusters = new ArrayList <Vector> ();
    this.setClusters (clustersNumber, datas.get(0).size());
    this.m = m;
  }
  
  public void train () {
    updateClusters ();
    updateAttributions ();
  }
  
  public void displayInfoClusters () {
    String info;
    println ("=== Clusters vector ===");
    for (int i = 0; i < this.clusters.size(); i++) {
      info = "#"+i+" -vec: " + this.clusters.get(i).toString();
      println (info);
    }
    
  }
  
  public void displayInfo () {
    String info;
    println ("=== Attributions ===");
    for (int i = 0; i < this.datas.size(); i++) {
      info = "#" + i + " -att: " + this.datas.get(i).getAttributions().toString ();
      println (info);
    }
  }
  
  public ArrayList<Data> getResult () {
    ArrayList<Data> result = new ArrayList <Data> ();
    for (int i = 0; i < this.datas.size(); i++) {
      result.add (new Data (this.datas.get (i)));
    }
    return result;
  }
  
  public ArrayList<Data> getDatas () {
    return this.datas;
  }
  
  public ArrayList<Vector> getClusters () {
    return this.clusters;
  }
  
  private void setClusters (int clustersNumber, int dimention) {
    for (int i = 0; i < clustersNumber; i++) {
      clusters.add (new Vector (dimention));
    }
  }
  
  private void setDatas (int clustersNumber, ArrayList <Vector> datas) {
    Data data;
    int n = datas.size();
    for (int i = 0; i < n; i++) {
      data = new Data (datas.get(i), clustersNumber);
      data.setRandomAttributions ();
      this.datas.add (data);
    }
  }
  
  private void updateClusters () {
    Vector center = new Vector (this.datas.get(0).getData().size());
    Vector numer = new Vector (center.size());
    float denom = 0.0;
    float mAttri = 0;
    for (int i = 0; i < this.clusters.size (); i++) {
      center.toZero ();
      denom = 0.0;
      for (int j = 0; j < this.datas.size (); j++) {   
        numer.set (this.datas.get(j).getData());        
        mAttri = pow (this.datas.get(j).getAttributions().getAt (i), this.m);
        numer.mult (mAttri);
        center.add (numer);
        denom += mAttri;
      }
      center.div (denom);
      this.clusters.get(i).set (center);
    }
  }
  
  private void updateAttributions () {
    float attribution;
    float temp = 0;
    for (int i = 0; i < this.clusters.size(); i++) {
      for (int j = 0; j < this.datas.size(); j++) {
        attribution = 0.0;
        for (int k = 0; k < this.clusters.size(); k++) {
          temp = this.datas.get(j).getData().distance (this.clusters.get(i));
          temp /= this.datas.get(j).getData().distance (this.clusters.get(k));
          attribution += pow (temp, 2 / (m - 1.0));
        }
        attribution = 1 / attribution;
        this.datas.get(j).setAttributionAt (i, attribution);
      }
    }
  }

}