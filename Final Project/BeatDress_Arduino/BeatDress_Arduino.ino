/*
this goes on the Arduino
for use with Processing example BeatDress_Processing

created by Beici Liang, 4 Dec 2014
*/

// The Tlc5940 library can be downloaded at http://code.google.com/p/tlc5940arduino/
#include <Tlc5940.h> 

int sensorPin = 0;
int x = 0;
// Set the default value received from Processing
int valin[] = {0, 0, 0}; 
// The variable will be sent to Processing
int valout;  
int lightness1 = 1000;
int lightness2 = 2500;

void setup() {  
  Serial.begin(9600);
  Tlc.init(0);  
}

void loop() {  
  
  // Read the voltage sent from heartbeat sensor
  // and sent out to the serial port for Processing to draw the grahp
  valout = analogRead(sensorPin);
  Serial.println(valout); 
  
  // Receive the results of drum beat detection from Processing
  if (Serial.available() > 0){  
    valin[x] = Serial.read();
    x++;
    if(x > 2) x = 0;
  }
  
  // Turn the white leds on at the moment when the kick drum beat is detected
  if (valin[0] == 'K'){
    Tlc.set(0, lightness1);
    Tlc.set(1, lightness1);
    Tlc.set(2, lightness1);
    Tlc.set(3, lightness1);
    Tlc.set(4, lightness1);
    Tlc.set(5, lightness1);
    Tlc.update();
  }
  else if (valin[0] == 'N'){
    Tlc.set(0, 0);
    Tlc.set(1, 0);
    Tlc.set(2, 0);
    Tlc.set(3, 0);
    Tlc.set(4, 0);
    Tlc.set(5, 0);
    Tlc.update();  
  } 
  // Turn the yellow leds on at the moment when the snare drum beat is detected
  if (valin[1] == 'S'){
    Tlc.set(6, lightness1);
    Tlc.set(7, lightness1);
    Tlc.set(8, lightness1);
    Tlc.set(9, lightness1);
    Tlc.set(10, lightness1);
    Tlc.update();
  }
  else if (valin[1] == 'N'){
    Tlc.set(6, 0);
    Tlc.set(7, 0);
    Tlc.set(8, 0);
    Tlc.set(9, 0);
    Tlc.set(10, 0);
    Tlc.update();  
  } 
  // Turn the green leds on at the moment when the hat drum beat is detected
  if (valin[2] == 'H'){
    Tlc.set(11, lightness2);
    Tlc.set(12, lightness2);
    Tlc.set(13, lightness2);
    Tlc.set(14, lightness2);
    Tlc.set(15, lightness2);
    Tlc.update();
  }
  else if (valin[2] == 'N'){
    Tlc.set(11, 0);
    Tlc.set(12, 0);
    Tlc.set(13, 0);
    Tlc.set(14, 0);
    Tlc.set(15, 0);
    Tlc.update(); 
  } 
}



