#include <Servo.h>

const int potPin = 0;
const int servoPin = 5;
const int servoPause = 45;

Servo toyServo;

void setup()
{
  toyServo.attach(servoPin);
}

void loop()
{
  int potVal = analogRead(potPin);
  int servoAngle = map(potVal, 0, 1023, 0, 180);
  toyServo.write(servoAngle);
  delay(servoPause);
}
