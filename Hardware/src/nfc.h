#ifndef NFC_H
#define NFC_H

#include <Wire.h>
#include <PN532_I2C.h>
#include <PN532.h>

#define PN532_SDA  D2
#define PN532_SCL  D1

PN532_I2C pn532i2c(Wire);
PN532 nfc(pn532i2c);

enum Article { DER = 0, DIE = 1, DAS = 2, UNKNOWN = -1 };

void initNFC() {
  nfc.begin();
  uint32_t versiondata;
  while (!(versiondata = nfc.getFirmwareVersion())) {
    Serial.println("Didn't find PN53x board");
    delay(1000);
  }

  Serial.print("Found chip PN5");
  Serial.println((versiondata >> 24) & 0xFF, HEX);
  Serial.print("Firmware ver. ");
  Serial.print((versiondata >> 16) & 0xFF, DEC);
  Serial.print('.');
  Serial.println((versiondata >> 8) & 0xFF, DEC);

  nfc.setPassiveActivationRetries(0xFF);
  nfc.SAMConfig();
  Serial.println("Waiting for an ISO14443A card");
}

Article getArticleFromUID(uint8_t uidByte) {
  switch (uidByte) {
    case 0x98: return DER;
    case 0x72: return DIE;
    case 0xD5: return DAS;
    default: return UNKNOWN;
  }
}

bool readCard(Article &cardArticle) {
  uint8_t uid[7];
  uint8_t uidLength;
  if (nfc.readPassiveTargetID(PN532_MIFARE_ISO14443A, uid, &uidLength)) {
    cardArticle = getArticleFromUID(uid[1]);
    return true;
  }
  return false;
}

#endif
