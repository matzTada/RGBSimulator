//2016/12/28 TadaMatz
//extract vector information from white-black map
//based on tutorial https://processing.org/tutorials/pixels/

PImage img;
//ArrayList<PVector> edges = new ArrayList<PVector>();
ArrayList<ArrayList<PVector>> vss = new ArrayList<ArrayList<PVector>>();

void setup() {
  size(800, 800);
  surface.setResizable(true);

  img = loadImage("data/map.png");

  vss = getPolygonVectorFromImage(img, 10, 170, 1000);

  //judge edge and branch. not reliable
  //edges = judgeEdgeBranch(img);
}

void draw() {
  background(0);
  image(img, 0, 0, width, height);

  for (ArrayList<PVector> tempVS : vss) {
    //visualize from vector
    for (int k = 0; k < tempVS.size(); k++) {
      PVector s = tempVS.get(k);
      PVector e = new PVector(0, 0);
      if (k == tempVS.size() - 1) e = tempVS.get(0);
      else e = tempVS.get(k+1);
      stroke(0, 255, 0, 200);
      strokeWeight(2);
      line(s.x * width/img.width, s.y * height/img.height, e.x * width/img.width, e.y * height/img.height);
      noStroke();
    }
  }  



  noLoop();
  //println("frameRate: " + frameRate + " size:" + edges.size());
}    