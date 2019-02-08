void onEvent(ev_t ev) {
  Serial1.print(os_getTime());
  Serial1.print(": ");
  switch(ev) {
  case EV_SCAN_TIMEOUT:
    Serial1.println(F("EV_SCAN_TIMEOUT"));
    break;
  case EV_BEACON_FOUND:
    Serial1.println(F("EV_BEACON_FOUND"));
    break;
  case EV_BEACON_MISSED:
    Serial1.println(F("EV_BEACON_MISSED"));
    break;
  case EV_BEACON_TRACKED:
    Serial1.println(F("EV_BEACON_TRACKED"));
    break;
  case EV_JOINING:
    Serial1.println(F("EV_JOINING"));
    break;
  case EV_JOINED:
    Serial1.println(F("EV_JOINED"));
    writeKeys();      //  Write the keys to emulated EEPROM
    break;
  case EV_RFU1:
    Serial1.println(F("EV_RFU1"));
    break;
  case EV_JOIN_FAILED:
    Serial1.println(F("EV_JOIN_FAILED"));
    break;
  case EV_REJOIN_FAILED:
    Serial1.println(F("EV_REJOIN_FAILED"));
    break;
  case EV_TXCOMPLETE:
    Serial1.println(F("EV_TXCOMPLETE (includes waiting for RX windows)"));
    if (LMIC.txrxFlags & TXRX_ACK)
      Serial1.println(F("Received ack"));
    if (LMIC.dataLen) {
      Serial1.println(F("Received "));
      Serial1.println(LMIC.dataLen);
      Serial1.println(F(" bytes of payload"));
    }
    Serial1.print("txChn1 ");
    Serial1.print(LMIC.txChnl);
    Serial1.print(", datarate ");
    Serial1.print(LMIC.datarate);   
    Serial1.print(", txPower: ");
    Serial1.print(LMIC.adrTxPow);

    TXCHNL        = LMIC.txChnl;
    DATARATE      = LMIC.datarate;
    ADRTXPOW      = LMIC.adrTxPow;
    
    transmission = true;
    break;
  case EV_LOST_TSYNC:
    Serial1.println(F("EV_LOST_TSYNC"));
    break;
  case EV_RESET:
    Serial1.println(F("EV_RESET"));
    break;
  case EV_RXCOMPLETE:
    // data received in ping slot
    Serial1.println(F("EV_RXCOMPLETE"));
    break;
  case EV_LINK_DEAD:
    Serial1.println(F("EV_LINK_DEAD"));
    break;
  case EV_LINK_ALIVE:
    Serial1.println(F("EV_LINK_ALIVE"));
    break;
   default:
    Serial1.println(F("Unknown event"));
    break;
  }
}



void do_send(osjob_t* j){
  // Check if there is not a current TX/RX job running
  if(LMIC.opmode & OP_TXRXPEND) {
    Serial1.println(F("OP_TXRXPEND, not sending"));
  } else {
    // Prepare upstream data transmission at the next possible time.
    LMIC_setTxData2(1, payload, sizeof(payload)-1, 0);
    Serial1.println(F("Packet queued"));
  }
  // Next TX is scheduled after TX_COMPLETE event.
}
