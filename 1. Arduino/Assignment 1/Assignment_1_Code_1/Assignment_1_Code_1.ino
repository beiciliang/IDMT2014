/*
  Code of Step 1: Connect and read the FSR
  
  created 24 Sept 2014
  by Beici Liang
 */

int fsrPin = 2;    //the pin that the FSR is attached to
int ledPin = 11;   //the pin that the LED is attached to

void setup() {
  Serial.begin(9600);      // initialize serial communications at 9600 bps
  pinMode(ledPin, OUTPUT);  // declare the ledPin as an OUTPUT
}

void loop() {
  //read the analog in value
  int fsrValue = analogRead(fsrPin); 
  //map the voltage range from 0-1023 to 0-255
  int ledValue = map(fsrValue, 0, 1023, 0, 255);
  //set the LED intensity proportional to the pressure on the sensor
  analogWrite(ledPin, ledValue); 
  //print the results to the serial monitor  
  Serial.println(ledValue);     
}

