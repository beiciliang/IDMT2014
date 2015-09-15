/*
 * Peak-detect
 *
 * Look for peaks in incoming analog sensor data, and send
 * a trigger when we find them. Can be used with different
 * types of sensors and modified to suit various purposes.
 *
 * This is intended to be used with the 
 * serial_peak_trigger Max patch.
 *
 * ECS742P IDMT, Autumn 2014
 * Andrew McPherson, Queen Mary University of London
 */
 
int sensorPin = 0;        // Pin to read from
int previousSample = 0;   // Value of the sensor the last time around

// For method 2 only
int threshold = 500; 
int previousState = 0;
int hysteresis = 50;

// For method 3 only
int peakValue = 0;
int thresholdToTrigger = 300;
int amountBelowPeak = 100;
int rolloffRate = 1;
int triggered = 0;

void setup() {
  Serial.begin(9600);  // Turn on the serial port
}

void loop() {
  int currentSample = analogRead(sensorPin);
  
  // METHOD 2: Thresholding with hysteresis
  /*if(previousState == 0) {
    // Previous state was below the threshold
    if(currentSample > threshold + hysteresis) {
      // State crossed the threshold in the positive direction. Send trigger.
      previousState = 1;
      Serial.println("800");
    }
  }
  else {
    if(currentSample < threshold - hysteresis)
      previousState = 0;  
  }*/
  
  // METHOD 3: peak detection. Look for a downward trend in the data
  // when the current value is above a minimum threshold. A decrease from
  // the last sample to this one means the last sample was a peak. We use
  // the threshold to make sure the peak was sufficiently high to not just
  // be noise. The disadvantage here is that the triggering is slower since
  // we have to wait for *after* the peak passes to figure out it happened.
  // But the advantage is that we can measure its exact height.
  
  if(currentSample >= peakValue) { // Record the highest incoming sample
    peakValue = currentSample;
    triggered = 0;
  }
  else if(peakValue >= rolloffRate) // But have the peak value decay over time
    peakValue -= rolloffRate;       // so we can catch the next peak later
    
  if(currentSample < peakValue - amountBelowPeak && peakValue >= thresholdToTrigger
     && !triggered) {
    Serial.println(peakValue);
    triggered = 1; // Indicate that we've triggered and wait for the next peak before triggering
                   // again.
  }
  
  delay(1);
}
