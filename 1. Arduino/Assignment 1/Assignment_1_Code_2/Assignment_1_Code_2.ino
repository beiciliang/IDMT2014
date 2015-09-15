/*
  Code of Step 2: Use the FSR value to create a tone
  
  created 24 Sept 2014
  by Beici Liang
 */

int fsrPin = 2;    //the pin that the FSR is attached to
int piezoPin = 9;  //the pin that the piezo is attached to

void setup() {
  Serial.begin(9600);      //initialize serial communications at 9600 bps
  pinMode(piezoPin, OUTPUT);  //declare the piezoPin as an OUTPUT
}

void loop() {
  //read the analog in value
  int fsrValue = analogRead(fsrPin); 
  //map the voltage range from 0-1023 to 220-880
  int noteValue = map(fsrValue, 0, 1023, 220, 880);
  //generate tones between A3 and A5
  tone(piezoPin, noteValue); 
  Serial.println(noteValue);
}

