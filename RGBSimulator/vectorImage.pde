//2016/12/28 TadaMatz
//reference http://www.ice.gunma-ct.ac.jp/~tsurumi/courses/ImagePro/binarization2.pdf


ArrayList<int[][]> thinning1filterDelete = new ArrayList<int [][]>();
ArrayList<int[][]> thinning1filterKeep = new ArrayList<int [][]>();
ArrayList<int[][]> thinning2filterDelete = new ArrayList<int [][]>();
ArrayList<int[][]> thinning2filterKeep = new ArrayList<int [][]>();

ArrayList<int[][]> deburringfilter = new ArrayList<int [][]>();

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

  //deburring
  deburringfilter.add(new int[][]{{1, 0, 0}, {0, 1, 0}, {0, 0, 0}});
  deburringfilter.add(new int[][]{{2, 1, 2}, {0, 1, 0}, {0, 0, 0}});
  deburringfilter.add(new int[][]{{0, 0, 1}, {0, 1, 0}, {0, 0, 0}});
  deburringfilter.add(new int[][]{{2, 0, 0}, {1, 1, 0}, {2, 0, 0}});
  deburringfilter.add(new int[][]{{0, 0, 0}, {0, 1, 0}, {0, 0, 0}});
  deburringfilter.add(new int[][]{{0, 0, 2}, {0, 1, 1}, {0, 0, 2}});
  deburringfilter.add(new int[][]{{0, 0, 0}, {0, 1, 0}, {1, 0, 0}});
  deburringfilter.add(new int[][]{{0, 0, 0}, {0, 1, 0}, {2, 1, 2}});
  deburringfilter.add(new int[][]{{0, 0, 0}, {0, 1, 0}, {0, 0, 1}}); 

  deburringfilter.add(new int[][]{{2, 1, 2}, {1, 1, 0}, {2, 0, 0}});
  deburringfilter.add(new int[][]{{2, 1, 2}, {0, 1, 1}, {0, 0, 2}});
  deburringfilter.add(new int[][]{{2, 0, 0}, {1, 1, 0}, {2, 1, 2}});
  deburringfilter.add(new int[][]{{0, 0, 2}, {0, 1, 1}, {2, 1, 2}});


  //edge
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
          //image.pixels[loc] = color(255);
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
  for (int y = image.height-2; y >= 1; y--) {
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
          //image.pixels[loc] = color(255);
          returnFlag = true;
        } else {
          image.pixels[loc] = color(0);
        }
      }
    }
  }
  return returnFlag;
}

boolean deburring(PImage image) {     //trimming
  boolean returnFlag = false;
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

        boolean deburringFlag= false;
        for (int[][] tempFilter : deburringfilter) 
          if (judgeRastaMatrix(rastaMatrix, tempFilter, 3)) 
            deburringFlag = true;

        if (deburringFlag) {
          //image.pixels[loc] = color(200);
          image.pixels[loc] = color(255);
          returnFlag = true;
        } else {
          image.pixels[loc] = color(0);
        }
      }
    }
  }
  return returnFlag;
}

boolean recursiveSeekConnectedPath(PVector pos, int[][] matrix, int lenGiven, ArrayList<PVector> path) {
  if (path.size() >= lenGiven) { 
    return true;
  }
  boolean getFlag = false;
  for (int j = -1; j <= 1; j++) {
    for (int i = -1; i <= 1; i++) {
      if (matrix[(int)pos.x + i][(int)pos.y + j] == 1) {
        matrix[(int)pos.x + i][(int)pos.y + j] = 2;
        path.add(new PVector((int)pos.x + i, (int)pos.y + j));
        getFlag = recursiveSeekConnectedPath(new PVector((int)pos.x + i, (int)pos.y + j), matrix, lenGiven, path);
        if (getFlag) break;
        path.remove(path.size() - 1);
        matrix[(int)pos.x + i][(int)pos.y + j] = 1;
      }
    }
    if (getFlag) break;
  }

  if (getFlag) return true;
  else return false;
}

boolean judgeEdgeByAngle(PImage image, PVector s, int lenGiven, float judgeAngle) { //(image, start point, scoped length, judgeAngle)
  //initialize image array
  image.loadPixels(); 
  int [][] imageArray = new int[image.width][image.height];
  for (int y = 0; y < image.height; y++) {
    for (int x = 0; x < image.width; x++) {
      int loc = x + y*image.width;      // The functions red(), green(), and blue() pull out the 3 color components from a pixel.
      if (image.pixels[loc] == color(0)) imageArray[x][y] = 1; //if black
      else imageArray[x][y] = 0;
    }
  }

  //for (int y = 0; y < image.height; y++) {
  //  for (int x = 0; x < image.width; x++) {
  //    print(imageArray[x][y] + " ");
  //  }
  //  println("");
  //}


  //get both edges
  ArrayList<PVector> returnPath = new ArrayList<PVector>();
  ArrayList<PVector> path1 = new ArrayList<PVector>();
  if (recursiveSeekConnectedPath(s, imageArray, lenGiven, path1)) {
    //println("s: " + s + " l: " + path1.get(path1.size() - 1));
  }
  returnPath.addAll(path1);

  //for (PVector tempPV : path1) {
  //  if (tempPV == path1.get(0)) fill(0, 255, 0, 200);
  //  else if (tempPV == path1.get(path1.size()-1)) fill(255, 0, 0, 200); 
  //  else fill(0, 0, 255, 200);
  //  rect(tempPV.x * width/img.width, tempPV.y * height/img.height, width/img.width, height/img.height);
  //}

  ArrayList<PVector> path2 = new ArrayList<PVector>();
  if (recursiveSeekConnectedPath(s, imageArray, lenGiven, path2)) {
    //println("s: " + s + " l: " + path2.get(path2.size() - 1));
  }
  returnPath.addAll(path2);

  //for (PVector tempPV : path2) {
  //  if (tempPV == path2.get(0)) fill(0, 255, 0, 200);
  //  else if (tempPV == path2.get(path2.size()-1)) fill(255, 0, 0, 200); 
  //  else fill(0, 0, 255, 200);
  //  rect(tempPV.x * width/img.width, tempPV.y * height/img.height, width/img.width, height/img.height);
  //}

  //get vertex by angle 
  if (path1.size() != 0 && path2.size() != 0) { 
    float degree = degrees(PVector.angleBetween(PVector.sub(path1.get(path1.size()-1), path1.get(0)), PVector.sub(path2.get(path2.size()-1), path2.get(0))));
    if (degree < judgeAngle) {
      //then get this point(i, j) as a vector
      //println(s + " degree: " + degree);
      fill(255, 0, 0, 200);
      rect(s.x * width/image.width, s.y * height/image.height, width/image.width, height/image.height);
      return true;
    }
  }
  return false;
}


boolean recursiveAlongPath(PVector pos, PVector posGiven, int[][] matrix, int lenGiven, ArrayList<PVector> path, ArrayList<PVector> vertex) {
  if (path.size() >= lenGiven || (path.size() > 2 && pos.x == posGiven.x && pos.y == posGiven.y)) { 
    return true;
  }
  boolean getFlag = false;
  for (int j = -1; j <= 1; j++) {
    for (int i = -1; i <= 1; i++) {
      if (matrix[(int)pos.x + i][(int)pos.y + j] == 1 || matrix[(int)pos.x + i][(int)pos.y + j] == 2) {
        PVector nextPV = new PVector((int)pos.x + i, (int)pos.y + j);
        path.add(nextPV);
        if (matrix[(int)pos.x + i][(int)pos.y + j] == 2) vertex.add(nextPV);
        matrix[(int)pos.x + i][(int)pos.y + j] = 3;
        getFlag = recursiveAlongPath(new PVector((int)pos.x + i, (int)pos.y + j), posGiven, matrix, lenGiven, path, vertex);
        if (getFlag) break;
        path.remove(path.size() - 1);
        if (matrix[(int)pos.x + i][(int)pos.y + j] == 2) vertex.remove(vertex.size() - 1);
        matrix[(int)pos.x + i][(int)pos.y + j] = 1;
      }
    }
    if (getFlag) break;
  }

  if (getFlag) return true;
  else return false;
}

ArrayList<PVector> getVectorFromMatrix(PImage image, int [][] matrix, PVector s, int lenGiven) {
  //for (int j = 0; j < image.height; j++) {
  //  for (int i = 0; i < image.width; i++) {
  //    print(matrix[i][j] + " ");
  //  }
  //  println("");
  //}

  //get both edges
  ArrayList<PVector> path = new ArrayList<PVector>();
  ArrayList<PVector> vertex = new ArrayList<PVector>();
  //println("s: " + s);
  if (recursiveAlongPath(s, s, matrix, lenGiven, path, vertex)) {
    //println("s: " + s);
  }

  for (PVector tempPV : path) {
    if (tempPV == path.get(0)) fill(0, 255, 0, 200);
    else if (tempPV == path.get(path.size()-1)) fill(255, 0, 0, 200); 
    else fill(0, 0, 255, 200);
    rect(tempPV.x * width/image.width, tempPV.y * height/image.height, width/image.width, height/image.height);
  }
  for (PVector tempPV : vertex) {
    fill(255, 165, 0, 200);
    rect(tempPV.x * width/image.width, tempPV.y * height/image.height, width/image.width, height/image.height);
  }

  return vertex;
}

ArrayList<ArrayList<PVector>> getPolygonVectorFromImage(PImage image, int scopedLength, float judgeAngle, int maxSeekLength) {
  initializeFilter();

  //thinning
  boolean tsub1Flag = true;
  boolean tsub2Flag = true;
  while (true) {
    tsub1Flag = thinningSub1(image);
    if (!tsub1Flag) break;
    tsub2Flag = thinningSub2(image);
    if (!tsub2Flag) break;
  }

  //deburring
  while (deburring(image)); //can be used for getting polygon

  //judge edge and arrange edge matrix from image
  int [][] edgeMatrix = new int[image.width][image.height]; //matrix to hold edge data
  int totalBlackCell = 0;
  image.loadPixels(); 
  for (int j = 0; j < image.height; j++) {
    for (int i = 0; i < image.width; i++) {
      int loc = i + j*image.width;      // The functions red(), green(), and blue() pull out the 3 color components from a pixel.
      if (image.pixels[loc] == color(0)) { 
        edgeMatrix[i][j] = 1;
        if (judgeEdgeByAngle(image, new PVector(i, j), scopedLength, judgeAngle)) edgeMatrix[i][j] = 2;  //(image, starting point. scoped length, judgeAngle
        totalBlackCell++;
      } else edgeMatrix[i][j] = 0;
    }
  }
  //println("totalBlackCell: " + totalBlackCell);

  //convert matrix to PVector array
  ArrayList<ArrayList<PVector>> returnVss = new ArrayList<ArrayList<PVector>>();
  image.loadPixels(); 
  for (int j = 0; j < image.height; j++) {
    for (int i = 0; i < image.width; i++) {
      if (edgeMatrix[i][j] == 2) { 
        ArrayList<PVector> vs = new ArrayList<PVector>();
        vs = getVectorFromMatrix(image, edgeMatrix, new PVector(i, j), maxSeekLength);
        returnVss.add(vs);
        //println("vs.size(): " + vs.size());
        //new object should be here
      }
    }
  }
  return returnVss;
}



//ArrayList<PVector> judgeEdgeBranch(PImage image) {     //judge edge branch
//  ArrayList<PVector> returnEdges = new ArrayList<PVector>();
//  image.loadPixels(); 
//  for (int y = 1; y < image.height-1; y++) {
//    for (int x = 1; x < image.width-1; x++) {
//      int loc = x + y*image.width;      // The functions red(), green(), and blue() pull out the 3 color components from a pixel.
//      if (image.pixels[loc] == color(0)) { //if black
//        int rastaMatrix[][] = new int[3][3];
//        for (int i = -1; i <= 1; i++) 
//          for (int j = -1; j <= 1; j++) 
//            if (image.pixels[loc + i + j*image.width] == color(0)) rastaMatrix[i+1][j+1] = 1;
//            else rastaMatrix[i+1][j+1] = 0;

//        boolean judgeFlag= false;
//        for (int[][] tempFilter : edgefilter) 
//          if (judgeRastaMatrix(rastaMatrix, tempFilter, 3)) 
//            judgeFlag = true;
//        for (int[][] tempFilter : branchfilter) 
//          if (judgeRastaMatrix(rastaMatrix, tempFilter, 3)) 
//            judgeFlag = true;


//        if (judgeFlag) {
//          image.pixels[loc] = color(255, 0, 0);
//          returnEdges.add(new PVector(x, y));
//        } else {
//          image.pixels[loc] = color(0);
//        }
//      }
//    }
//  }
//  return returnEdges;
//}


//boolean judgeConnectivity(PImage image, PVector start, PVector end) {     //judge edge branch
//  boolean returnFlag = false;
//  image.loadPixels(); 

//  PVector dv = PVector.sub(end, start);

//  float a = dv.y;
//  float b = -dv.x;
//  float c = dv.x * start.y - dv.y * start.x;     

//  int picCnt = 0;
//  int lineCnt = 0;

//  for (int j = (int)min(start.y, end.y); j <= (int)max(start.y, end.y); j++) {
//    for (int i = (int)min(start.x, end.x); i <= (int)max(start.x, end.x); i++) {
//      if (getDistBetweenLinePoint(dv, start, new PVector(i, j)) <= 1) {
//        //if (abs(a * i + b * j + c) <= 100) {
//        lineCnt++;
//        int loc = i + j*image.width;
//        if (image.pixels[loc] == color(0)) picCnt++; //if black

//        //fill(0, 0, 255, 200);
//        //rect(i * width/image.width, j * height/image.height, (float)width/image.width, (float)height/image.height);
//      }
//    }
//  }

//  println(start + " " + end + " " + picCnt + " " + lineCnt + " " + (float)picCnt / lineCnt);

//  if ((float)picCnt / lineCnt > 0.3) returnFlag = true;

//  return returnFlag;
//}

//float getDistBetweenLinePoint(PVector dv, PVector i, PVector p) { //direction vector, the point where the direction vector pass, the point where the directin 
//  //calculate parameter ax + by + c = 0
//  float a = dv.y;
//  float b = -dv.x;
//  float c = dv.x * i.y - dv.y * i.x;

//  //calculate dist
//  return abs(a * p.x + b * p.y + c) / sqrt(pow(a, 2) + pow(b, 2));
//}