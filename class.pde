//2016/12/24 TadaMatz

class Ball {
  PVector pos;
  PVector speed;
  float size;

  Ball() {
    pos = new PVector(width/2, height/2);
    speed = new PVector(random(-3, 3), random(-3, 3));
    size = 10;
  }
  Ball(float _x, float _y, float _vx, float _vy, float _size) {
    pos = new PVector(_x, _y);
    speed = new PVector(_vx, _vy);
    size = _size;
  }

  void initialize() {
    pos = new PVector(width/2, height/2);
    speed = new PVector(random(-5, 5), random(-5, 5));
  }
  void initialize(float _x, float _y, float _vx, float _vy, float _size) {
    pos = new PVector(_x, _y);
    speed = new PVector(_vx, _vy);
    size = _size;
  }

  void update() {
    pos.x += speed.x;
    pos.y += speed.y;
    ////roll 
    //if (pos.x > width) pos.x -= width;
    //if (pos.x < 0) pos.x += width;
    //if (pos.y > height) pos.y -= height;
    //if (pos.y < 0) pos.y += width;
  }

  void updateVelocity(PVector _v) {
    speed.set(_v);
  }

  void updatePos(PVector _pos) {
    pos.set(_pos);
  }

  boolean collision(ArrayList<Obstacle> obs) {
    //collision between circle and segment
    //initialize variables
    PVector sp = new PVector(0, 0); //start point of side
    PVector ep = new PVector(0, 0); //end point of side

    boolean collision = false;
    float nearestDist = max(width, height);

    //look for collision
    for (Obstacle tempOb : obs) {
      for (int i = 0; i < tempOb.vs.size(); i++) {
        sp = tempOb.vs.get(i); 
        if (i == tempOb.vs.size() - 1) ep = tempOb.vs.get(0);
        else ep = tempOb.vs.get(i+1);

        if (isCollisionBetweenCircleSegment(pos, size, sp, ep)) {
          collision = true;
          float tempDist = PVector.dist(getIntersection(PVector.sub(sp, ep), sp, speed, pos), pos);
          if (nearestDist > tempDist) {
            nearestDist = tempDist;

            //reflection
            ////println(nearestDist);
            //PVector d_n = new PVector(-PVector.sub(ep, sp).y, PVector.sub(ep, sp).x);
            //PVector d_is = getIntersection(PVector.sub(ep, sp), sp, d_n, pos);
            //PVector n = PVector.sub(pos, d_is).normalize();
            //pos = PVector.add(d_is, PVector.mult(n, size));
            //speed = PVector.sub(speed, PVector.mult(n, PVector.dot(speed, n) * 2)); //get reflected slide

            //fountain
            tempOb.collisionCnt++;
            initialize(mouseX, mouseY, random(-5, 5), random(-5, 5), random(10, 10));    
            //initialize();
            return true;
          }
        }
      }
    }

    if (collision) return true;
    return false;


    ////using isIntersection
    ////initialize variables
    //boolean collisionFlag = false;
    //float nearestDist = max(width, height);
    //float tempDist = 0.0; 
    //PVector sp = new PVector(0, 0); //start point of side
    //PVector ep = new PVector(0, 0); //end point of side
    //PVector is = new PVector(0, 0); //intersection
    //PVector csp = new PVector(0, 0); //start point of collision side
    //PVector cep = new PVector(0, 0); //end point of collision side

    ////look for collision
    //for (Obstacle tempOb : obs) {
    //  for (int i = 0; i < tempOb.vs.size(); i++) {
    //    sp = tempOb.vs.get(i); 
    //    if (i == tempOb.vs.size() - 1) ep = tempOb.vs.get(0);
    //    else ep = tempOb.vs.get(i+1);

    //    if (isIntersection(sp, ep, pos, PVector.add(pos, speed))) {
    //      collisionFlag = true;
    //      //tempDist =  getDistBetweenLinePoint(PVector.sub(sp, ep), sp, pos);
    //      tempDist = PVector.dist(getIntersection(PVector.sub(sp, ep), sp, speed, pos), pos);
    //      if (nearestDist > tempDist) {
    //        nearestDist = tempDist;
    //        is = getIntersection(PVector.sub(sp, ep), sp, speed, pos);
    //        csp = sp;
    //        cep = ep;
    //      }
    //    }
    //  }
    //}

    ////if collide, adjust posision and speed
    //if (collisionFlag) {
    //  pos = is;
    //  PVector newSpeed = new PVector(0, 0); //with reflection idea from this site (http://marupeke296.com/COL_Basic_No5_WallVector.html)
    //  PVector n  = new PVector(0, 0); //normarized normal vector
    //  n = PVector.sub(csp, cep).rotate(radians(-90)).normalize(); //CAUTION!! kinds of dangerous way. every obstacles must be counter clock wise
    //  newSpeed = PVector.sub(speed, PVector.mult(n, PVector.dot(speed, n) * 2)); //get reflected slide
    //  //println(csp, cep);
    //  //println("speed: " + speed);
    //  //println("newSpeed: " + newSpeed);
    //  speed = newSpeed;
    //}

    //return collisionFlag;


    ////using judgeInObject
    //for (Obstacle tempOb : obs) {
    //  if (judgeInObject(tempOb.vs, pos)) { 
    //    //println("--- in the object ---");

    //    //get nearest side
    //    float nearestDist = max(width, height);
    //    float tempDist = 0.0; 
    //    PVector sp = new PVector(0, 0); //start point of side
    //    PVector ep = new PVector(0, 0); //end point of side
    //    PVector is = new PVector(0, 0); //intersection
    //    PVector csp = new PVector(0, 0); //start point of collision side
    //    PVector cep = new PVector(0, 0); //end point of collision side
    //    for (int i = 0; i < tempOb.vs.size(); i++) {
    //      sp = tempOb.vs.get(i); 
    //      if (i == tempOb.vs.size() - 1) ep = tempOb.vs.get(0);
    //      else ep = tempOb.vs.get(i+1);
    //      tempDist =  getDistBetweenLinePoint(PVector.sub(sp, ep), sp, pos);

    //      if (nearestDist > tempDist) {
    //        nearestDist = tempDist;
    //        is = getIntersection(PVector.sub(sp, ep), sp, speed, pos);
    //        csp = sp;
    //        cep = ep;
    //      }
    //    }

    //    //adjust current position and speed 
    //    //println("nearestDist: " + tempDist);            
    //    //println("is: " + is);

    //    pos = is;

    //    PVector newSpeed = new PVector(0, 0); //with reflection idea from this site (http://marupeke296.com/COL_Basic_No5_WallVector.html)
    //    PVector n  = new PVector(0, 0); //normarized normal vector
    //    n = PVector.sub(csp, cep).rotate(radians(-90)).normalize(); //CAUTION!! kinds of dangerous way. every obstacles must be counter clock wise
    //    newSpeed = PVector.sub(speed, PVector.mult(n, PVector.dot(speed, n) * 2)); //get reflected slide
    //    //println(csp, cep);
    //    //println("speed: " + speed);
    //    //println("newSpeed: " + newSpeed);
    //    speed = newSpeed;
    //    break;
    //  }
    //}
  }

  void display() {
    fill(255, 100);
    ellipse(pos.x, pos.y, size, size);
    stroke(255);
    line(pos.x, pos.y, pos.x + speed.x, pos.y + speed.y);
  }
};

class Obstacle {
  ArrayList<PVector> vs;
  PVector center;
  float areaSize;
  boolean isGrabed;
  int collisionCnt;

  Obstacle(ArrayList<PVector> _vs) {
    vs = new ArrayList<PVector>(_vs);
    center = getCenter();
    areaSize = getAreaSize();
    isGrabed = false;
    collisionCnt = 0;
  }

  void display() {
    if (judgeInObject(vs, new PVector(mouseX, mouseY))) fill(0, 0, 255, 100);
    else fill(255, 127, 0, 100);
    stroke(255);
    strokeWeight(2);
    beginShape();
    for (PVector tempPV : vs)vertex(tempPV.x, tempPV.y);
    endShape(CLOSE);
    
    fill(255);
    textAlign(CENTER, CENTER);
    text(collisionCnt, center.x, center.y);

    //for (PVector tempVs : vs) {
    //  fill(255);
    //  line(mouseX, mouseY, tempVs.x, tempVs.y);
    //  text("" + PVector.sub(tempVs, new PVector(mouseX, mouseY)) + (degrees(atan2(tempVs.x - mouseX, tempVs.y - mouseY)) + 180), 
    //    (mouseX + tempVs.x)/2, (mouseY + tempVs.y)/2);
    //}
  }

  void translatePos(float _x, float _y) { //rotate on the spot
    for (PVector tempPV : vs) tempPV.sub(center).add(new PVector(_x, _y));
    center = getCenter();
    areaSize = getAreaSize();
  }

  void rotate(float _angle) {
    for (PVector tempPV : vs) tempPV.sub(center).rotate(_angle).add(center);
  }

  PVector getCenter() {
    PVector c = new PVector(0, 0);
    for (PVector tempVs : vs) c.add(tempVs);
    c.set(c.x/vs.size(), c.y/vs.size());
    return c;
  }

  float getAreaSize() {
    float sumArea = 0.0;
    for (int i = 0; i < vs.size(); i++) {
      PVector sp = PVector.sub(vs.get(i), center);
      PVector ep = new PVector(0, 0);
      if (i == vs.size() - 1)  ep = PVector.sub(vs.get(0), center);
      else ep = PVector.sub(vs.get(i + 1), center);

      float crossValue = (sp.x * ep.y - sp.y * ep.x); //cross

      sumArea += abs(crossValue);
    }
    return sumArea;
  }

  PVector gravity(PVector p) {
    //PVector tempSpeed = PVector.sub(center, tempBall.pos).normalize().mult(0.0001 * tempBall.pos.dist(c)); //spring like power
    PVector tempSpeed = PVector.sub(center, p).normalize()
      .mult((areaSize / 10000) * pow(max(width, height), 1) / pow(p.dist(center), 2)); //universal gravitation like power
    //.mult(constrain((areaSize / 10000) * pow(max(width, height), 1) / pow(p.dist(center), 2), 0.001, 5)); //with constrain universal gravitation like power
    return tempSpeed;       
    //println(constrain((areaSize / 10000) * pow(max(width, height), 1) / pow(tempBall.pos.dist(center), 2), 0.001, 5));
  }
};  