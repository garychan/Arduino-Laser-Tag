/* This is uploaded to a second arduino that will emulate the 
* input from the UART the same as using serial terminal
* would in the main sketch. THIS SKETCH IS OPTIONAL.
* I just *happen* to have a second arduino so I don't have
* to manually enter in values from my PC.
*/

#include "WProgram.h"
void setup();
void loop();
void sendData();
char playerCodes[] = {"0123456789abcdef"};
int randNumber1;
int randomNumber2;

void setup() 
{
 Serial.begin(9600);
 randomSeed(analogRead(0));
 loop(); 
}

void loop() 
{
 delay(5000);
 //give player names:
  Serial.print("VincentAllisonAlfonseAbigaleAdelardAntonioBarnettDelaneyHerbertGarnettPrestonMadonnaSigmundMartinaZacharyVanessa");
 
 
 //now send hits at random intervals
 delay(15000);
 sendData();
   
}

void sendData()
{    
  randNumber1 = random(0,100);
   if (randNumber1 == 7) 
   {
    randomNumber2 = random(0, 15);
    Serial.print(playerCodes[randomNumber2]);
    randNumber1 = 0;
   }
   delay(100);
   sendData();
}

int main(void)
{
	init();

	setup();
    
	for (;;)
		loop();
        
	return 0;
}

