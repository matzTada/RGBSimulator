//2016/12/28 TadaMatz
//extract vector information from white-black map

PImage img;

void setup() {
  size(400, 400);
  img = loadImage("data/map.png");
  surface.setResizable(true);

  loadPixels(); 
  // Since we are going to access the image's pixels too  
  img.loadPixels(); 
  for (int y = 0; y < img.height; y++) {
    for (int x = 0; x < img.width; x++) {
      int loc = x + y*img.width;

      // The functions red(), green(), and blue() pull out the 3 color components from a pixel.
      float r = red(img.pixels[loc]);
      float g = green(img.pixels[loc]);
      float b = blue(img.pixels[loc]);

      // Image Processing would go here
      // If we were to change the RGB values, we would do it here, 
      // before setting the pixel in the display window.

      //// Set the display pixel to the image pixel
      //pixels[loc] =  color(r, g, b);

      char tempChar = ' ';
      if (r+g+b == 0) { 
        tempChar = '1'; //white
        img.pixels[loc] = color(255, 255, 255);
      }

      print(tempChar + " ");
    } 
    println("");
  }
  updatePixels();

  for (int x = 0; x < img.width; x++) print("--");
  println("");


  loadPixels(); 
  // Since we are going to access the image's pixels too  
  img.loadPixels(); 
  for (int y = 0; y < img.height; y++) {
    for (int x = 0; x < img.width; x++) {
      int loc = x + y*img.width;

      // The functions red(), green(), and blue() pull out the 3 color components from a pixel.
      float r = red(img.pixels[loc]);
      float g = green(img.pixels[loc]);
      float b = blue(img.pixels[loc]);

      // Image Processing would go here
      // If we were to change the RGB values, we would do it here, 
      // before setting the pixel in the display window.

      //// Set the display pixel to the image pixel
      //pixels[loc] =  color(r, g, b);

      char tempChar = ' ';
      if (r+g+b == 0) { 
        tempChar = '1'; //white
        img.pixels[loc] = color(255, 255, 255);
      }

      print(tempChar + " ");
    }
    println("");
  }
  updatePixels();
}

void draw() {
  background(0);
  image(img, 0, 0, width, height);
}    