import processing.serial.*;
Serial myPort;
int[] storage;

void setup()
{
  size(500, 500);
  println(Serial.list());
  myPort = new Serial(this, Serial.list()[0], 9600);
  storage = new int[100];
}

void draw()
{
  background(255, 0, 255);
  if (myPort.available()>0)
  {
    int val = myPort.read();
    for (int i = storage.length-1; i > 0; i--)
    {
      storage[i] = storage[i-1];
    }
    storage[0] = val;
  }
  for (int i = 0; i < storage.length; i++)
  {
    float barWidth = width/storage.length;
    float x = barWidth * i;
    float barHeight = map(storage[i], 0, 255, 0, height);
    float y = height - barHeight;
    fill(storage[i], storage[i], storage[i]);
    noStroke();
    rect(x, y, barWidth, barHeight);
  }
}


