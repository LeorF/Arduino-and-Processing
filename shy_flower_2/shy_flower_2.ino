#include <Servo.h>

int currentValue;
int maxValue;
int minValue;
unsigned long timer;
int sampleSpan = 5; // Amount in milliseconds to sample data
int volume; // this roughly goes from 0 to 700
int servoPin = 5;

Servo toyServo;

void setup() 
{
    Serial.begin(9600);
    toyServo.attach(servoPin);
    pinMode(servoPin, OUTPUT); 
    resetValues();
}

void loop() 
{
    currentValue = analogRead(A0);

    if (currentValue < minValue) {
        minValue = currentValue;
    } 
    if (currentValue > maxValue) {
        maxValue = currentValue;
    }

    if (millis() - timer >= sampleSpan) {
        volume = maxValue - minValue;

        Serial.println(volume);
        
        if (volume > 400)
        {
          for (int i = 0; i <= 180; i++)
          {
            toyServo.write(i);
            delay(5);
          }
        }
        
        else
        {
          toyServo.write(0);
        }

        resetValues();
    }
}

void resetValues()
{
    maxValue = 0;
    minValue = 1024;
    timer = millis(); 
}
