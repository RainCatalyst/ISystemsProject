#include <Wire.h>
#include "display.h"
#include "nfc.h"

String newWord;
String articleStr;
bool wordAvailable = false;
int buzzer = D3;

void setup() {
  pinMode(buzzer,OUTPUT);
  Serial.begin(9600);
  initNFC();
  initDisplay();
}

Article parseArticle(const String& art) {
  if (art == "der") return DER;
  if (art == "die") return DIE;
  if (art == "das") return DAS;
  return UNKNOWN;
}

void loop() {
  if (!wordAvailable && Serial.available()) {
    newWord = Serial.readStringUntil('\n');
    articleStr = Serial.readStringUntil('\n');
    showWord(newWord);
    wordAvailable = true;
  }

  if (wordAvailable) {
    Article cardArticle;
    if (readCard(cardArticle)) {
      Article correctArticle = parseArticle(articleStr);
      bool correct = (cardArticle == correctArticle);
      Serial.println(correct ? "Correct" : "Wrong");
      if (correct){
        tone (buzzer, 1200,500);
      } else {
        tone(buzzer, 800,200);
        delay(500);
        tone(buzzer, 800, 200);
      }
      showResult(correct, articleStr, newWord);
      wordAvailable = false;
      delay(500);
    }
  }
}
