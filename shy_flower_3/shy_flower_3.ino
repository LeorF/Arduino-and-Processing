#include <Servo.h>

int current = 0;
int prev = 0;
int filteredDiff = 0;
const int micPin = A0;
const int servoPin = 5;
const int servoPause = 500;

const int slide = 5;

Servo toyServo;

void setup() 
{
    Serial.begin(9600); 
    toyServo.attach(servoPin);
    toyServo.write(0);
}

void loop() 
{
        current = analogRead(micPin);


        int absDiff = abs(current-prev);
        // globalValue = globalValue + (newReading - globalValue) / sensitivity)
        filteredDiff = filteredDiff + ( ( absDiff - filteredDiff ) / slide );
        
        Serial.println(filteredDiff);
        
        
        prev = current;
        
        if (filteredDiff > 300)
        {
          loud();
        }
        
        else if (filteredDiff >= 100 && filteredDiff <= 300)
        {
          quiet();
        }
        
        delay(servoPause);
}

void loud()
{
  toyServo.write(180);
}

void quiet()
{
  toyServo.write(0);
}

