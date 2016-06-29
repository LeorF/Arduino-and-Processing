const int sensorPin =  10;      // the number of the sensor pin

void setup() 
{
  pinMode(sensorPin, INPUT_PULLUP);  
}

void loop() 
{
  if (digitalRead(sensorPin) == LOW)
  {
    Serial.println("hi");
  }
}
