#ifndef DISPLAY_H
#define DISPLAY_H

#include <Adafruit_SSD1306.h>

#define SCREEN_WIDTH 128
#define SCREEN_HEIGHT 64

Adafruit_SSD1306 display(SCREEN_WIDTH, SCREEN_HEIGHT, &Wire);

void initDisplay() {
  display.begin(SSD1306_SWITCHCAPVCC, 0x3C);
  display.clearDisplay();
  display.setTextSize(3);
  display.setTextColor(WHITE);
  display.setCursor(0, 0);
  display.println("Wait for setup.");
  display.display();
}

void showWord(const String& word) {
  display.clearDisplay();
  display.setCursor(0, 0);
  display.println(word);
  display.display();
}

void showResult(bool correct, const String& article, const String& word) {
  display.clearDisplay();
  display.setCursor(0, 0);
  if (correct) {
    display.printf("[CORRECT] %s %s", article.c_str(), word.c_str());
  } else {
    display.printf("[WRONG] %s %s", article.c_str(), word.c_str());
  }
  display.display();
}

#endif
