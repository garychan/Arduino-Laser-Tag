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
