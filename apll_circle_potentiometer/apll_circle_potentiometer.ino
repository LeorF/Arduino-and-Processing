const int potPin = A0;

void setup()
{
  Serial.begin(9600);
}

void loop()
{
  int potVal = analogRead(potVal);
  potVal = map(potVal, 0, 1023, 0, 255);
  Serial.write(potVal);
  Serial.println(potVal);
  delay(20);
}
