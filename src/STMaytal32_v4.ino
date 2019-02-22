static const byte PROGMEM DEVEUI[8]   =   { 0x79, 0xB1, 0xFA, 0x85, 0x03, 0x18, 0xAD, 0x00 }; //  LSB
static const byte PROGMEM APPEUI[8]   =   { 0xF4, 0x0C, 0x01, 0xD0, 0x7E, 0xD5, 0xB3, 0x70 }; //  LSB
static const byte PROGMEM APPKEY[16]  =   { 0xDE, 0xB6, 0xA3, 0x22, 0x4F, 0x23, 0xA0, 0x5D, 0x37, 0xD7, 0xFB, 0xA0, 0x65, 0x18, 0x89, 0x1A };  //  MSB

#define VERSION "0.03"
#define INTERVAL 15       //  Time, in minutes, between uploads

//  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 

#include <lmic.h>           //  LoRaWAN-MAC-in-C library
#include <hal/hal.h>        //  Hardware abstraction layer library
#include <EEPROM.h>         //  To store derived LoRaWAN session keys
#include <SPI.h>            //  For communication with RFM95
#include <RTClock.h>        //  For using the onboard real-time clock
#include <libmaple/scb.h>   //  System control byte definitions

//  Backup memory registers to hold LoRaWAN session information from boot to boot
#define BOOTWORD      (*(uint32_t *)0x40006C04)   //  Will allow us to verify if this is the initial boot
#define SEQNOUP       (*(uint32_t *)0x40006C08)   //  LoRaWAN upload sequence count
#define SEQNODN       (*(uint32_t *)0x40006C0C)   //  LoRaWAN download sequence count
#define TXCHNL        (*(uint32_t *)0x40006C10)   //  TX channel as received from ADR
#define DATARATE      (*(uint32_t *)0x40006C14)   //  Data rate as received from ADR
#define ADRTXPOW      (*(uint32_t *)0x40006C18)   //  Transmit power as received from ADR

#define PRESCALER 0xF0000   //  Two ticks per minute for the RTC

void os_getDevEui(u1_t* buf) {memcpy_P(buf, DEVEUI, 8);}
void os_getArtEui(u1_t* buf) {memcpy_P(buf, APPEUI, 8);}
void os_getDevKey(u1_t* buf) {memcpy_P(buf, APPKEY, 16);}

const uint16_t MAGICWORD = 0xBEEF;           //  Vegetarians may prefer CAFE

uint8_t payload[2];
static osjob_t sendjob;

const uint16_t nwkSKeyIndex = 0x10;
const uint16_t appSKeyIndex = 0x30;
const uint16_t netidIndex   = 0x40;
const uint16_t devaddrIndex = 0x41;

uint32_t  sleepTime;
const int Q1 = PB1;           //  Transistor for transducer
const int en = PB11;          //  LoRa module enable
const int pressurePin = PA0;  //  Pressure transducer output
const int led = PC13;

boolean initialBoot   =   false;
boolean transmission  =   false;

// Pin mapping for RFM95 module
const lmic_pinmap lmic_pins = {
  .nss = PA4,
  .rxtx = LMIC_UNUSED_PIN,
  .rst = PB0,
  .dio = {PA3, PB10, LMIC_UNUSED_PIN}
};

#define DEBUG

RTClock rtc(RTCSEL_LSE, PRESCALER + 1);   //  Instantiate Low Speed External clock with prescaler



void setup() {
  Serial1.begin(115200);

  wait(1000);

  Serial1.println();
  Serial1.println("---------------------------------------------------------------------------------");
  Serial1.print(F("STMaytal32 v"));
  Serial1.println(VERSION);
  Serial1.print(__DATE__);   //  Compile date and time helps identify software uploads
  Serial1.print(F(" "));
  Serial1.println(__TIME__);

  wait(2000);
  
  /*  TODO: Validate that alarm is still set before sleep -- we don't want to set alarm after upload
  *  because the timing of readings and uploads will get erratic. We want a nice steady cadence. */
  rtc.createAlarm(&AlarmFunction, rtc.getTime() + (INTERVAL * 2) - 1);  //  Set wakeup alarm
  
  pinMode(led, OUTPUT);
  pinMode(Q1, OUTPUT);
  pinMode(en, OUTPUT);
  
  #ifdef DEBUG
    digitalWrite(led, LOW);
  #endif

  digitalWrite(en, HIGH);   //  Turn on LoRa radio
  wait(1000);               //  Give the radio a moment to shake off the sleepies
  
  EEPROM.PageBase0 = 0x801F000;
  EEPROM.PageBase1 = 0x801F800;
  EEPROM.PageSize  = 0x800;

  os_init();                //  

  /*   If MAGICWORD is not already in the backup registers, we know the unit is booting from scratch
   *   and we need to start the LoRaWAN upload sequence count from zero. We'll also need to store the
   *   NwkSKey and AppSKey for use on later wakes once we have them.  */   
  if(BOOTWORD != MAGICWORD) {
    Serial1.println("First boot.\n");
    LMIC_reset();           //  Reset the MAC state. Session and pending data transfers will be discarded.
    EEPROM.init();          //  Initialize the emulated EEPROM
    EEPROM.format();        //  Format the emulated EEPROM
    initialBoot = true;
    BOOTWORD = MAGICWORD;
  } else {
    Serial1.println("Welcome back.\n");
    restoreSession();
    initialBoot = false;
  }
  
  LMIC_setClockError(MAX_CLOCK_ERROR * 1 / 100);  //  Let LMIC compensate for +/- 1% clock error*/

  LMIC_setAdrMode(1);
  LMIC_setLinkCheckMode(1);
  /*LMIC_setDrTxpow(DR_SF9,20);
  LMIC.dn2Dr = DR_SF9;*/

  #if defined(CFG_eu868)
    LMIC_setupChannel(0, 868100000, DR_RANGE_MAP(DR_SF12, DR_SF7),  BAND_CENTI);      // g-band
    LMIC_setupChannel(1, 868300000, DR_RANGE_MAP(DR_SF12, DR_SF7B), BAND_CENTI);      // g-band
    LMIC_setupChannel(2, 868500000, DR_RANGE_MAP(DR_SF12, DR_SF7),  BAND_CENTI);      // g-band
    LMIC_setupChannel(3, 867100000, DR_RANGE_MAP(DR_SF12, DR_SF7),  BAND_CENTI);      // g-band
    LMIC_setupChannel(4, 867300000, DR_RANGE_MAP(DR_SF12, DR_SF7),  BAND_CENTI);      // g-band
    LMIC_setupChannel(5, 867500000, DR_RANGE_MAP(DR_SF12, DR_SF7),  BAND_CENTI);      // g-band
    LMIC_setupChannel(6, 867700000, DR_RANGE_MAP(DR_SF12, DR_SF7),  BAND_CENTI);      // g-band
    LMIC_setupChannel(7, 867900000, DR_RANGE_MAP(DR_SF12, DR_SF7),  BAND_CENTI);      // g-band
    LMIC_setupChannel(8, 868800000, DR_RANGE_MAP(DR_FSK,  DR_FSK),  BAND_MILLI);      // g2-band
  #elif defined(CFG_us915)
    // NA-US channels 0-71 are configured automatically
    LMIC_selectSubBand(1);
  #endif
  
  wait(5000);

  transmission = false;
  
  #ifdef DEBUG
  digitalWrite(led, LOW);
  #endif
  
  uint16_t psi = readPressure();   //  Get sensor data

  payload[1] = psi >> 8;
  payload[0] = psi;

  Serial1.println();
  
  do_send(&sendjob);        //  Start job
  
  while(1) {
    os_runloop_once();
    
    if(transmission == true) {
      break;
    }
    
    /*if(joined == true) {
      break;
    }*/
  }
  
  Serial1.print("PSI: ");
  Serial1.println(psi);
  Serial1.print("Payload[0]: ");
  Serial1.println(payload[0], BIN);
  Serial1.print("Payload[1]: ");
  Serial1.println(payload[1], BIN);  

  Serial1.print("netid: ");
  Serial1.println(LMIC.netid);
  Serial1.print("devaddr: ");
  Serial1.println(LMIC.devaddr, HEX);

  Serial1.print("Seqnoup: ");
  Serial1.println(LMIC.seqnoUp);
  Serial1.print("Seqnodown: ");
  Serial1.println(LMIC.seqnoDn);
  Serial1.println();
  Serial1.print("NwkSKey: ");
  for(int i = 0; i < 16; i++) {
    Serial1.print(LMIC.nwkKey[i], HEX);
    Serial1.print(" ");
  }

  Serial1.println();
  
  Serial1.print("AppSKey: ");
  for(int i = 0; i < 16; i++) {
    Serial1.print(LMIC.artKey[i], HEX);
    Serial1.print(" ");
  }
  
  SEQNOUP = LMIC.seqnoUp;
  SEQNODN = LMIC.seqnoDn;
  
  wait(100);

  #ifdef DEBUG
    Serial1.println("\n\rSleeping...");
  #endif

  Serial1.end();
  digitalWrite(en, LOW);      //  Turn off LoRa radio

  #ifdef DEBUG
    digitalWrite(led, HIGH);
  #endif
 
  wait(100);
   
  enterSleepMode();
}



void loop() {
  while(1);                 //  Should never reach
}



void wait(unsigned long ms) { //  Non-blocking delay function
  unsigned long period = millis() + ms;
  while(millis() < period) {
    Serial1.flush();
  }
}



uint16_t readPressure() {    //  This is the original Maytal code for a 5V input
  digitalWrite(Q1, HIGH);     //  Switch on transducer
  wait(3000);                 //  Let transducer settle

  uint16_t lowerBound = 343;
  uint16_t upperBound = 4096 - lowerBound;
  
  float pressure = 0.00;
  uint16_t adcReading = analogRead(pressurePin);
  uint16_t rawVoltage = map(adcReading, 0, 4095, 0, 5000);

  //  Validate that analogRead is between 0.5v-4.5v range of transducer
  if(adcReading < lowerBound || adcReading > upperBound) {
    pressure = 0.00;
  } else {
    pressure = ((adcReading - 343) * .065);
  }

  digitalWrite(Q1, LOW);      //  Switch off transducer to save power

  #ifdef DEBUG
    Serial1.print("ADC reading: ");
    Serial1.println(adcReading);
    Serial1.print("Raw voltage: ");
    Serial1.println(rawVoltage);
    Serial1.print("Converted pressure: ");
    Serial1.println(pressure);
  #endif

  return(int)pressure;
}
