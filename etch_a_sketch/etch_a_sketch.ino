//serial output of a potentiometer reading

const int potPin = A0;
//const int fsrPin = A1;

void setup()
{
  Serial.begin(9600);
}

void loop()
{
  int potVal = analogRead(potPin);
  potVal = map(potVal, 0, 1023, 127, 0);
 //int fsrVal = analogRead(fsrPin);
 //fsrVal = map(fsrVal, 0, 1023, 127, 0);
  Serial.print(potVal);
  //Serial.print(",");
 // Serial.print(fsrVal);
 // Serial.print("*")
  delay(20);
}
