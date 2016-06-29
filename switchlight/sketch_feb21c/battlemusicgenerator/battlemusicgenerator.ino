const int speakerPin = 5;
const int photoPin = A0;
const int potPin = A1;

void setup()
{
 // Serial.begin(9600);
  pinMode(speakerPin, OUTPUT);
}

void loop()
{
  int photoVal = analogRead(photoPin);
  int potVal = analogRead(potPin);
  map(photoVal, 0, 1023, 100, 1500);
  map(potVal, 0, 1023, 0, 500);
  tone(speakerPin, photoVal);
  delay(potVal);
}
