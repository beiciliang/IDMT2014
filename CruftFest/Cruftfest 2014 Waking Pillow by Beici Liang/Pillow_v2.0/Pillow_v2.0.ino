
/*
  Code of Waking Pillow
  Cruftfest Project
  
  created 7 Nov 2014
  by Beici Liang
  
  The code makes use of the RTClib library downloaded on https://github.com/adafruit/RTClib,
  and LCDKeypad library downloaded on http://www.dfrobot.com/wiki/index.php?title=Arduino_LCD_KeyPad_Shield_(SKU:_DFR0009)
  
  Before uploading, we should set time for the alarm clock firstly.
  Upload the code in the examples folder of RTClib.Now the time is set the same as the computer's.
  
  For more details, please check out my website:
  http://beiciliang.weebly.com/blog/waking-pillow-my-project-for-cruftfest-2014
*/

#include <Wire.h>  
#include <LiquidCrystal.h>  
#include <LCDKeypad.h>
#include "RTClib.h"
#include "pitches.h"

int BUTTON_PIN = 2;  // Output pin for the button
int BUZZER_PIN = 3;  // Output PWM pin for the buzzer
int MOTOR_PIN = 11;  // Output PWM pin for the motor
int LED_PIN = 13;    // Output pin for the led
int TIME_OUT = 5;  // One of the FSM transitions
int ALARM_TIME_MET = 6;  // One of the FSM transitions
int SNOOZE = 10;  // Minutes to snooze

// Different states of the system
enum states
{
  SHOW_TIME,           // Display the time and date
  SHOW_TIME_ALARM_ON,  // Display the time and date, and alarm is on
  SHOW_ALARM_TIME,     // Display the alarm time and go back to time and date after 3 seconds
  SET_ALARM_HOUR,      // Option for setting the alarm hours. If provided, it moves on to alarm minutes.
                       // Otherwise, it times out after 5 seconds and returns to time and date
  SET_ALARM_MINUTES,   // Option for setting the alarm minutes. If provided, it finally sets the alarm time and alarm.
                       // Otherwise, it times out after 5 seconds and returns to time and date
  WAKE_UP              // If alarm time is met, buzzer, LED and motor are on, and they won't stop unless the button is released,
                       // which means the head is lifted from the pillow.
};

// Create an LCDKeypad instance that handles the LCD screen and buttons on the shield
LCDKeypad lcd;

// Create an RTC_DS1307 instance that handles the DS1307 Real-Time Clock
RTC_DS1307 RTC;

states state;  // Hold the current state of the system
int button;  // Hold the current button pressed
int alarmHours = 0, alarmMinutes = 0;  // Hold the current alarm time
boolean alarm = false;  // Hold the current state of the alarm
DateTime now;  // Hold the current date and time
unsigned long timeRef;
int tmpHours;
int tmpMinute;

void setup()
{
  pinMode(BUTTON_PIN, INPUT);   
  pinMode(BUZZER_PIN, OUTPUT);
  pinMode(LED_PIN, OUTPUT);     
  pinMode(MOTOR_PIN, OUTPUT);

  // Initialise the LCD and RTC instances
  lcd.begin(16, 2);
  Wire.begin();
  RTC.begin();

  // Initialise state of the FSM
  state = SHOW_TIME;  
}


void loop()
{
  timeRef = millis();

  // Use the current state to decide what to process
  switch (state)
  {
  case SHOW_TIME:
    showTime();
    break;
  case SHOW_TIME_ALARM_ON:
    showTime();
    checkAlarmTime();
    break;
  case SHOW_ALARM_TIME:
    showAlarmTime();
    break;
  case SET_ALARM_HOUR:
    setAlarmHours();
    if ( state != SET_ALARM_MINUTES ) 
    break;
  case SET_ALARM_MINUTES:
    setAlarmMinutes();
    break;
  case WAKE_UP:
    wakeUp();
    break;
  }

  // Wait about 1s for button pressed
  // If a button is pressed, it blocks until the button is released
  // and then it performs the applicable state transition
  while ( (unsigned long)(millis() - timeRef) < 970 )
  {
    if ( (button = lcd.button()) != KEYPAD_NONE )
    {
      while ( lcd.button() != KEYPAD_NONE ) 
      transition(button);
      break;
    }
  }
}

 
// Perform the appropriate state transition according to the trigger
void transition(int trigger)
{
  switch (state)
  {
  case SHOW_TIME:
    if ( trigger == KEYPAD_LEFT ) state = SHOW_ALARM_TIME;  // Display the current alarm time
    else if ( trigger == KEYPAD_RIGHT ) {   // Turn the alarm on
      alarm = true; 
      state = SHOW_TIME_ALARM_ON; 
    }
    else if ( trigger == KEYPAD_SELECT ) state = SET_ALARM_HOUR;  // Let you set the alarm time
    break;
  case SHOW_TIME_ALARM_ON:
    if ( trigger == KEYPAD_LEFT ) state = SHOW_ALARM_TIME;  // Display the current alarm time
    else if ( trigger == KEYPAD_RIGHT ) {   // Turn the alarm off
      alarm = false; 
      state = SHOW_TIME; 
    }
    else if ( trigger == KEYPAD_SELECT ) state = SET_ALARM_HOUR;  // Let you set the alarm time
    else if ( trigger == ALARM_TIME_MET ) state = WAKE_UP;   //When the alarm time has been met, the pillow begin to wake you up
    break;
  case SHOW_ALARM_TIME:
    if ( trigger == TIME_OUT ) {   // After 5s of inactivity, the clock returns to default mode
      if ( !alarm ) state = SHOW_TIME;
      else state = SHOW_TIME_ALARM_ON; 
    }
    break;
  case SET_ALARM_HOUR:
    if ( trigger == KEYPAD_SELECT ) state = SET_ALARM_MINUTES;  //Accept the hours value
    else if ( trigger == TIME_OUT ) {   // After 5s of inactivity, the clock returns to default mode
      if ( !alarm ) state = SHOW_TIME;
      else state = SHOW_TIME_ALARM_ON; 
    }
    break;
  case SET_ALARM_MINUTES:
    if ( trigger == KEYPAD_SELECT ) {   //Accept the minutes value and turn the alarm on
      alarm = true; 
      state = SHOW_TIME_ALARM_ON; 
    }
    else if ( trigger == TIME_OUT ) {   // After 5s of inactivity, the clock returns to default mode
      if ( !alarm ) state = SHOW_TIME;
      else state = SHOW_TIME_ALARM_ON; 
    }
    break;
  case WAKE_UP:
    if ( trigger == KEYPAD_UP || trigger == KEYPAD_DOWN ) {     // Snooze for another 10m 
      snooze(); 
      state = SHOW_TIME_ALARM_ON; 
    }
    if ( trigger == KEYPAD_SELECT || trigger == KEYPAD_LEFT ) {   // Turn off the alarm and the pillow
       alarm = false; 
       state = SHOW_TIME; 
    }
    break;
  }
}

// Displays the current date and time, and also an alarm indication
void showTime()
{
  now = RTC.now();
  const char* dayName[] = { 
    "SUN", "MON", "TUE", "WED", "THU", "FRI", "SAT"   };
  const char* monthName[] = { 
    "JAN", "FEB", "MAR", "APR", "MAY", "JUN", "JUL", "AUG", "SEP", "OCT", "NOV", "DEC"   };

  lcd.clear();
  lcd.print(String(dayName[now.dayOfWeek()]) + " " +
    (now.day() < 10 ? "0" : "") + now.day() + " " +
    monthName[now.month()-1] + " " + now.year());
  lcd.setCursor(0,1);
  lcd.print((now.hour() < 10 ? "0" : "") + String(now.hour()) + ":" +
    (now.minute() < 10 ? "0" : "") + now.minute() + ":" +
    (now.second() < 10 ? "0" : "") + now.second() + (alarm ? "  ALARM" : ""));
}

// Display the current alarm time and transitions back to show 
// date and time after 2 sec (+ 1 sec delay from inside the loop function)
void showAlarmTime()
{
  lcd.clear();
  lcd.print("Alarm Time");
  lcd.setCursor(0,1);
  lcd.print(String("HOUR: ") + ( alarmHours < 9 ? "0" : "" ) + alarmHours + 
    " MIN: " + ( alarmMinutes < 9 ? "0" : "" ) + alarmMinutes);
  delay(2000);
  transition(TIME_OUT);
}

// Checks if the alarm time has been met, 
// and if so initiates a state transition
void checkAlarmTime()
{
  if ( now.hour() == alarmHours && now.minute() == alarmMinutes ) transition(ALARM_TIME_MET);
}

// When it is time to wake up, a snooze minutes delay on the alarm time happens by pressing the UP or DOWN buttons
void snooze()
{
  alarmMinutes += SNOOZE;
  if ( alarmMinutes > 59 )
  {
    alarmHours += alarmMinutes / 60;
    alarmMinutes = alarmMinutes % 60;
  }
}

// Set the alarm time hour. If not provided within 5 sec, time out and returns to previous state
void setAlarmHours()
{
  unsigned long timeRef;
  boolean timeOut = true;

  lcd.clear();
  lcd.print("Alarm Time");

  tmpHours = 0;
  timeRef = millis();
  lcd.setCursor(0,1);
  lcd.print("Set hours:  0");

  while ( (unsigned long)(millis() - timeRef) < 5000 )
  {
    int button = lcd.button();

    if ( button == KEYPAD_UP )  // Increase hours
    {
      tmpHours = tmpHours < 23 ? tmpHours + 1 : tmpHours;
      lcd.setCursor(11,1);
      lcd.print("  ");
      lcd.setCursor(11,1);
      if ( tmpHours < 10 ) lcd.print(" ");
      lcd.print(tmpHours);
      timeRef = millis();
    }
    else if ( button == KEYPAD_DOWN )  // Decrease hours
    {
      tmpHours = tmpHours > 0 ? tmpHours - 1 : tmpHours;
      lcd.setCursor(11,1);
      lcd.print("  ");
      lcd.setCursor(11,1);
      if ( tmpHours < 10 ) lcd.print(" ");
      lcd.print(tmpHours);
      timeRef = millis();
    }
    else if ( button == KEYPAD_SELECT )  // Accept the hours value
    {
      while ( lcd.button() != KEYPAD_NONE ) ;
      timeOut = false;
      break;
    }
    delay(150);
  }

  if ( !timeOut ) transition(KEYPAD_SELECT);
  else transition(TIME_OUT);
}

// Set the alarm time minutes. If not provided within 5 sec, time out and returns to a previous state
// If minutes are provided, set the alarm time and turn the alarm on
void setAlarmMinutes()
{
  unsigned long timeRef;
  boolean timeOut = true;
  int tmpMinutes = 0;

  lcd.clear();
  lcd.print("Alarm Time");

  timeRef = millis();
  lcd.setCursor(0,1);
  lcd.print("Set minutes:  0");

  while ( (unsigned long)(millis() - timeRef) < 5000 )
  {
    int button = lcd.button();

    if ( button == KEYPAD_UP )  // Increase minutes
    {
      tmpMinutes = tmpMinutes < 58 ? tmpMinutes + 2 : tmpMinutes;
      lcd.setCursor(13,1);
      lcd.print("  ");
      lcd.setCursor(13,1);
      if ( tmpMinutes < 10 ) lcd.print(" ");
      lcd.print(tmpMinutes);
      timeRef = millis();
    }
    else if ( button == KEYPAD_DOWN )  // Decrease minutes
    {
      tmpMinutes = tmpMinutes > 0 ? tmpMinutes - 2 : tmpMinutes;
      lcd.setCursor(13,1);
      lcd.print("  ");
      lcd.setCursor(13,1);
      if ( tmpMinutes < 10 ) lcd.print(" ");
      lcd.print(tmpMinutes);
      timeRef = millis();
    }
    else if ( button == KEYPAD_SELECT )  // Accept the minutes value
    {
      while ( lcd.button() != KEYPAD_NONE ) ;
      timeOut = false;
      break;
    }
    delay(150);
  }

  if ( !timeOut )
  {
    alarmHours = tmpHours;
    alarmMinutes = tmpMinutes;
    transition(KEYPAD_SELECT);
  }
  else transition(TIME_OUT);
}

// When it is time to wake up, turn buzzer, LED and motor on, 
// which will stop if the head does not touch the button inserted in the pillow any more
void wakeUp()
{
  int melody[] = {
    NOTE_C3, NOTE_G3, NOTE_G3, NOTE_FS3, NOTE_G3, NOTE_GS3, NOTE_G3, NOTE_F3, NOTE_C4, 
    NOTE_F3, NOTE_C4, NOTE_C4, NOTE_B3, NOTE_C4, NOTE_D4, NOTE_C4, NOTE_DS4, 
    NOTE_G4, NOTE_C4, NOTE_C4, NOTE_D4, NOTE_DS4, NOTE_D4, NOTE_C4, NOTE_F4, NOTE_C4, 
    NOTE_C4, NOTE_D4, NOTE_DS4, NOTE_DS4, NOTE_F4, NOTE_D4, NOTE_D4, NOTE_DS4, NOTE_C4, 
    NOTE_C4, NOTE_D4, NOTE_B3, NOTE_GS3, NOTE_G3, NOTE_C4     };

  // note durations: 4 = quarter note, 2 = eighth note, etc.
  int noteDurations[] = {
    2, 4, 2, 1, 1, 4, 2, 2, 14, 
    2, 4, 2, 1, 1, 4, 2, 16, 
    2, 4, 2, 2, 2, 2, 2, 2, 12, 
    1, 1, 2, 1, 1, 2, 1, 1, 2, 
    1, 1, 2, 1, 1, 16     };
  
  // Display the words and alarm time
  lcd.clear();
  lcd.print("Wake Up Now !");
  lcd.setCursor(0,1);
  lcd.print(String("HOUR: ") + ( alarmHours < 9 ? "0" : "" ) + alarmHours + 
    " MIN: " + ( alarmMinutes < 9 ? "0" : "" ) + alarmMinutes);  
  int button = lcd.button();
  
  // Play the music with LED blinking and vibration 
  for ( int i = 0; i < 41; i++ ) 
  {
    if(digitalRead(BUTTON_PIN) == HIGH)  // If someone is sleeping, the button will be pressed
    {    
      int noteDuration = noteDurations[i] * 60;
      tone(BUZZER_PIN, melody[i]);
      digitalWrite(LED_PIN, HIGH);
      delay(noteDuration);

      int pauseBetweenNotes = noteDuration * 0.7;
      digitalWrite(LED_PIN, LOW);
      noTone(BUZZER_PIN);
      delay(pauseBetweenNotes);
      
      digitalWrite(MOTOR_PIN, HIGH); 
    }
    else  // When nobody is sleeping, the button is released
    {
      i = 41;
      noTone(BUZZER_PIN);
      digitalWrite(LED_PIN, LOW);
      digitalWrite(MOTOR_PIN, LOW);      
    }
  }
}


