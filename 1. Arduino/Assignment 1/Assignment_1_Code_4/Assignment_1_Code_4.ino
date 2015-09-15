/*
  Code of Step 3: Use the buttons to make a simple keyboard
  
  created 25 Sept 2014
  by Beici Liang
 */

int buttonPin = 0;  //the pin that the buttons are attached to
int piezoPin = 9;  //the pin that the piezo is attached to
int fsrPin = 2;  //the pin tht the FSR is attached to

void setup(){
  Serial.begin(9600);  //initialize serial communications at 9600 bps
  pinMode(piezoPin, OUTPUT);  //declare the piezoPin as an OUTPUT
}

void loop(){
  //create a local variable to hold the input from pitchPin
  int button = analogRead(buttonPin);
  //create a local variable to hold the input from fsrPin
  int fsrValue = analogRead(fsrPin);
  if(button == 1023){
    //in this case, I am referring to the number 262, which means C4
    //the FSR would give a range between 249Hz and 275Hz
    if(fsrValue == 0){
      tone(piezoPin, 262);
    }
    else{
      int noteValue = map(fsrValue, 0, 1023, 249, 275);
      tone(piezoPin, noteValue);
    }
  }
  else if(button >= 968 && button <= 972){
    if(fsrValue == 0){
      tone(piezoPin, 294);  //play D4
    }
    else{
      int noteValue = map(fsrValue, 0, 1023, 280, 309);
      tone(piezoPin, noteValue);
    };
  }
  else if(button >= 838 && button <= 842){
    if(fsrValue == 0){
      tone(piezoPin, 330);  //play E4
    }
    else{
      int noteValue = map(fsrValue, 0, 1023, 314, 347);
      tone(piezoPin, noteValue);
    }
  }
  else if(button >= 509 && button <= 513){
    if(fsrValue == 0){
      tone(piezoPin, 349);  //play F4
    }
    else{
      int noteValue = map(fsrValue, 0, 1023, 332, 366);
      tone(piezoPin, noteValue);
    }
  }
  else if(button >= 496 && button <= 500){
    if(fsrValue == 0){
      tone(piezoPin, 392);  //play G4
    }
    else{
      int noteValue = map(fsrValue, 0, 1023, 372, 412);
      tone(piezoPin, noteValue);
    }
  }
  else if(button >= 460 && button <= 464){
    if(fsrValue == 0){
      tone(piezoPin, 440);  //play A4
    }
    else{
      int noteValue = map(fsrValue, 0, 1023, 418, 462);
      tone(piezoPin, noteValue);
    }
  }
  else if(button >= 332 && button <= 336){
    if(fsrValue == 0){
      tone(piezoPin, 494);  //play B4
    }
    else{
      int noteValue = map(fsrValue, 0, 1023, 469, 519);
      tone(piezoPin, noteValue);
    }
  }
  else if(button >= 315 && button <= 319){
    if(fsrValue == 0){
      tone(piezoPin, 523);  //play C5
    }
    else{
      int noteValue = map(fsrValue, 0, 1023, 497, 539);
      tone(piezoPin, noteValue);
    }
  }
  else{
    noTone(piezoPin);
  }
}
