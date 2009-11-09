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


#include "WProgram.h"
void setup ();
void loop();
char* playerNameString();
void selectLineOne();
void selectLineTwo();
void clearLCD();
void setBrightnessFull();
void flushSerialIn();
void readInHit();
void populatePlayerTable();
void printPlayerNames(int playPos);
char inBit;
const int MAX_PLAYERS = 16; // if 4-bit player code. Leaving 4-bits for error checksumming if 1 byte code.
char* playerNames[] = {"PLAYER0", "PLAYER1", "PLAYER2", "PLAYER3", "PLAYER4", "PLAYER5", "PLAYER6", "PLAYER7", 
                       "PLAYER8", "PLAYER9", "PLAYERA", "PLAYERB", "PLAYERC", "PLAYERD", "PLAYERE", "PLAYERF"};
char* uglyNameFix = "INVALID!";


void setup () {
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
 delay(2000);
 clearLCD();
 setBrightnessFull();
 flushSerialIn(); 
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
  
  selectLineOne();
  Serial.print("No Hit...");
  delay(10);
    
}





char* playerNameString() {
// return the playerName at the position playerCode in the playerName LUT.

if ((inBit == '0') )
  return playerNames[0];
else if ((inBit == '1') )
  return playerNames[1];
else if ((inBit == '2') )
  return playerNames[2];
else if ((inBit == '3') )
  return playerNames[3];
else if ((inBit == '4') )
  return playerNames[4];
else if ((inBit == '5') )
  return playerNames[5];
else if ((inBit == '6') )
  return playerNames[6];
else if ((inBit == '7') )
  return playerNames[7];
else if ((inBit == '8') )
  return playerNames[8];
else if ((inBit == '9') )
  return playerNames[9];
else if ((inBit == 'a') )
  return playerNames[10];
else if ((inBit == 'b') )
  return playerNames[11];
else if ((inBit == 'c') )
  return playerNames[12];
else if ((inBit == 'd') )
  return playerNames[13];
else if ((inBit == 'e') )
  return playerNames[14];
else if ((inBit == 'f') )
  return playerNames[15];
  
else 
  return uglyNameFix;
}
// LCD CONTROLLER FUNCTIONS:

void selectLineOne(){  //puts the cursor at line 0 char 0.
   Serial.print(0xFE, BYTE);   //command flag
   Serial.print(128, BYTE);    //position
}

void selectLineTwo(){  //puts the cursor at line 0 char 0.
   Serial.print(0xFE, BYTE);   //command flag
   Serial.print(192, BYTE);    //position
}

void clearLCD(){
   flushSerialIn();
   Serial.print(0xFE, BYTE);   //command flag
   Serial.print(0x01, BYTE);   //clear command.
   flushSerialIn();
}

void setBrightnessFull() {
  flushSerialIn();
  Serial.print(0x7C, BYTE); // command
  Serial.print(0x9D, BYTE); // brightness 100%
  flushSerialIn();
}

void flushSerialIn() {
  while (Serial.available() > 0)
    char trashChar = Serial.read();
}
void readInHit() {
// read in bits from the manual DIP selection.
// this emulated data read in from the UART ckt.
    
      if (Serial.available() > 0) 
      {
          inBit = Serial.read();
          flushSerialIn();
      }
}
void populatePlayerTable() {
// This reads in via the IR-in link the data that is player names.
// Each player is assigned a position in a static array of MAX_PLAYERS
// size.
//
// Sending a "," (comma) indicated NEXT PLAYER
// Sending a "." (period) incates FINSIHED ENTERING.
  clearLCD();
  delay(1000);
  selectLineOne();
  Serial.print("Input Players:");
  delay(1000);
  
  char inChar = 0;
  inChar = 0;
  int namePos = 0; 
  int numPlayers =0;
  
    for (int playPos =0; playPos < MAX_PLAYERS; playPos++ ) 
    {
      char tempName[8] = "       ";
           
        while ( (inChar != ',') && (namePos < 7) )
        {
          if (Serial.available() > 0) {
              inChar = Serial.read();   
              if (inChar == '.')
               printPlayerNames(playPos);       
              selectLineTwo();
              Serial.print("read: ");
              Serial.print(inChar);
              
              tempName[namePos] = inChar;
              namePos++;
              
              Serial.print(" N:");
              Serial.print(namePos);
              Serial.print(" P:");
              Serial.print(playPos, HEX);  
          }          
        }
      if (namePos < 7)
        for (int ctr = namePos; ctr < 7; ctr++)
          tempName[ctr] = ' ';
          
      strcpy(playerNames[playPos], tempName);
      namePos = 0;
      numPlayers = playPos;
    }
    flushSerialIn();
    printPlayerNames(numPlayers);
}

void printPlayerNames(int playPos) {
  clearLCD();
  delay(500);
  
  selectLineOne();
  Serial.print("Read in:");
  
  for (int ctr = 0; ctr < playPos+1; ctr++) {
    selectLineTwo();
    Serial.print("P");
    Serial.print(ctr, HEX);
    Serial.print(": ");
    Serial.print(playerNames[ctr]);
    delay(1000);
  }
  flushSerialIn();
}

int main(void)
{
	init();

	setup();
    
	for (;;)
		loop();
        
	return 0;
}

