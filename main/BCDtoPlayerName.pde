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
else if ((inBit == 'a') || (inBit == 'A') )
  return playerNames[10];
else if ((inBit == 'b') || (inBit == 'B') )
  return playerNames[11];
else if ((inBit == 'c') || (inBit == 'C') )
  return playerNames[12];
else if ((inBit == 'd') || (inBit == 'D') )
  return playerNames[13];
else if ((inBit == 'e') || (inBit == 'E') )
  return playerNames[14];
else if ((inBit == 'f') || (inBit == 'F') )
  return playerNames[15];
  
else 
  return uglyNameFix;
}
