const int transistorBasePin = 5;

void setup()
{
  Serial.begin(9600);
  pinMode(transistorBasePin, OUTPUT);
}

void loop()
{
  digitalWrite(transistorBasePin, HIGH);
  delay(100);
  digitalWrite(transistorBasePin, LOW);
  delay(100);
}
