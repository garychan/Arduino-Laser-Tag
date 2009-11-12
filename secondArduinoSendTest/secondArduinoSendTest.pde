/* This is uploaded to a second arduino that will emulate the 
* input from the UART the same as using serial terminal
* would in the main sketch. THIS SKETCH IS OPTIONAL.
* I just *happen* to have a second arduino so I don't have
* to manually enter in values from my PC.
*/

char playerCodes[] = {"0123456789abcdef"};
int triggerPin = 2;
int randomNumber2;

void setup() 
{
 Serial.begin(9600);
 pinMode(triggerPin, INPUT);
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
  
   if (digitalRead(triggerPin) == HIGH) 
   {
    randomNumber2 = random(0, 15);
    Serial.print(playerCodes[randomNumber2]);
   }
   delay(100);
   sendData();
}
