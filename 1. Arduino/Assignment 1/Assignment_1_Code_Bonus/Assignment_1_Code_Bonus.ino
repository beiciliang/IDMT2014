/*
  Code of Step 3: Use the buttons to make a simple keyboard
  
  created 26 Sept 2014
  modified 30 Sept 2014
  by Beici Liang
 */
 
#include "pitches.h"

unsigned int melody[] = {
  NOTE_C3, NOTE_G3, NOTE_G3, NOTE_FS3, NOTE_G3, NOTE_GS3, NOTE_G3, NOTE_F3, NOTE_C4, 
  NOTE_F3, NOTE_C4, NOTE_C4, NOTE_B3, NOTE_C4, NOTE_D4, NOTE_C4, NOTE_DS4, 
  NOTE_G4, NOTE_C4, NOTE_C4, NOTE_D4, NOTE_DS4, NOTE_D4, NOTE_C4, NOTE_F4, NOTE_C4,
  NOTE_C4, NOTE_D4, NOTE_DS4, NOTE_DS4, NOTE_F4, NOTE_D4, NOTE_D4, NOTE_DS4, NOTE_C4, NOTE_C4, NOTE_D4, NOTE_B3, NOTE_GS3, NOTE_G3, NOTE_C4};

int buttonPin = 8;
int piezoPin = 13;
int counter = 0;
boolean playing = false;

void setup(){
  pinMode(buttonPin, INPUT);  
  pinMode(piezoPin, OUTPUT); 
 }

void loop(){
  if (digitalRead(buttonPin) == HIGH){
    if (!playing){
      tone(piezoPin, melody[counter]);
      playing = true;
    }
  }
  else if (playing){
    noTone(piezoPin);
    counter++;
    if (counter >= 41)
      counter = 0;
    playing = false;
  }
}

