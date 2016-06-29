import processing.video.*;

  int curPlayerSizeX = 0;
  int curPlayerLocX = 0;
  int curPlayerLocY = 0;
  boolean collision = false;
  boolean gameLose = false;
  player player1 = new player();
  ball[] balls = new ball[5];
  healing healBall = new healing();
  int hp = 700;
  int score = 0;
  int highScore = 0;
  boolean healCollision = false;
  int actualSecs = 0; //actual seconds elapsed since start
  int actualMins; //actual minutes elapsed since start
  int startSec = 0; //used to reset seconds shown on screen to 0
  int holdSec = 0;
  int maxSec = 0;
  int scrnSecs; //seconds displayed on screen (will be 0-60)
  int restartSecs=0; //number of seconds elapsed at last click or 60 sec interval
  int framerate = 40;
  double secondsCounter = 0;
  PImage character;
  PImage health;
  PImage bomb;
  // Variable for capture device
  Capture video;
  // A variable for the color we are searching for.
  color trackColor; 

void setup() 
{
    frameRate(framerate);
    size(640,480);
    background(255,255,255);
    for (int i=0; i<5; i++) 
    { //Creates 5 balls
      balls[i] = new ball();
    }
    for (int j = 0; j<5; j++) 
    { //Sets random starting locations for the balls
      balls[j].setXloc();
      balls[j].setYloc();
      balls[j].setXdir();
      balls[j].setYdir();
    }
    healBall.setLocX();
    healBall.setLocY();
    
    String[] cameras = Capture.list();
  //Camera Setup
  if (cameras.length == 0) 
  {
    println("There are no cameras available for capture.");
    exit();
  } 
  else 
  {
    println("Available cameras:");
    for (int i = 0; i < cameras.length; i++) 
    {
      println(cameras[i]);
    }
    
    // The camera can be initialized directly using an 
    // element from the array returned by list():
    video = new Capture(this, cameras[0]);
    video.start(); 
  }
  // Start off tracking for green
  trackColor = color(0,255,0);
  smooth();
}

void draw()
{
    mousePressed();
    cam();
    // Capture and display the video
    if (video.available())
    {
      video.read();
    }
    video.loadPixels();
    imageMode(CORNER);
    image(video,0,0);
    textSize(12);
    if (gameLose == false)
    {
      for (int i=0; i<5; i++){
        curPlayerSizeX = player1.xSizeGet();
        curPlayerLocX = player1.xLocGet();
        curPlayerLocY = player1.yLocGet();
        collision = balls[i].checkCollision(curPlayerSizeX, curPlayerLocX, curPlayerLocY); 
        healCollision = healBall.checkCollision(curPlayerSizeX, curPlayerLocX, curPlayerLocY);
        if (collision == true)
        { 
          hp = hp-20;
        }
        else if (healCollision == true) 
        {
          healBall.setLocX();
          healBall.setLocY();
          score++;
          if (hp <= 700-healBall.healingGet()) 
          {
            hp = hp + healBall.healingGet();
          }
          healCollision = false;
        }
        else 
        { //If the player did not hit a ball, then the game continues playing
         
            for (int l=0; l<5; l++)
            {
              balls[l].move();           //Uses the ball's method to move the ball
            }

            for (int j=0; j<5; j++)
            { //Draws the balls
              fill(175, 23, 23);
              ellipse(balls[j].xLocGet(),balls[j].yLocGet(),balls[j].xSizeGet(),balls[j].ySizeGet());    
            }
            for (int h=0; h<5; h++)
            { //Bounces the balls off the walls
              balls[h].bounce(480, 640);
            }
          player1.setXLoc(mouseX);   //Gets the mouse coordinates, and ascribes it to the player object
          player1.setYLoc(mouseY);
          fill(0, 255, 0);   //Draws the player object
          ellipse(player1.xLocGet(),player1.yLocGet(), 20, 20);
          fill(0,0,255);
          ellipse(healBall.xLocGet(),healBall.yLocGet(),healBall.ballRadiusGet(),healBall.ballRadiusGet());
        }
      }
      // print clock
      secondsCounter += 1D/framerate;   //add to seconds counter 
      println(secondsCounter);
      fill(0);
      text(nf((int) secondsCounter, 2), 20, 40);
      // end of clock
    }
    
    fill(255,0,0);
    rect(10,10,hp,10);
    if (hp <= 0) 
    {
      gameLose = true; 
    }
    fill(0);
    text(hp, 20, 20, 0);
    text(score, 20, 30, 0);
    
    if (gameLose == true)
    { //When the game is lost, it goes and prints the game over screen
      background(0);
      fill(255);
      textAlign(CENTER);
      if (score > highScore) 
      {
        highScore = score;
      }
      textSize(70);
      text ("YOU DIED \n", width/2, 300, 0);
      textSize(15);
      text ("Your Score: " + score + " High Score = " + highScore + "\n Press any key to play again! \n", width/2, 400, 0);
      final double setTime = secondsCounter;
      holdSec = (int)setTime;
      if (holdSec > maxSec) 
      {
        maxSec = holdSec;
      }
      text ("You Lived: " + holdSec + " Seconds \n Longest Time Lived: " + maxSec + " Seconds", width/2, 450, 0);
      
    }
    
    
  }

  void keyPressed() 
  { //If the person presses any key...
    secondsCounter = 0;
    actualSecs = (millis() / 1000);
    println("Changing actualSecs to " + actualSecs);
    gameLose = false; //...the lose state is reversed so the game can be played again
    for (int j = 0; j<5; j++) 
    { //Because we're playing the game again, we need to reset the ball locations
      balls[j].setXloc();
      balls[j].setYloc();
      balls[j].setXdir();
      balls[j].setYdir();
    }
    hp = 700;
    score = 0; 
  }
  




//BALL OBJECT------------------------------------------------------------------//


class ball {

  int xBallSize, yBallSize, xBallLoc, yBallLoc, xBallDir, yBallDir, ballRadius;
  
  ball(){
    xBallSize = 40;
    yBallSize = 40;
    xBallDir = 1;
    yBallDir = 1;
    xBallLoc = 20;
    yBallLoc = 50;
    ballRadius = xBallSize/2;
  }

  
  //Methods to get the various attributes of the ball object into the main
  int xSizeGet(){
    return xBallSize;
  }
  int ySizeGet(){
    return yBallSize;
  }
  int xDirGet(){
    return xBallDir;
  }
  int yDirGet(){
    return yBallDir;
  }
  int xLocGet(){
    return xBallLoc;
  }
  int yLocGet(){
    return yBallLoc;
  }
  
  
  //Methods to set various aspects of the ball object depending on what the main wants it to do
  int setXloc(){
    return xBallLoc = (int) (Math.random()*500+1);
  }
  double setYloc(){
    return yBallLoc = (int) (Math.random()*500+1);
  }
  double setXdir(){ //Random mult by 1 or -1 to set x direction  --> how to generate only either one of those?
    return xBallDir;
  }
  double setYdir(){ //Random mult by 1 or -1 to set a y direction
    return yBallDir;
  }
  
  
  //Method to move the ball object when it's being animated, shifts the x & y locations
  void move(){
    xBallLoc += 2*xBallDir;
    yBallLoc += 1*yBallDir;
  }
  
  
  //Method to bounce the ball off of the walls
  void bounce(int NROWS, int NCOLS){
    if ((xBallLoc+(xBallSize/2) >= NCOLS)){ //If it hits the right wall, it bounces off towards the left
      xBallDir = -1;
    }
    if ((xBallLoc <= (xBallSize/2))){ //If it hits the left wall, it bounces off to the right
      xBallDir = 1;
    }
    if ((yBallLoc+(yBallSize/2) >= NROWS)){
      yBallDir = -1;
    }
    if ((yBallLoc <= (yBallSize/2))){
      yBallDir = 1;
    }
  }
  
  boolean checkCollision(int curPlayerSizeX,int curPlayerLocX,int curPlayerLocY) {
    boolean collision = false;
    int playerRadius = curPlayerSizeX/2;
    float xDiff = xBallLoc - curPlayerLocX;
    float yDiff = yBallLoc - curPlayerLocY;
    float dist = (float) Math.sqrt((xDiff*xDiff) + (yDiff*yDiff));
    if (ballRadius+playerRadius > dist){
      collision = true;
    }
    return collision;
  }
  
  
  //Method to get the ball's distance from the player object
  float getDist(float curPlayerLocX, float curPlayerLocY){
    float xDiff = xBallLoc - curPlayerLocX;
    float yDiff = yBallLoc - curPlayerLocY;
    float dist = (float) Math.sqrt((xDiff*xDiff) + (yDiff*yDiff));
    return dist;
  }
  
  
}

//PLAYER OBJECT------------------------------------------------------------------//

class player {
  
  int xPlaySize, yPlaySize, xPlayDir, yPlayDir, xPlayLoc, yPlayLoc, moveDist;  
  //All private because...private is always nice!
  
  player(){
    xPlaySize = 40;
    yPlaySize = 40;
    xPlayDir = 1;
    yPlayDir = 1;
    xPlayLoc = 100;
    yPlayLoc = 100;
    moveDist = 2;
  }
  
  
  //Methods to get the various attributes of the player object
  int xSizeGet(){
    return xPlaySize;
  }
  int ySizeGet(){
    return yPlaySize;
  }
  int xDirGet(){
    return xPlayDir;
  }
  int yDirGet(){
    return yPlayDir;
  }
  int xLocGet(){
    return xPlayLoc;
  }
  int yLocGet(){
    return yPlayLoc;
  }
  
  
  //Sets the location of the player to where the mouse cursor is
  void setXLoc(int mouseX){
    xPlayLoc = mouseX;
  }
  void setYLoc(int mouseY){
    yPlayLoc = mouseY;
  }
   
}


//HEALING BALL OBJECT---------------------------------//

class healing {

  int xDir, yDir, xLoc, yLoc, xSize, ySize, ballRadius, healing;
  
  
  healing(){
    xDir = 1;
    yDir = 1;
    xLoc = 20;
    yLoc = 50;
    xSize = 40;
    ySize = 40;
    ballRadius = xSize/2;
    healing = 20;
  }
  
  int xDirGet(){
    return xDir;
  }
  int yDirGet(){
    return yDir;
  }
  int xLocGet(){
    return xLoc;
  }
  int yLocGet(){
    return yLoc;
  }
  int xSizeGet(){
    return xSize;
  }
  int ySizeGet(){
    return ySize;
  }
  int ballRadiusGet(){
    return ballRadius;
  }
  int healingGet() {
    return healing;
  }
  
    //Methods to set various aspects of the ball object depending on what the main wants it to do
  double setLocX(){
    return xLoc = (int) (Math.random()*400+1);
  }
  double setLocY(){
    return yLoc = (int) (Math.random()*400+1);
  }

  boolean checkCollision(int curPlayerSizeX,int curPlayerLocX,int curPlayerLocY) {
    boolean collision = false;
    int playerRadius = curPlayerSizeX/2;
    float xDiff = xLoc - curPlayerLocX;
    float yDiff = yLoc - curPlayerLocY;
    float dist = (float) Math.sqrt((xDiff*xDiff) + (yDiff*yDiff));
    if (ballRadius+playerRadius > dist){
      collision = true;
    }
    return collision;
  }
    //Method to get the ball's distance from the player object
  float getDist(float curPlayerLocX, float curPlayerLocY){
    float xDiff = xLoc - curPlayerLocX;
    float yDiff = yLoc - curPlayerLocY;
    float dist = (float) Math.sqrt((xDiff*xDiff) + (yDiff*yDiff));
    return dist;
  }
}
  
void cam() 
{
  // Capture and display the video
  if (video.available()) 
  {
    video.read();
  }
  video.loadPixels();
  image(video,0,0);

  // Before we begin searching, the "world record" for closest color is set to a high number that is easy for the first pixel to beat.
  float worldRecord = 500; 

  // XY coordinate of closest color
  int closestX = 0;
  int closestY = 0;

  // Begin loop to walk through every pixel
  for (int x = 0; x < video.width; x ++ ) 
  {
    for (int y = 0; y < video.height; y ++ ) 
    {
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
      }
    }
  }

  // We only consider the color found if its color distance is less than 10. 
  // This threshold of 10 is arbitrary and you can adjust this number depending on how accurate you require the tracking to be.
  if (worldRecord < 100) 
  { 
    // Draw a circle at the tracked pixel
    fill(trackColor);
    strokeWeight(4.0);
    stroke(0);
    ellipse(closestX,closestY,16,16);
  }
}

void mousePressed() 
{
  // Save color where the mouse is clicked in trackColor variable
  int loc = mouseX + mouseY*video.width;
  trackColor = video.pixels[loc];
}

  
  

