const int ledPin = 5;
const int fsrPin = A0;

void setup()
{
  Serial.begin(9600);
  pinMode(ledPin, OUTPUT);
}

void loop()
{
  int fsrVal = analogRead(fsrPin);
  int ledVal = map(fsrVal, 0, 1023, 0, 255);
  Serial.println((String)fsrVal + "->" + (String)ledVal);
  analogWrite(ledPin, ledVal);
}
