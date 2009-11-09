/* ALT v1
* 
* Okay, so basically we are going offload the carrier wave generation and the initial I/O
* to an external circuit. This elimates the problem of hacking in bit-banging on the arduino
* that could better use the processing time. The carrier wave can be a 555 stable ckt...
* 
* Instead, the arduino will handle LUTs of the user ID's of the game (that will be hashed and
* uploaded to the system before each game. Also, it will keep track of the number of times
* the user was hit and from whom.
* 
* The arduino will also send the pulses of data that will be used when shooting the gun. This
* will contain who is shooting the gun as a one-byte hash.
* 
* An external UART circuit will act as a buffer for recieving data via the IR sensors on the player.
* This massively simplifies the amount of hacking we have to do on the arduino, and also
* because the UART will contain a buffer, we don't have to worry about the paralellism problem
* of what happens when you shoot and get hit at the same time. :)
*
*/


char inBit;
int sendDelay = 200; // so you can't constantly fire your gun
int triggerPin = 2;
const int MAX_PLAYERS = 16; // if 4-bit player code. Leaving 4-bits for error checksumming if 1 byte code.
char* playerNames[] = {"PLAYER0", "PLAYER1", "PLAYER2", "PLAYER3", "PLAYER4", "PLAYER5", "PLAYER6", "PLAYER7", 
                       "PLAYER8", "PLAYER9", "PLAYERA", "PLAYERB", "PLAYERC", "PLAYERD", "PLAYERE", "PLAYERF"};
char* uglyNameFix = "INVALID!";


void setup () {
 pinMode(triggerPin, INPUT);
 Serial.begin(9600); 
 flushSerialIn();
 delay(500);
 setBrightnessFull();
 
 populatePlayerTable();
 flushSerialIn();
 clearLCD();
 delay(1000);
 selectLineOne();
 Serial.print("Starting Game...");
 delay(1000);
 clearLCD();
 setBrightnessFull();
 flushSerialIn(); 
 selectLineOne();
 delay(1000);
 loop();
}

void loop() {
  if (Serial.available() > 0) {
    readInHit();
    
    selectLineOne();
    Serial.print("Input: ");
    Serial.print(inBit);
    Serial.print("        ");
    
    selectLineTwo();
    Serial.print("Hit by: ");
    Serial.print( playerNameString() );
    delay(5000);
    clearLCD();    
    flushSerialIn();
  }
  
  if ((digitalRead(triggerPin) == HIGH) && (sendDelay > 200))
    sendMyInfo();
  
  selectLineOne();
  Serial.print("No Hit...       ");
  selectLineTwo();
  Serial.print("SendDelay:");
  Serial.print(sendDelay);
  delay(10);
  
  if (sendDelay == 32760) // prevent int overflow.
    sendDelay = 32760;
  else 
    sendDelay++;
}





