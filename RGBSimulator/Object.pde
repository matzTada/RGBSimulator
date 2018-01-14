//2016/12/28 TadaMatz

int OBJ_CHR_REFLECTION = 0;
int OBJ_CHR_DRAWN = 1;

class Obstacle {
  int id;
  ArrayList<PVector> vs;
  PVector center;
  float areaSize;
  boolean isGrabed;
  int drawnCnt;
  int character; //refer to OBJ_CHR_

  Obstacle(ArrayList<PVector> _vs, int _id) {
    id = _id;
    vs = new ArrayList<PVector>(_vs);
    center = getCenter();
    areaSize = getAreaSize();
    isGrabed = false;
    drawnCnt = 0;
    character = OBJ_CHR_REFLECTION;
  }

  void display() {
    if (judgeInObject(vs, new PVector(mouseX, mouseY))) fill(0, 0, 255, 100);
    else if (character == OBJ_CHR_REFLECTION) fill(255, 127, 0, 100);
    else if (character == OBJ_CHR_DRAWN) fill(0, 255, 100, 100);
    else fill(127, 200);
    stroke(255);
    strokeWeight(2);
    beginShape();
    for (PVector tempPV : vs)vertex(tempPV.x, tempPV.y);
    endShape(CLOSE);

    fill(255);
    textAlign(CENTER, CENTER);
    text("ID: " + id + "\n" + drawnCnt, center.x, center.y);

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
    if (character == OBJ_CHR_DRAWN) {

      //PVector tempSpeed = PVector.sub(center, tempBall.pos).normalize().mult(0.0001 * tempBall.pos.dist(c)); //spring like power
      PVector tempSpeed = PVector.sub(center, p).normalize()
        .mult((areaSize / 10000) * pow(max(width, height), 1) / pow(p.dist(center), 2)); //universal gravitation like power
      //.mult(constrain((areaSize / 10000) * pow(max(width, height), 1) / pow(p.dist(center), 2), 0.001, 5)); //with constrain universal gravitation like power
      return tempSpeed;       
      //println(constrain((areaSize / 10000) * pow(max(width, height), 1) / pow(tempBall.pos.dist(center), 2), 0.001, 5));
    }
    return null;
  }
};  