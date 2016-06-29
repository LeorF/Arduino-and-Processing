const int transistorBasePin = 5;

void setup()
{
  Serial.begin(9600);
  pinMode(transistorBasePin, OUTPUT);
}

void loop()
{
  for (int i=0; i<=255; i++)
  {
    analogWrite(transistorBasePin, i);
    delay(5);
  }
  for (int i=255; i>=0; i--)
  {
    analogWrite(transistorBasePin, i);
    delay(5);
  }
}
