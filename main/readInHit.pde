void readInHit() {
// read in bits from the manual DIP selection.
// this emulated data read in from the UART ckt.
    
      if (Serial.available() > 0) 
      {
          inBit = Serial.read();
          flushSerialIn();
      }
}
