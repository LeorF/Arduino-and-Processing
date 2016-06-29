//http://www.magicandlove.com/blog/2014/07/29/processing-test-with-the-pgraphics/

import processing.video.*;
 
PGraphics pg;
Capture cap;
 
void setup() {
  size(640, 480);
 
  cap = new Capture(this, width, height);
  cap.start();
 
  pg = createGraphics(width, height);
  pg.beginDraw();
  pg.background(0);
  pg.smooth();
  pg.noStroke();
  pg.fill(255);
  pg.endDraw();
}
 
void draw() {
  if (!cap.available()) 
    return;
  cap.read();
  background(0);
  pg.beginDraw();
  if (mousePressed) 
    pg.ellipse(mouseX, mouseY, 40, 40);
  pg.endDraw();
  cap.mask(pg);
  image(cap, 0, 0);
}
