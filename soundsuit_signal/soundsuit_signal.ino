#include <Wire.h>
#include <Adafruit_Sensor.h>
#include <Adafruit_LSM303.h>
#include "TSL2561.h"

Adafruit_LSM303 lsm;
TSL2561 tsl(TSL2561_ADDR_FLOAT); 
const int shakePin =  10;

void setup() 
{
  Serial.begin(9600);

 // pinMode(shakePin, INPUT_PULLUP); 
  // Try to initialise and warn if we couldn't detect the chip
  if (!lsm.begin())
  {
    Serial.println("Oops ... unable to initialize the LSM303. Check your wiring!");
    while (1);
  }
  else if (!tsl.begin())
  {
    Serial.println("No sensor?");
    while (1); 
  }
  // You can change the gain on the fly, to adapt to brighter/dimmer light situations
  //tsl.setGain(TSL2561_GAIN_0X);         // set no gain (for bright situtations)
  tsl.setGain(TSL2561_GAIN_16X);      // set 16x gain (for dim situations)

  // Changing the integration time gives you a longer time over which to sense light
  // longer timelines are slower, but are good in very low light situtations!
  tsl.setTiming(TSL2561_INTEGRATIONTIME_13MS);  // shortest integration time (bright light)
  //tsl.setTiming(TSL2561_INTEGRATIONTIME_101MS);  // medium integration time (medium light)
  //tsl.setTiming(TSL2561_INTEGRATIONTIME_402MS);  // longest integration time (dim light)
}



void loop() 
{/*
  if (digitalRead(shakePin) == LOW)
  {
    Serial.print("yes ");
  }
  else
  {
    Serial.print("no ");
  }
  */
  lsm.read();
  uint16_t light = tsl.getLuminosity(TSL2561_FULLSPECTRUM);
  int yPos = (int)lsm.magData.y;
  //Serial.print("Y: "); 
  Serial.print(yPos);         Serial.print(" ");
  //Serial.print("L: "); 
  Serial.print(light); //Serial.print(" ");
  Serial.print("\n");
  delay(100);
}
