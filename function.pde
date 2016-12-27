//2016/12/24 TadaMatz

boolean judgeInObject(ArrayList<PVector> vs, PVector c) {
  //judge in
  //PVector center = new PVector(0, 0);
  //for (PVector tempVs : vs) center.add(tempVs);
  //center.set(center.x/vs.size(), center.y/vs.size());
  //for (PVector tempPV : vs) {
  //  println(tempPV + " " + degrees(atan2(tempPV.x - center.x, tempPV.y - center.y)));
  //}

  float sumAngle = 0.0;

  for (int i = 0; i < vs.size(); i++) {
    PVector sp = PVector.sub(vs.get(i), c);
    PVector ep = new PVector(0, 0);
    if (i == vs.size() - 1)  ep = PVector.sub(vs.get(0), c);
    else ep = PVector.sub(vs.get(i + 1), c);

    float tempSinTheta = (sp.x * ep.y - sp.y * ep.x) / (sp.mag() * ep.mag()); //cross
    float tempCosTheta = (sp.x * ep.x + sp.y * ep.y) / (sp.mag() * ep.mag()); //dot
    //println(tempSinTheta + " "+ degrees(asin(tempSinTheta)) + " " + tempCosTheta + " "+ degrees(acos(tempCosTheta)));

    sumAngle += tempSinTheta / abs(tempSinTheta) * degrees(acos(tempCosTheta));
  }

  //println(sumAngle);

  if (360 - 0.01 < abs(sumAngle) && abs(sumAngle) < 360 + 0.01) return true;
  else return false;


  //float sumAngle = 0.0;
  //float tempDeg = 0.0;
  //for (int i = 0; i < vs.size() - 1; i++) {
  //  PVector v1 = PVector.sub(vs.get(i), c);
  //  PVector v2 = PVector.sub(vs.get(i+1), c);
  //  tempDeg = degrees(PVector.angleBetween(v1, v2));
  //  //println(v1 + " " + v2 + " " + tempDeg);
  //  sumAngle += tempDeg;
  //}
  //PVector v1 = PVector.sub(vs.get(vs.size()-1), c);
  //PVector v2 = PVector.sub(vs.get(0), c);
  //tempDeg = degrees(PVector.angleBetween(v1, v2));
  ////println(v1 + " " + v2 + " "  + tempDeg);
  //sumAngle += tempDeg;

  //println(sumAngle);

  //if (360 - 0.0001 < sumAngle && sumAngle < 360 + 0.0001) return true;
  //else return false;
}

float getDistBetweenLinePoint(PVector dv, PVector i, PVector p) { //direction vector, the point where the direction vector pass, the point where the directin 
  //calculate parameter ax + by + c = 0
  float a = dv.y;
  float b = -dv.x;
  float c = dv.x * i.y - dv.y * i.x;

  //calculate dist
  return abs(a * p.x + b * p.y + c) / sqrt(pow(a, 2) + pow(b, 2));
}

PVector getIntersection(PVector pd, PVector pd0, PVector pe, PVector pe0) { //direction, point, direction, point
  //get intersection of the side and the vector
  //a x + b * y + e = 0;
  //c x + d * y + f = 0;
  //
  //[a b][x] = [-e]
  //[c d][y] = [-f]
  //
  //[x] =     1    [d -b][-e] = (-d*e+b*f) / (a*d-b*c)
  //[y] = (ad - bc)[-c a][-f] = (c*e-a*f) / (a*d-b*c)
  //

  PVector is = new PVector(0, 0); //intersection
  float a = pd.y;
  float b = -pd.x;
  float e = pd.x * pd0.y - pd.y * pd0.x;
  float c = pe.y;
  float d = -pe.x;
  float f = pe.x * pe0.y - pe.y * pe0.x;

  is.x = (-d*e+b*f) / (a*d-b*c);
  is.y = (c*e-a*f) / (a*d-b*c);

  return is;
}

boolean isIntersection(PVector a1, PVector a2, PVector a3, PVector a4) {
  if (((a1.x - a2.x) * (a3.y - a1.y) + (a1.y - a2.y) * (a1.x - a3.x)) 
    * ((a1.x - a2.x) * (a4.y - a1.y) + (a1.y - a2.y) * (a1.x - a4.x)) < 0
    &&
    ((a3.x - a4.x) * (a1.y - a3.y) + (a3.y - a4.y) * (a3.x - a1.x)) 
    * ((a3.x - a4.x) * (a2.y - a3.y) + (a3.y - a4.y) * (a3.x - a2.x))< 0
    ) return true;
  else return false;
}

boolean isCollisionBetweenCircleSegment(PVector c, float size, PVector a1, PVector a2) {
  if (getDistBetweenLinePoint(PVector.sub(a1, a2), a1, c) < size) {
    if (PVector.dot(PVector.sub(c, a1), PVector.sub(a1, a2)) * PVector.dot(PVector.sub(c, a2), PVector.sub(a1, a2)) <= 0) {
      return true;
    } else {
      if (size > PVector.sub(c, a1).mag() || size > PVector.sub(c, a1).mag()) {
        return true;
      }
    }
  }
  return false;
}

void explode(Obstacle obs, ArrayList<Ball> bs) {
  //explode around the newOb
  float maxDist = 0.0;
  for (PVector tempVs : obs.vs) {
    float tempDist = obs.center.dist(tempVs);
    if (maxDist < tempDist) {
      maxDist = tempDist;
    }
  }    
  for (Ball tempBall : bs) {
    if (tempBall.pos.dist(obs.center) <= maxDist) {
      PVector newPos = PVector.sub(tempBall.pos, obs.center).normalize().mult(maxDist).add(obs.center);
      PVector newSpeed = PVector.sub(tempBall.pos, obs.center).normalize().mult(tempBall.speed.mag());
      tempBall.updatePos(newPos);
      tempBall.updateVelocity(newSpeed);          
      //tempBall.initialize();
    }
  }
}

void drawGravityField(ArrayList<Obstacle> obss) {
  //visualize gravity field
  for (int i = 0; i < width; i += 10) {
    for (int j = 0; j < height; j += 10) {
      PVector tempArrow = new PVector(0, 0);
      for (Obstacle tempOb : obss) tempArrow.add(tempOb.gravity(new PVector(i, j)));
      stroke(200);
      line(i, j, i + 10 * tempArrow.x, j + 10 * tempArrow.y);
    }
  }
}