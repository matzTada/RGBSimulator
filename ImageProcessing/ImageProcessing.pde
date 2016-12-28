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

  int totalBlackCell = 0;
  img.loadPixels(); 
  for (int i = 0; i < img.width; i++) {
    for (int j = 0; j < img.height; j++) {
      int loc = i + j*img.width;      // The functions red(), green(), and blue() pull out the 3 color components from a pixel.
      if (img.pixels[loc] == color(0)) { 
        seekConnectedPath(img, new PVector(i, j), 5);
        totalBlackCell++;
      }
    }
  }
  println("totalBlackCell: " + totalBlackCell);



  noLoop();
  //println("frameRate: " + frameRate + " size:" + edges.size());
}    