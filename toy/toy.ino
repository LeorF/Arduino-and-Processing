#include <Servo.h>

int servoPin = 5;
int fsrPin = A0;
Servo toyServo;

void setup() 
{
  Serial.begin(9600);
  toyServo.attach(servoPin);
}

void loop()
{
  int servoVal = analogRead(fsrPin); 
  Serial.println(servoVal); 
  int angle = map(servoVal, 0, 500, 0, 179);
  toyServo.write(angle);

 }
