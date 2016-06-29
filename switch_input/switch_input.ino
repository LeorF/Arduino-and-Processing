const int switchPin = 3;

void setup()
{
  pinMode(switchPin, INPUT);
  Serial.begin(9600);
}

void loop()
{
  int switchVal = digitalRead(switchPin);
/*  if (switchVal == HIGH)
  {
    Serial.write(1);
    Serial.println("1");
  }
  else
  {
    Serial.write(0);
    Serial.println("0");
  }
  
  //Serial.write(1);

  delay(20);
  */
  Serial.write(0);
  Serial.println("0");
  delay(10000);
  Serial.write(1);
  Serial.println("1");
  delay(500);
}
