//2016/12/28 TadaMatz
//extract vector information from white-black map
//based on tutorial https://processing.org/tutorials/pixels/

PImage img;
ArrayList<PVector> edges = new ArrayList<PVector>();

void setup() {
  size(800, 800);
  img = loadImage("data/map.png");
  surface.setResizable(true);

  initializeFilter();

  //thinning
  boolean tsub1Flag = true;
  boolean tsub2Flag = true;
  while (true) {
    tsub1Flag = thinningSub1(img);
    if (!tsub1Flag) break;
    tsub2Flag = thinningSub2(img);
    if (!tsub2Flag) break;
  }

  //judge edge and branch
  edges = judgeEdgeBranch(img);
}

void draw() {
  background(0);
  image(img, 0, 0, width, height);

  println("judgeConnectivity");
  for (int i = 0; i < edges.size(); i++) {
    for (int j = i + 1; j < edges.size(); j++) {
      PVector s = edges.get(i);
      PVector e = edges.get(j);
      if (judgeConnectivity(img, s, e)) {
        stroke(0, 255, 0, 200);
        line(s.x * width/img.width, s.y * height/img.height, e.x * width/img.width, e.y * height/img.height);
        noStroke();
      }
    }
  }

  println("frameRate: " + frameRate + " size:" + edges.size());
}    