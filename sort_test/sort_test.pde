PImage pic;
int redPlace = 0;
int greenPlace = width/3;
int bluePlace = 2*width/3;
int redBarHeight = 0;
int greenBarHeight = 0;
int blueBarHeight = 0;


void setup()
{
  pic = loadImage("character.png");
  size(500, 500);
}

void draw()
{
  splitColors();
  pic.updatePixels();
  image(pic, 0, 0);
}

void splitColors()
{
  for(int index = 0; index < pic.pixels.length-1; index++)
  {
    if(pic.pixels[index].red() > pic.pixels[index].green() && pic.pixels[index].red() > pic.pixels[index].blue())
    {
      print("This pixel is redder!");
      //if pixel is redder, put it into the first third of the screen. etc.
    }
    if(pic.pixels[index].green() > pic.pixels[index].red() && pic.pixels[index].green() > pic.pixels[index].blue())
    {
      print("This pixel is greener!");
    }
    if(pic.pixels[index].blue() > pic.pixels[index].green() && pic.pixels[index].blue() > pic.pixels[index].red())
    {
      print("This pixel is bluer!");
    }
  }
}
