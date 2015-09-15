/*
  Code of Step 3: Use the buttons to make a simple keyboard
  
  created 25 Sept 2014
  by Beici Liang
 */

int buttonPin = 0;  //the pin that the buttons are attached to
int piezoPin = 9;  //the pin that the piezo is attached to

void setup(){
  Serial.begin(9600);  //initialize serial communications at 9600 bps
  pinMode(piezoPin, OUTPUT);  //declare the piezoPin as an OUTPUT
}

void loop(){
  //create a local variable to hold the input from pitchPin
  int button = analogRead(buttonPin);
  //send the value to the Serial Monitor
  Serial.println(button);
  if(button == 1023){
    //in this case, I am referring to the number 262, which means C4
    tone(piezoPin, 262);
  }
  else if(button >= 968 && button <= 972){
    tone(piezoPin, 294);  //play D4
  }
  else if(button >= 838 && button <= 842){
    tone(piezoPin, 330);  //play E4
  }
  else if(button >= 509 && button <= 513){
    tone(piezoPin, 349);  //play F4
  }
  else if(button >= 496 && button <= 500){
    tone(piezoPin, 392);  //play G4
  }
  else if(button >= 460 && button <= 464){
    tone(piezoPin, 440);  //play A4
  }
  else if(button >= 332 && button <= 336){
    tone(piezoPin, 494);  //play B4
  }
  else if(button >= 315 && button <= 319){
    tone(piezoPin, 523);  //play C5
  }
  else{
    noTone(piezoPin);
  }
}
