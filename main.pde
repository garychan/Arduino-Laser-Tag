/* IROH v2?
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
const int MAX_PLAYERS = 32; // if 5-bit player code. Leaving 3-bits for error checksumming if 1 byte code.
char* playerNames[MAX_PLAYERS];

void setup () {
 
}

void loop() {
 
}

void playerStringDisp(char* playerName) {
// This function will display to the LCD screen who hit me.
// This works by getting a string for the LUT function
// and serial output to the LCD display.
}

char* playerNameString(int playerCode) {
// return the playerName at the position playerCode in the playerName LUT.
}

void populatePlayerLUT() {
// This reads in via the IR-in link the data that is player names.
// Each player is assigned a position in a static array of MAX_PLAYERS
// size.
}
