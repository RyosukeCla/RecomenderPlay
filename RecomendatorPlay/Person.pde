class Person {
  int id;
  Vector favor;
  
  public Person (int id, int category) {
    this.id = id;
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
    
    float deb = 0.0;
    for (int i =0 ; i < category; i++) {
      deb += this.favor.getAt(i);
    }
    
    println ("#" + id + " : " + favor.toString());
  }
  
  public boolean isClicked (Vector fav) {
    Vector dist = new Vector (favor);
    dist.sub (fav);
    float sqrNolm = dist.sqrMagnitude ();
    float prob = exp (- sqrNolm * 5.0 - 1.0);
    if (random (0.0, 1.0) < prob) {
      
      //println (favor.toString() + " " + prob + " - a");
      return true;
    }
    return false;
  }

  
}