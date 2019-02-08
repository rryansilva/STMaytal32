void enterSleepMode() {
  // Clear PDDS and LPDS bits and wakeup pin and set Clear WUF flag (required per datasheet):
  PWR_BASE->CR &= PWR_CR_LPDS | PWR_CR_PDDS | PWR_CR_CWUF |  PWR_CSR_EWUP;

  // magic https://community.particle.io/t/how-to-put-spark-core-to-sleep-and-wakeup-on-interrupt-signal-on-a-pin/5947/56
  // Enable wakeup pin bit.
  PWR_BASE->CSR |= PWR_CSR_EWUP; 
  PWR_BASE->CR  |= PWR_CR_CWUF;
  SCB_BASE->SCR |= SCB_SCR_SLEEPDEEP;

  // System Control Register Bits. See...
  // http://infocenter.arm.com/help/index.jsp?topic=/com.arm.doc.dui0497a/Cihhjgdh.html
  PWR_BASE->CR |= PWR_CR_CWUF; // FIX to save power on subsequent runs too
  // Set PDDS and LPDS bits for standby,
  // Set Power down deepsleep bit.
  PWR_BASE->CR |= PWR_CR_PDDS;
  // Unset Low-power deepsleep.
  PWR_BASE->CR &= ~PWR_CR_LPDS;

  // Now go into stop mode, wake up on interrupt
  asm("    wfi");

  // Clear SLEEPDEEP bit so we can use SLEEP mode
  SCB_BASE->SCR &= ~SCB_SCR_SLEEPDEEP;
}



void AlarmFunction() {
  // We always wake up with the 8Mhz HSI clock!
  // So adjust the clock if needed...

  #if F_CPU == 8000000UL
  // nothing to do, using about 8 mA
  #elif F_CPU == 16000000UL
  rcc_clk_init(RCC_CLKSRC_HSI, RCC_PLLSRC_HSE , RCC_PLLMUL_2);
  #elif F_CPU == 48000000UL
  rcc_clk_init(RCC_CLKSRC_HSI, RCC_PLLSRC_HSE , RCC_PLLMUL_6);
  #elif F_CPU == 72000000UL
  rcc_clk_init(RCC_CLKSRC_HSI, RCC_PLLSRC_HSE , RCC_PLLMUL_9);
  #else
  #error "Unknown F_CPU!?"
  #endif

  extern volatile uint32_t systick_uptime_millis;
  systick_uptime_millis += sleepTime;
}



void writeKeys() {      //  Pack the bytes of the key into the emulated EEPROM
  for(int i = 0; i < 16; i++) {
    EEPROM.write(nwkSKeyIndex + i, LMIC.nwkKey[i]);
    EEPROM.write(appSKeyIndex + i, LMIC.artKey[i]);
  }

  EEPROM.write(netidIndex, LMIC.netid);

  EEPROM.write(devaddrIndex, LMIC.devaddr & 0x0000FFFF);
  EEPROM.write(devaddrIndex + 1, (LMIC.devaddr >> 16));
}



void restoreSession() {
  u4_t restoredNetid = EEPROM.read(netidIndex);
  devaddr_t restoredAddr = EEPROM.read(devaddrIndex + 1) << 16 | EEPROM.read(devaddrIndex);
  u1_t nwkSKey[16];
  u1_t appSKey[16];
  
  for(int i = 0; i < 16; i++) {
    nwkSKey[i] = EEPROM.read(nwkSKeyIndex + i);
    appSKey[i] = EEPROM.read(appSKeyIndex + i);
  }

  LMIC_reset();           //  Reset the MAC state. Session and pending data transfers will be discarded.

  LMIC_setSession(restoredNetid, restoredAddr, nwkSKey, appSKey);

  LMIC.seqnoUp    = SEQNOUP;
  LMIC.seqnoDn    = SEQNODN;
  LMIC.txChnl     = TXCHNL;
  LMIC.datarate   = DATARATE;
  LMIC.adrTxPow   = ADRTXPOW;
}
