void setup()
{
  size(400, 400);
  background(127, 255, 0);
}

int i = 400;

void draw()
{
  if(i > 0)
  {
    if(i%2 == 0)
    {
      stroke(255, 255, 255);
      fill(255, 255, 255);
    }
    else
    {
      stroke(0, 0, 0);
      fill(0, 0, 0);
     }
    delay(600);
    ellipse(200, 200, i, i);
    i = i-35;
  }
}

