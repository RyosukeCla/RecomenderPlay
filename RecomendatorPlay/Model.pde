class Model {
  ArrayList<Person> persons;
  // persons log
  ArrayList<Vector> logs;
  ArrayList <Ads> ad;
  float moneyA, moneyB;
  int category;
  int ads;
  ClustersModel cm;
  public Model (int cate, int ads) {
    category = cate;
    this.ads = ads;
    persons = new ArrayList <Person> ();
    logs = new ArrayList <Vector> ();
    moneyA = 0.0;
    moneyB = 0.0;
    ad = new ArrayList <Ads> ();
  }
  
  public void initialize () {
    setPersons ();
    setLogs ();
    
    cm = new ClustersModel (ads, 1.5, logs);
    for (int i = 0; i < 300; i++) {
      cm.train ();
      
    }
    cm.displayInfo();
    setAds ();
  }
  
  public void displayInfo (int index) {
    switch (index) {
      case 0:
        for (int i = 0; i < logs.size(); i++) {
          println ("log : " + logs.get(i).toString());
        }
      case 1:
        println ("moneyA - moneyB : " + moneyA + " - " + moneyB);
    }
    
  }
  
  public void updateMoney () {
    float resultA = 0.0;
    float resultB = 0.0;
    float prob;
    for (int i = 0; i < persons.size(); i++) {
      prob = 0.0;
      float p = random (0.0,1.0);
      int ind = 0;
      for (int a = 0; a < ads; a++) {
        prob += cm.getDatas().get(i).getAttributions().getAt(a);
        if (p < prob) {
          ind = a;
          break;
        }
      }
      for (int a = 0; a < ads; a++) {
        if (ad.get(a).cluster == ind) {
          ind = a;
          break;
        }
      }
      
      if (persons.get(i).isClicked(ad.get(ind).favor)) {
        resultA += 0.1;
      }
      if (persons.get(i).isClicked(ad.get((int)random(0, ads)).favor)) {
        resultB += 0.1;
      }
    }
    
    moneyA += resultA;
    moneyB += resultB;
  }
  
  private void setPersons () {
    for (int i = 0; i < 400; i++) {
      persons.add (new Person (i, category));
    }
  }
  
  private void setLogs () {
    for (int i = 0; i < persons.size(); i++) {
      Vector log = new Vector (category);
      for (int j = 0; j < 100; j++) {
        float p = 0;
        float po = random (0.0, 1.0);
        for (int c = 0; c < category; c++) {
          p += persons.get(i).favor.getAt(c);
          if (p > po) {
            log.setAt(c, log.getAt(c) + 1);
            break;
          }
        }
      }
      logs.add (log);
    }
  }
  
  private void setAds () {
    for (int i = 0; i < ads; i++) {
      Ads a = new Ads (category);
      a.setLog (100, category);
      ad.add (a);
    }
    for (int i = 0; i < ad.size(); i++) {
      println (" === #" + i + " ===");
      int index = -1;
      float dist = 9999999.9;
      Vector dis = new Vector (category);
      for (int j = 0; j < ads; j++) {
        dis.toZero();
        dis.add (ad.get(i).log);
        dis.sub (cm.getClusters().get(j));
        println ("ad - " + ad.get(i).log.toString());
        println ("clus - " + cm.getClusters().get(j).toString());
        float d = dis.sqrMagnitude ();
        println ("d - " + d);
        if (dist > d) {
          dist = d;
          index = j;
        }
      }
      if (index != -1) {
        ad.get(i).setCluster (index);
        
      }
      println (" === #" + i + " ===");
      println ("set dist - " + dist);
      println ("ad - " + ad.get(i).log.toString() + "\n" + "clus - " + cm.getClusters().get(index).toString());
    }
  }
  
  
}