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

            if (tempOb.character == OBJ_CHR_REFLECTION) {
              //reflection
              //println(nearestDist);
              PVector d_n = new PVector(-PVector.sub(ep, sp).y, PVector.sub(ep, sp).x);
              PVector d_is = getIntersection(PVector.sub(ep, sp), sp, d_n, pos);
              PVector n = PVector.sub(pos, d_is).normalize();
              pos = PVector.add(d_is, PVector.mult(n, size));
              speed = PVector.sub(speed, PVector.mult(n, PVector.dot(speed, n) * 2)); //get reflected slide
              return true;
            } else if (tempOb.character == OBJ_CHR_DRAWN) {
              //drawn
              tempOb.drawnCnt++;
              initialize(sourceX, sourceY, random(-5, 5), random(-5, 5), random(10, 10));    
              //initialize();
              return true;
            }
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