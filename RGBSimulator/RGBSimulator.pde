//2016/12/24 TadaMatz
//Use Winding Number Algorithm 
//intend to implement human behavior (walking) simulator

import java.math.*;

ArrayList<Ball> balls;
ArrayList<Obstacle> obstacles;

int wallWidth = 40;

ArrayList<PVector>newObsVs = new ArrayList<PVector>();

PVector posPastMousePressed = new PVector(0, 0);

PImage loadedImg;

void settings() {
  size(1200, 800);
}

void setup() {
  frame.setResizable(true);

  //Res window setup
  ResWindowSetup();

  //init arrays
  balls = new ArrayList<Ball>();
  obstacles = new ArrayList<Obstacle>();

  //ball
  for (int i = 0; i < 500; i++)  balls.add(new Ball(width/2, height/2, random(-5, 5), random(-5, 5), random(10, 10)));

  //get obstacles from image
  loadedImg = loadImage("data/map.png");
  ArrayList<ArrayList<PVector>> vss = getPolygonVectorFromImage(loadedImg, 10, 170, 500);
  for (ArrayList<PVector> tempVS : vss) {
    for (PVector tempPV : tempVS) 
      tempPV.set(tempPV.x * width/loadedImg.width, tempPV.y * height/loadedImg.height);
    obstacles.add(new Obstacle(tempVS));
  }

  ////get obstacles from image
  //loadedImg = loadImage("data/map.png");
  //ArrayList<ArrayList<PVector>> vss = getPolygonVectorFromImage(loadedImg, 10, 170, 1000);
  //for (ArrayList<PVector> tempVS : vss) {
  //  for (PVector tempPV : tempVS) 
  //    tempPV.set(tempPV.x * width/loadedImg.width, tempPV.y * height/loadedImg.height);
  //  obstacles.add(new Obstacle(tempVS));
  //}

  //ArrayList<PVector> vs = new ArrayList<PVector>();
  ////object wall
  //vs = new ArrayList<PVector>();
  //vs.add(new PVector(0, 0));
  //vs.add(new PVector(0, 40));
  //vs.add(new PVector(width, 40));
  //vs.add(new PVector(width, 0));
  //obstacles.add(new Obstacle(vs));

  //vs = new ArrayList<PVector>();
  //vs.add(new PVector(0, 0));
  //vs.add(new PVector(0, height));
  //vs.add(new PVector(40, height));
  //vs.add(new PVector(40, 0));
  //obstacles.add(new Obstacle(vs));

  //vs = new ArrayList<PVector>();
  //vs.add(new PVector(0, height));
  //vs.add(new PVector(width, height));
  //vs.add(new PVector(width, height - wallWidth));
  //vs.add(new PVector(0, height - wallWidth));
  //obstacles.add(new Obstacle(vs));

  //vs = new ArrayList<PVector>();
  //vs.add(new PVector(width, height));
  //vs.add(new PVector(width, 0));
  //vs.add(new PVector(width - wallWidth, 0));
  //vs.add(new PVector(width - wallWidth, height));
  //obstacles.add(new Obstacle(vs));

  //mouse position
  //vs = new ArrayList<PVector>();
  //vs.add(new PVector(0, 0));
  //vs.add(new PVector(0, 20));
  //vs.add(new PVector(1, 1,));
  //vs.add(new PVector(20, 0));
  //obstacles.add(new Obstacle(vs));

  //////for grid obs
  //int blockSize = 100;
  //for (int i = 0; i < 4; i++) {
  //  for (int j = 0; j < 4; j++) {
  //    int x = blockSize + i * 2 * blockSize;
  //    int y = blockSize + j * 2 * blockSize;
  //    vs.clear();
  //    vs = new ArrayList<PVector>();
  //    vs.add(new PVector(x, y));
  //    vs.add(new PVector(x, y + blockSize));
  //    vs.add(new PVector(x + blockSize, y + blockSize));
  //    vs.add(new PVector(x + blockSize, y));
  //    obstacles.add(new Obstacle(vs));
  //  }
  //}

  //println(getDistBetweenLinePoint(new PVector(1, 1), new PVector(0, 0), new PVector(0, 1)));
}

void draw() {
  background(127);

  //noLoop();

  drawGravityField(obstacles);

  //mouse
  //obstacles.get(0).translatePos(mouseX, mouseY);

  displayNewObs();

  //for (int i = 4; i < obstacles.size(); i++) obstacles.get(i).rotate(radians(1));
  for (Obstacle tempOb : obstacles) { 
    for (Ball tempBall : balls) { //gravity
      PVector tempPV = tempOb.gravity(tempBall.pos);
      if (tempPV != null) tempBall.speed.add(tempPV);
    }
  }
  for (Ball tempBall : balls) { 
    tempBall.collision(obstacles);
    tempBall.update();
  }

  //visualize obstacles
  for (Obstacle tempOb : obstacles) { 
    tempOb.display();
  }
  for (Ball tempBall : balls) { 
    tempBall.display();
  }

  // visualize bars
  int totalBall = 0;
  for (Obstacle tempOb : obstacles) totalBall += tempOb.drawnCnt;
  float barsX = 0;
  float barsY = 0;
  float barsWidth = width/4;
  float barsHeight = height/4;
  for (int i = 0; i < obstacles.size(); i++) {
    fill(255);
    stroke(0);
    rect(barsX + (float)i * barsWidth / (float)obstacles.size(), barsY + barsHeight, barsWidth / (float)obstacles.size(), -(float)obstacles.get(i).drawnCnt / (float)totalBall * barsHeight);
    //println((float)i * width / (float)obstacles.size());
  }

  //check active ball
  int activeBallCnt = 0;
  for (Ball tempBall : balls) if (0 <= tempBall.pos.x && tempBall.pos.x <= width && 0 <= tempBall.pos.y && tempBall.pos.y <= height) activeBallCnt++;
  println("cnt: " + activeBallCnt + "/" + balls.size() + " frameRate: " + frameRate + " obstacles.size(): " + obstacles.size());
}

void mousePressed() {
  if (mouseButton == RIGHT) {
    //delete
    for (int i = obstacles.size() - 1; i >= 0; i--) {
      if (judgeInObject(obstacles.get(i).vs, new PVector(mouseX, mouseY))) { 
        obstacles.get(i).isGrabed = true;
        //obstacles.remove(i);
        posPastMousePressed.set(mouseX, mouseY); 
        return;
      }
    }

    //add new obstacles
    newObsVs.add(new PVector(mouseX, mouseY));
    for (int i = 0; i < newObsVs.size() - 2; i++) {
      //jugde the last line segment intersect any segment or not ref:http://www.deqnotes.net/acmicpc/2d_geometry/lines
      PVector a1 = newObsVs.get(i);
      PVector a2 = newObsVs.get(i+1);
      PVector a3 = newObsVs.get(newObsVs.size() - 2);
      PVector a4 = newObsVs.get(newObsVs.size() - 1);
      if (isIntersection(a1, a2, a3, a4)) {
        //add new obstacle
        //println("cross");}
        newObsVs.remove(newObsVs.size() - 1);
        Obstacle newOb = new Obstacle(newObsVs);
        obstacles.add(newOb);

        explode(newOb, balls);

        //clear newObsVs
        newObsVs = new ArrayList<PVector>();
      }
    }
  } else if (mouseButton == LEFT) {
    PVector center = new PVector(mouseX, mouseY);
    float maxDist = 300;
    for (Ball tempBall : balls) {
      //if (judgeInObject(newObsVs, tempBall.pos)) {
      if (tempBall.pos.dist(center) <= maxDist) {
        PVector newPos = PVector.sub(tempBall.pos, center).normalize().mult(maxDist).add(center);
        PVector newSpeed = PVector.sub(tempBall.pos, center).normalize().mult(tempBall.speed.mag());
        tempBall.updatePos(newPos);
        tempBall.updateVelocity(newSpeed);          
        //tempBall.initialize();
      }
    }
    for (int i = obstacles.size() - 1; i >= 0; i--) {
      if (judgeInObject(obstacles.get(i).vs, new PVector(mouseX, mouseY))) { 
        obstacles.get(i).character++;
        if (obstacles.get(i).character > 1) obstacles.get(i).character = 0;
      }
    }
  }
}

void mouseDragged() {
  for (int i = obstacles.size() - 1; i >= 0; i--) {
    if (obstacles.get(i).isGrabed) {
      obstacles.get(i).translatePos(mouseX, mouseY);
    }
  }
}

void mouseReleased() {
  for (int i = obstacles.size() - 1; i >= 0; i--) {
    if (obstacles.get(i).isGrabed) {
      if (posPastMousePressed.x == mouseX && posPastMousePressed.y  == mouseY) {
        obstacles.remove(i);
      } else {
        obstacles.get(i).isGrabed = false;      
        explode(obstacles.get(i), balls);
      }
      break;
    }
  }
}

void displayNewObs() {
  fill(0, 255, 0, 100);
  stroke(255);
  strokeWeight(2);  
  beginShape();
  for (PVector tempPv : newObsVs) vertex(tempPv.x, tempPv.y);
  endShape();
}

void keyPressed() {
  switch(key) {
  case 'b':
    println("initialize ball");
    //for (Ball tempBall : balls) tempBall.initialize();
    for (Ball tempBall : balls) tempBall.initialize(mouseX, mouseY, random(-5, 5), random(-5, 5), random(10, 10));    
    for (Obstacle tempObs : obstacles) tempObs.drawnCnt = 0;
    break;
  case 'c':
    println("clear obstacles");
    obstacles.clear();
    break;
  case 's': //createGraphics and save image : https://processing.org/reference/createGraphics_.html
    float zoom = 0.25;
    PGraphics pg;
    pg = createGraphics((int)(width * zoom), (int)(height * zoom));
    pg.beginDraw();
    pg.background(255);
    pg.stroke(0);
    pg.strokeWeight(3);
    for (Obstacle tempObs : obstacles) {
      for (int i = 0; i < tempObs.vs.size(); i++) {
        PVector sp = tempObs.vs.get(i);
        PVector ep = new PVector(0, 0);
        if (i == tempObs.vs.size() - 1)  ep = tempObs.vs.get(0);
        else ep = tempObs.vs.get(i + 1);        
        pg.line(sp.x * zoom, sp.y * zoom, ep.x * zoom, ep.y * zoom);
      }
    }
    pg.endDraw();
    //pg.save("data/savedImg.png");
    pg.save("data/map.png");
    break;
  default:
    break;
  }
}