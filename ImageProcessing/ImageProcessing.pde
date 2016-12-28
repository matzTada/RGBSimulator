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

  for (PVector s : edges) {
    for (PVector e : edges) {
      if (judgeConnectivity(img, s, e)) {
        fill(0, 255, 0);
        line(s.x * width/img.width, s.y * height/img.height, e.x * width/img.width, e.y * height/img.height);
      }
    }
  }
  
  println("frameRate: " + frameRate + " size:" + edges.size());
}    