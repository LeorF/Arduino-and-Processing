
#include <Servo.h>

const int micPin = A0;
const int ledPin = A1;
//const int servoPause = 45;

Servo toyServo;

void setup()
{
  toyServo.attach(servoPin);
}

void loop()
{
  int micVal = analogRead(micPin);
  
  int volume = abs(micVal - 760);
  
  int servoAngle = map(micVal, 0, 1023, 0, 180);
  
  toyServo.write(servoAngle);
  
  delay(servoPause);
}

