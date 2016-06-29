int sensePin = A0;

void setup()
{
  Serial.begin(9600);
}

void loop()
{
  Serial.write(analogRead(sensePin)/4);
  delay(30);
}
