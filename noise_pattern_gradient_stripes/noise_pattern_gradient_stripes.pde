//draw uneven horizontal lines
int linestart = 0;
int y = 0;
int x = 0;
void setup()
{
  size(400,400);
  background(255, 0, 255);
}

void draw()
{
  stroke(0, x, y);
  for (int current=0; current<400; current++)
  {
    int stagger = (int)random(5);
    point(current, linestart+stagger);
  }
  linestart = linestart+15;
  y = y+10;
  x = x+5;
  delay(20);
}
