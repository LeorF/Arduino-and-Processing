import processing.serial.*;
Serial arduinoPort;
int potVal;
int fsrVal;
int diameter;

void setup()
{
  size(500, 500);
  background(255, 0, 255);
  diameter = 50; 
  int i = 0;
  while (Serial.list()[i] != null)
  {
    println("port:" + Serial.list()[i]);
    i++;
  }
  String port = Serial.list()[0];
  arduinoPort = new Serial(this, port, 9600);
  arduinoPort.write(65);
}

void draw()
{
  while (arduinoPort.available() > 0)
  {
    String input = arduinoPort.readStringUntil('*');
    if (input != null)
    {
      println("Input: " + input);
      int[] values = int(splitTokens(input,",*"));
      potVal = values[0];
      fsrVal = values[1];
    }
    arduinoPort.write(65);
  }
  fill(255, 0, 0);
  ellipse((potVal * 4), (fsrVal * 4), diameter, diameter);
 println(potVal + " " + fsrVal); 
}
