int arraySize=20;
float[] testArray;
String[] csv;

void setup()
{
  testArray = new float[arraySize];
  size(600, 400);
  for (int i=0; i<arraySize; i++)
  {
    testArray[i] = random(1);
  }
  csv = loadStrings("baseballdata.txt");
  println(csv);
  //split(",");
}

void draw()
{
  background(0, 255, 0);
  float distance = width/testArray.length;
  for (int i=1; i < testArray.length; i++)
  {
    float x = distance*i+distance/2;
    float y = testArray[i]*height;
    float prevY = testArray[i-1]*height;
    line(x, y, x-distance, prevY);
    prevY = y;
  }
  
   for (int i=0; i < testArray.length; i++)
  {
    float x = distance*i+distance/2;
    float y = testArray[i]*height;
    float ellipseSize = distance;
    ellipse(x, y, ellipseSize, ellipseSize);

  }
}


