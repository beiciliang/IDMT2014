/*
this goes on your Arduino
 for use with Processing example IRPulseSensor
 
 */

#include <Tlc5940.h>

// holds temp vals
int valout;
int valin; 
int inPin = 0;
//int ledPin1 = 12; // LED connected to digital pin 12
//int ledPin2 = 8; // LED connected to digital pin 8
//int ledPin3 = 2; // LED connected to digital pin 2
int x = 0;
int value[] = {
  0, 0, 0};

void setup() {  
  Serial.begin(9600);
  Tlc.init(0);  
  // pinMode(ledPin1, OUTPUT);
  // pinMode(ledPin2, OUTPUT);
  // pinMode(ledPin3, OUTPUT);
}

void loop() {  

  if (Serial.available() > 0){
    valin = Serial.read(); 
    value[x] = valin;
    x++;
    if(x > 2) x = 0;
  }
  if (value[0] == 'K'){
    //digitalWrite(ledPin1, HIGH);
    Tlc.set(0, 2000);
    Tlc.set(1, 2000);
    Tlc.set(2, 2000);
    Tlc.set(3, 2000);
    Tlc.set(4, 2000);
    Tlc.set(5, 2000);
    Tlc.update();
  }
  else if (valin == 'N'){
    //digitalWrite(ledPin1, LOW) ;
    Tlc.set(0, 0);
    Tlc.set(1, 0);
    Tlc.set(2, 0);
    Tlc.set(3, 0);
    Tlc.set(4, 0);
    Tlc.set(5, 0);
    Tlc.update();  
  } 
  if (value[1] == 'S'){
    //digitalWrite(ledPin2, HIGH) ;
    Tlc.set(6, 2000);
    Tlc.set(7, 2000);
    Tlc.set(8, 2000);
    Tlc.set(9, 2000);
    Tlc.set(10, 2000);
    Tlc.update();
  }
  else if (valin == 'N'){
    //digitalWrite(ledPin2, LOW) ;
    Tlc.set(6, 0);
    Tlc.set(7, 0);
    Tlc.set(8, 0);
    Tlc.set(9, 0);
    Tlc.set(10, 0);
    Tlc.update();  
  } 
  if (value[2] == 'H'){
    // digitalWrite(ledPin3, HIGH) ;
    Tlc.set(11, 2000);
    Tlc.set(12, 2000);
    Tlc.set(13, 2000);
    Tlc.set(14, 2000);
    Tlc.set(15, 2000);
    Tlc.update();
  }
  else if (valin == 'N'){
    // digitalWrite(ledPin3, LOW) ; 
    Tlc.set(11, 0);
    Tlc.set(12, 0);
    Tlc.set(13, 0);
    Tlc.set(14, 0);
    Tlc.set(15, 0);
    Tlc.update(); 
  } 


  Serial.println(analogRead(inPin)); 
}



