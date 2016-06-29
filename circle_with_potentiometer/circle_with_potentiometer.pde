import processing.serial.*;

Serial arduinoPort;
int potVal;

void setup()
{
  size(320, 240);
  background(0, 255, 255);
  
  println(Serial.list());
  
  String portName = Serial.list()[0];
  arduinoPort = new Serial(this, portName, 9600);
}

void draw()
{
  byte[] inputBuffer = new byte[7];
  while (arduinoPort.available() >0)
  {
    inputBuffer = arduinoPort.readBytes();
    arduinoPort.readBytes(inputBuffer);
    
    if (inputBuffer != null)
    {
      String myString = new String(inputBuffer);
      potVal = inputBuffer[0];
      println(potVal);
    }
  }
  
  background(255, 255, 0);
  fill(255, 0, 0);
  ellipse(width/2, height/2, potVal*2, potVal*2);
}