//2016/12/27 TadaMatz
//intended for Processing 3

import java.awt.Frame;
import java.awt.BorderLayout;


void ResWindowSetup() {
  String[] args = {"TwoFrameTest"};
  SecondApplet sa = new SecondApplet();
  PApplet.runSketch(args, sa);
}

public class SecondApplet extends PApplet {
  void settings() {
    size(400, 400);
  }

  void setup() {
  }

  void draw() {
    background(127);

    int totalBall = 0;
    for (Obstacle tempOb : obstacles) totalBall += tempOb.collisionCnt;

    for (int i = 0; i < obstacles.size(); i++) {
      fill(255 );      
      rect((float)i * width / (float)obstacles.size(), height, width / (float)obstacles.size(), -(float)obstacles.get(i).collisionCnt / (float)totalBall * height);
      println((float)i * width / (float)obstacles.size());
    }
    
    println(totalBall);
  }
}