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
