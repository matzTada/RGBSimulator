//2016/12/28 TadaMatz
//reference http://www.ice.gunma-ct.ac.jp/~tsurumi/courses/ImagePro/binarization2.pdf


ArrayList<int[][]> thinning1filterDelete = new ArrayList<int [][]>();
ArrayList<int[][]> thinning1filterKeep = new ArrayList<int [][]>();
ArrayList<int[][]> thinning2filterDelete = new ArrayList<int [][]>();
ArrayList<int[][]> thinning2filterKeep = new ArrayList<int [][]>();

ArrayList<int[][]> edgefilter = new ArrayList<int [][]>();
ArrayList<int[][]> branchfilter = new ArrayList<int [][]>();

boolean judgeRastaMatrix(int rasta[][], int filter[][], int size) { //if match return true
  //println("judgeRastaMatrix");
  //println("rasta");
  //for (int j = 0; j < size; j++) {
  //  for (int i = 0; i < size; i++) {
  //    print(rasta[i][j] + " ");
  //  }
  //  println("");
  //}
  //println("filter");
  //for (int j = 0; j < size; j++) {
  //  for (int i = 0; i < size; i++) {
  //    print(filter[i][j] + " ");
  //  }
  //  println("");
  //}

  boolean returnFlag = true;
  for (int j = 0; j < size; j++) {
    for (int i = 0; i < size; i++) {
      if (filter[i][j] != 2 && filter[i][j] != rasta[i][j]) returnFlag = false;
    }
  }
  //println(returnFlag);
  return returnFlag;
}

void initializeFilter() {
  thinning1filterDelete.add(new int[][]{{2, 0, 2}, {2, 1, 2}, {2, 2, 2}});
  thinning1filterDelete.add(new int[][]{{2, 2, 2}, {2, 1, 0}, {2, 2, 2}});

  thinning1filterKeep.add(new int[][]{{2, 0, 2}, {2, 1, 1}, {2, 1, 0}});
  thinning1filterKeep.add(new int[][]{{0, 1, 2}, {1, 1, 0}, {2, 2, 2}});
  thinning1filterKeep.add(new int[][]{{2, 2, 2}, {0, 1, 0}, {2, 1, 2}});
  thinning1filterKeep.add(new int[][]{{2, 0, 2}, {1, 1, 2}, {2, 0, 2}});
  thinning1filterKeep.add(new int[][]{{2, 1, 2}, {0, 1, 0}, {2, 2, 2}});
  thinning1filterKeep.add(new int[][]{{2, 0, 2}, {2, 1, 1}, {2, 0, 2}});
  thinning1filterKeep.add(new int[][]{{2, 2, 2}, {0, 1, 2}, {1, 0, 2}});
  thinning1filterKeep.add(new int[][]{{1, 0, 2}, {0, 1, 2}, {2, 2, 2}});
  thinning1filterKeep.add(new int[][]{{2, 0, 1}, {2, 1, 0}, {2, 2, 2}});
  thinning1filterKeep.add(new int[][]{{2, 2, 2}, {2, 1, 0}, {2, 0, 1}});
  thinning1filterKeep.add(new int[][]{{0, 1, 0}, {1, 1, 1}, {0, 2, 0}});
  thinning1filterKeep.add(new int[][]{{0, 1, 0}, {2, 1, 1}, {0, 1, 0}});
  thinning1filterKeep.add(new int[][]{{0, 2, 0}, {1, 1, 1}, {0, 1, 0}});
  thinning1filterKeep.add(new int[][]{{0, 1, 0}, {1, 1, 2}, {0, 1, 0}});

  thinning2filterDelete.add(new int[][]{{2, 2, 2}, {2, 1, 2}, {2, 0, 2}});
  thinning2filterDelete.add(new int[][]{{2, 2, 2}, {0, 1, 2}, {2, 2, 2}});

  thinning2filterKeep.add(new int[][]{{0, 1, 2}, {1, 1, 2}, {2, 0, 2}});
  thinning2filterKeep.add(new int[][]{{2, 2, 2}, {0, 1, 1}, {2, 1, 0}});
  thinning2filterKeep.add(new int[][]{{2, 2, 2}, {0, 1, 0}, {2, 1, 2}});
  thinning2filterKeep.add(new int[][]{{2, 0, 2}, {1, 1, 2}, {2, 0, 2}});
  thinning2filterKeep.add(new int[][]{{2, 1, 2}, {0, 1, 0}, {2, 2, 2}});
  thinning2filterKeep.add(new int[][]{{2, 0, 2}, {2, 1, 1}, {2, 0, 2}});
  thinning2filterKeep.add(new int[][]{{2, 2, 2}, {0, 1, 2}, {1, 0, 2}});
  thinning2filterKeep.add(new int[][]{{1, 0, 2}, {0, 1, 2}, {2, 2, 2}});
  thinning2filterKeep.add(new int[][]{{2, 0, 1}, {2, 1, 0}, {2, 2, 2}});
  thinning2filterKeep.add(new int[][]{{2, 2, 2}, {2, 1, 0}, {2, 0, 1}});
  thinning2filterKeep.add(new int[][]{{0, 1, 0}, {1, 1, 1}, {0, 2, 0}});
  thinning2filterKeep.add(new int[][]{{0, 1, 0}, {2, 1, 1}, {0, 1, 0}});
  thinning2filterKeep.add(new int[][]{{0, 2, 0}, {1, 1, 1}, {0, 1, 0}});
  thinning2filterKeep.add(new int[][]{{0, 1, 0}, {1, 1, 2}, {0, 1, 0}});

  edgefilter.add(new int[][]{{0, 0, 0 }, {0, 1, 0 }, {2, 1, 2 }});
  edgefilter.add(new int[][]{{2, 0, 0 }, {1, 1, 0 }, {2, 0, 0 }});
  edgefilter.add(new int[][]{{2, 1, 2 }, {0, 1, 0 }, {0, 0, 0 }});
  edgefilter.add(new int[][]{{0, 0, 2 }, {0, 1, 1 }, {0, 0, 2 }});
  edgefilter.add(new int[][]{{0, 0, 0 }, {0, 1, 0 }, {1, 0, 0 }});
  edgefilter.add(new int[][]{{1, 0, 0 }, {0, 1, 0 }, {0, 0, 0 }});
  edgefilter.add(new int[][]{{0, 0, 1 }, {0, 1, 0 }, {0, 0, 0 }});
  edgefilter.add(new int[][]{{0, 0, 0 }, {0, 1, 0 }, {0, 0, 1 }});

  //3
  branchfilter.add(new int[][]{{2, 1, 2 }, {1, 1, 1 }, {0, 0, 0 }});
  branchfilter.add(new int[][]{{0, 1, 2 }, {0, 1, 1 }, {0, 1, 2 }});
  branchfilter.add(new int[][]{{0, 0, 0 }, {1, 1, 1 }, {2, 1, 2 }});
  branchfilter.add(new int[][]{{2, 1, 0 }, {1, 1, 0 }, {2, 1, 0 }});
  branchfilter.add(new int[][]{{1, 0, 0 }, {0, 1, 0 }, {1, 0, 1 }});
  branchfilter.add(new int[][]{{1, 0, 1 }, {0, 1, 0 }, {1, 0, 0 }});
  branchfilter.add(new int[][]{{1, 0, 1 }, {0, 1, 0 }, {0, 0, 1 }});
  branchfilter.add(new int[][]{{0, 0, 1 }, {0, 1, 0 }, {1, 0, 1 }});
  //4
  branchfilter.add(new int[][]{{2, 1, 2 }, {1, 1, 1 }, {2, 1, 2 }});
  branchfilter.add(new int[][]{{1, 0, 1 }, {0, 1, 0 }, {1, 0, 1 }});
}

boolean thinningSub1(PImage image) {     //Thinning subprocess 1
  boolean returnFlag = false;
  image.loadPixels(); 
  for (int y = 1; y < image.height-1; y++) {
    for (int x = image.width-2; x >= 1; x--) {
      int loc = x + y*image.width;      // The functions red(), green(), and blue() pull out the 3 color components from a pixel.
      if (image.pixels[loc] == color(0)) { //if black
        int rastaMatrix[][] = new int[3][3];
        for (int i = -1; i <= 1; i++) 
          for (int j = -1; j <= 1; j++) 
            if (image.pixels[loc + i + j*image.width] == color(0)) rastaMatrix[i+1][j+1] = 1;
            else rastaMatrix[i+1][j+1] = 0;

        boolean keepFlag= false;
        for (int[][] tempFilter : thinning1filterKeep) 
          if (judgeRastaMatrix(rastaMatrix, tempFilter, 3)) 
            keepFlag = true;

        boolean deleteFlag = false;
        if (!keepFlag) 
          for (int[][] tempFilter : thinning1filterDelete) 
            if (judgeRastaMatrix(rastaMatrix, tempFilter, 3)) 
              deleteFlag = true;

        if (deleteFlag) {
          image.pixels[loc] = color(200);
          returnFlag = true;
        } else {
          image.pixels[loc] = color(0);
        }
      }
    }
  }
  return returnFlag;
}

boolean thinningSub2(PImage image) {     //Thinning subprocess 2
  boolean returnFlag = false;
  image.loadPixels(); 
  for (int y = image.width-2; y >= 1; y--) {
    for (int x = 1; x < image.width-1; x++) {
      int loc = x + y*image.width;      // The functions red(), green(), and blue() pull out the 3 color components from a pixel.
      if (image.pixels[loc] == color(0)) { //if black
        int rastaMatrix[][] = new int[3][3];
        for (int i = -1; i <= 1; i++) 
          for (int j = -1; j <= 1; j++) 
            if (image.pixels[loc + i + j*image.width] == color(0)) rastaMatrix[i+1][j+1] = 1;
            else rastaMatrix[i+1][j+1] = 0;

        boolean keepFlag= false;
        for (int[][] tempFilter : thinning2filterKeep) 
          if (judgeRastaMatrix(rastaMatrix, tempFilter, 3)) 
            keepFlag = true;

        boolean deleteFlag = false;
        if (!keepFlag) 
          for (int[][] tempFilter : thinning2filterDelete) 
            if (judgeRastaMatrix(rastaMatrix, tempFilter, 3)) 
              deleteFlag = true;

        if (deleteFlag) {
          image.pixels[loc] = color(200);
          returnFlag = true;
        } else {
          image.pixels[loc] = color(0);
        }
      }
    }
  }
  return returnFlag;
}

ArrayList<PVector> judgeEdgeBranch(PImage image) {     //judge edge branch
  ArrayList<PVector> returnEdges = new ArrayList<PVector>();
  image.loadPixels(); 
  for (int y = 1; y < image.height-1; y++) {
    for (int x = 1; x < image.width-1; x++) {
      int loc = x + y*image.width;      // The functions red(), green(), and blue() pull out the 3 color components from a pixel.
      if (image.pixels[loc] == color(0)) { //if black
        int rastaMatrix[][] = new int[3][3];
        for (int i = -1; i <= 1; i++) 
          for (int j = -1; j <= 1; j++) 
            if (image.pixels[loc + i + j*image.width] == color(0)) rastaMatrix[i+1][j+1] = 1;
            else rastaMatrix[i+1][j+1] = 0;

        boolean judgeFlag= false;
        for (int[][] tempFilter : edgefilter) 
          if (judgeRastaMatrix(rastaMatrix, tempFilter, 3)) 
            judgeFlag = true;
        for (int[][] tempFilter : branchfilter) 
          if (judgeRastaMatrix(rastaMatrix, tempFilter, 3)) 
            judgeFlag = true;


        if (judgeFlag) {
          image.pixels[loc] = color(255, 0, 0);
          returnEdges.add(new PVector(x, y));
        } else {
          image.pixels[loc] = color(0);
        }
      }
    }
  }
  return returnEdges;
}


boolean judgeConnectivity(PImage image, PVector start, PVector end) {     //judge edge branch
  boolean returnFlag = false;
  image.loadPixels(); 
  for (int y = 1; y < image.height-1; y++) {
    for (int x = 1; x < image.width-1; x++) {
      int loc = x + y*image.width;      // The functions red(), green(), and blue() pull out the 3 color components from a pixel.
      if (image.pixels[loc] == color(0)) { //if black
      }
    }
  }
  //return returnFlag;
  return true;
}