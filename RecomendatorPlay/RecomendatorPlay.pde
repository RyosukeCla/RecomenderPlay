Model model;
Graph gr;
float maxf;
ArrayList<Float> y1;
ArrayList<Float> y2;
int time;
void setup () {
  fullScreen();
  background (40);
  textSize (50);
  textAlign (CENTER, CENTER);
  text ("now loading", width/2.0, height/2.0);
  time = 0;
  y1 = new ArrayList<Float>();
  y2 = new ArrayList<Float>();
  y1.add (new Float(0));
  y2.add (new Float(0));
  model = new Model (6, 6);
  gr = new Graph ("Profit");
  gr.setPosition (50, 50);
  gr.setSize (width - 100, height - 100);
  gr.setDelta (1);
  gr.setRangeX(0, 99);
  gr.setRangeY(-10, 100);
  gr.setAxisName ("time + range", "profits");
  model.initialize();
  model.displayInfo(1);
  
  gr.addFunction (
    new Function () {
      public float function (float x) {
        int index = (int)x - 100 + y1.size();
        if (index < 0) {
          return 0;
        }
        if (y1.size() > index) {
          return y1.get(index);
        } else {
          return y1.get(y1.size()-1);
        }
      }
    }
  );
  gr.addFunction (
    new Function () {
      public float function (float x) {
        int index = (int)x - 100 + y2.size();
        if (index < 0) {
          return 0;
        }
        if (y2.size() > index) {
          return y2.get(index);
        } else {
          return y2.get(y2.size()-1);
        }
      }
    }
  );
  gr.addColor (new Color (200, 100, 100));
  gr.addColor (new Color (100, 100, 200));
  
  
}

void draw () {
  background (40);
  
  if (frameCount % 5 == 0) {
    model.updateMoney ();
    time++;
    y1.add (new Float (model.moneyA));
    y2.add (new Float (model.moneyB));
    if (y1.size () > 100) {
      y1.remove (0);
    }
    if (y2.size () > 100) {
      y2.remove (0);
    }
    float temp = maxf;
    if (temp - 50 < model.moneyA) {
      temp = model.moneyA + 50;
    }
    if (temp - 50 < model.moneyB) {
      temp = model.moneyB + 50;
    }
    if (temp > maxf) {
      maxf = temp;
      if (maxf < 1000) {
        maxf = 1000;
      }
      gr.setRangeY (y2.get(0) - 50, maxf);
      //gr.setRangeY (- 10, maxf);
    }
    
  }
  gr.update();
  textAlign (LEFT, CENTER);
  textSize (width/100);
  fill (255, 200);
  float ratio = model.moneyA / model.moneyB;
  text ("Profits\nRed  : " + model.moneyA + "\n" + "Blue : " + model.moneyB + "\n\nRatio - R/B : " + ratio + "\n\nTime : " + time, width/2.0 - 100, height/2.0);
  
}