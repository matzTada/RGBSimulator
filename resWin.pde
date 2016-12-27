//2016/12/27 TadaMatz

import java.awt.Frame;
import java.awt.BorderLayout;

ResFrame rescf;

void ResWindowSetup() {
  rescf = addResFrame("ResWindow", 800, 400);
}

//so far I can use this class as if there was processing IDE
public class ResFrame extends PApplet {
  int w, h;
  public void setup() {
    size(w, h);  
  }

  public void draw() {
    background(0);
  }

  public ResFrame(Object theParent, int theWidth, int theHeight) {
    parent = theParent; 
    w = theWidth; 
    h = theHeight;
  }

  Object parent;
}

ResFrame addResFrame(String theName, int theWidth, int theHeight) {
  Frame f = new Frame(theName); 
  ResFrame p = new ResFrame(this, theWidth, theHeight); 
  //f.add(p); 
  //p.init(); 
  f.setTitle(theName); 
  f.setSize(p.w, p.h); 
  f.setLocation(500, 100); 
  f.setResizable(true); 
  f.setVisible(true); 
  return p;
}