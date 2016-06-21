class Ads {
  Vector favor;
  int cluster;
  Vector log;
  public Ads (int category) {
    Vector vec = new Vector (category);
    vec.toRandom();
    float denom = 0.0;
    for (int i = 0; i < category; i++) {
      denom += pow(vec.getAt (i), category/1.5);
    }
    this.favor = new Vector (vec);
    for (int i = 0; i < category; i++) {
      float a = this.favor.getAt(i);
      a = pow (a, category/1.5);
      this.favor.setAt (i, a);
    }
    this.favor.div (denom);
  }

  public void setCluster (int index) {
    this.cluster = index;
  }

  public void setLog (int n, int category) {
    log = new Vector (category);
    for (int j = 0; j < n; j++) {
      float p = 0;
      float po = random (0.0, 1.0);
      for (int c = 0; c < category; c++) {
        p += favor.getAt(c);
        if (p > po) {
          log.setAt(c, log.getAt(c) + 1);
          break;
        }
      }
    }
  }
}