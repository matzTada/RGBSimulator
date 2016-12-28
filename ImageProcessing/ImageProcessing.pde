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

  while (deburring(img)); //can be used for getting polygon (


  //judge edge and branch
  //edges = judgeEdgeBranch(img);
}

void draw() {
  background(0);
  image(img, 0, 0, width, height);

  int [][] edgeMatrix = new int[img.width][img.height]; //matrix to hold edge data

  //get edge
  int totalBlackCell = 0;
  img.loadPixels(); 
  for (int j = 0; j < img.height; j++) {
    for (int i = 0; i < img.width; i++) {
      int loc = i + j*img.width;      // The functions red(), green(), and blue() pull out the 3 color components from a pixel.
      if (img.pixels[loc] == color(0)) { 
        edgeMatrix[i][j] = 1;
        if (judgeEdgeByAngle(img, new PVector(i, j), 10, 170)) edgeMatrix[i][j]  = 2;  //(image, starting point. scoped length, judgeAngle
        totalBlackCell++;
      } else edgeMatrix[i][j] = 0;
    }
  }
  println("totalBlackCell: " + totalBlackCell);


  ArrayList<PVector> vs = new ArrayList<PVector>();

  //convert matrix to PVector array
  img.loadPixels(); 
  for (int j = 0; j < img.height; j++) {
    for (int i = 0; i < img.width; i++) {
      if (edgeMatrix[i][j] == 2) {  
        vs = getVectorByMatrix(edgeMatrix, new PVector(i, j), 1000);
        println("vs.size(): " + vs.size());
        //new object should be here

        //visualize from vector
        for (int k = 0; k < vs.size(); k++) {
          PVector s = vs.get(k);
          PVector e = new PVector(0, 0);
          if (k == vs.size() - 1) e = vs.get(0);
          else e = vs.get(k+1);
          stroke(0, 255, 0, 200);
          strokeWeight(5);
          line(s.x * width/img.width, s.y * height/img.height, e.x * width/img.width, e.y * height/img.height);
          noStroke();
        }
      }
    }
  }

  noLoop();
  //println("frameRate: " + frameRate + " size:" + edges.size());
}    