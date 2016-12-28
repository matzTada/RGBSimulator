//2016/12/28 TadaMatz
//extract vector information from white-black map
//based on tutorial https://processing.org/tutorials/pixels/

PImage img;

void setup() {
  size(800, 800);
  img = loadImage("data/map.png");
  surface.setResizable(true);

  initializeFilter();

  boolean tsub1Flag = true;
  while (tsub1Flag) {
    tsub1Flag = thinningSub1(img);
    thinningSub2(img);
  }
}

void draw() {
  background(0);
  image(img, 0, 0, width, height);
}    