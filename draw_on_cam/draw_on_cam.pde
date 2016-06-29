//Code referenced:
//Code to draw on video adapted from here: https://processing.org/discourse/beta/num_1191601240.html
//Color-tracking code: http://www.learningprocessing.com/examples/chapter-16/example-16-11/

import processing.video.*;

Capture video;
PGraphics frame;
// A variable for the color we are searching for.
color trackColor;

void setup() {
 size(640, 480);  
 video = new Capture(this, width, height, 30);
 video.start();
 smooth();
 frame = createGraphics(width, height);
 trackColor = color(0,0,0);
 smooth();
}

void draw() {
 if (video.available()) 
 {
   video.read();  
 } 

  // Before we begin searching, the "world record" for closest color is set to a high number that is easy for the first pixel to beat.
  float worldRecord = 500; 

  // XY coordinate of closest color
  int closestX = 0;
  int closestY = 0;

  // Begin loop to walk through every pixel
  for (int x = 0; x < video.width; x ++ ) {
    for (int y = 0; y < video.height; y ++ ) {
      int loc = x + y*video.width;
      // What is current color
      color currentColor = video.pixels[loc];
      float r1 = red(currentColor);
      float g1 = green(currentColor);
      float b1 = blue(currentColor);
      float r2 = red(trackColor);
      float g2 = green(trackColor);
      float b2 = blue(trackColor);

      // Using euclidean distance to compare colors
      float d = dist(r1,g1,b1,r2,g2,b2); // We are using the dist( ) function to compare the current color with the color we are tracking.

      // If current color is more similar to tracked color than
      // closest color, save current location and current difference
      if (d < worldRecord) {
        worldRecord = d;
        closestX = x;
        closestY = y;
        print(closestX);
        print(closestY);
      }
    }
  }

 image(video, 0, 0, width, height);  

 print("nice");
 frame.beginDraw();
 frame.noStroke();
 frame.fill(trackColor);
 frame.ellipse(closestX, closestY, 15, 15);
 print("nice");
 frame.endDraw();
 image(frame, 0, 0);
 print("cool");
 image(frame, 0, 0);
 
}

void mousePressed() 
{
  // Save color where the mouse is clicked in trackColor variable
  int loc = mouseX + mouseY*video.width;
  trackColor = video.pixels[loc];
}
