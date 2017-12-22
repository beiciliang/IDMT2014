/*
This goes on the Processing
for use with Arduino example BeatDress

created by Beici Liang, 4 Dec 2014
*/

import processing.serial.*;
// Minim is an audio library downloaded at http://code.compartmental.net/tools/minim/
import ddf.minim.*; 
import ddf.minim.analysis.*;
 
Minim minim;
AudioPlayer song;
BeatDetect beat;
BeatListener bl;
Serial myPort;
 
float kickSize, snareSize, hatSize;
// Default value sent to the Arduino
int x1 = 'N', x2 = 'N', x3 = 'N', x4 = 'N';
// Horizontal position of the heartbeat graph
int positionX = 1;
// Store the previous reading
float oldHeartbeatHeight = 0; 

// Implement an AudioListener so as to call 'detect' on every buffer of audio 
class BeatListener implements AudioListener
{
  private BeatDetect beat;
  private AudioPlayer source;

  BeatListener(BeatDetect beat, AudioPlayer source)
  {
    this.source = source;
    this.source.addListener(this);
    this.beat = beat;
  }

  void samples(float[] samps)
  {
    beat.detect(source.mix);
  }

  void samples(float[] sampsL, float[] sampsR)
  {
    beat.detect(source.mix);
  }
}

void setup () {
  size(1280, 760);
  background(0);
  //frameRate(25);

  minim = new Minim(this);
  song = minim.loadFile("marcus_kellis_theme.mp3", 1024);
  // Create a BeatDetect object that is in FREQ_ENERGY mode that
  // buffers equal to the length of song's buffer size
  // and samples captured at songs's sample rate
  beat = new BeatDetect(song.bufferSize(), song.sampleRate());
  // Set the sensitivity to 50 milliseconds
  // After a beat has been detected, the algorithm will wait for 50 milliseconds 
  // before allowing another beat to be reported. You can use this to dampen the 
  // algorithm if it is giving too many false-positives. The default value is 10, 
  // which is essentially no damping. If you try to set the sensitivity to a negative value, 
  // an error will be reported and it will be set to 10 instead. 
  beat.setSensitivity(50); 
  // Make a new beat listener, so that we won't miss any buffers for the analysis
  bl = new BeatListener(beat, song); 

  kickSize = snareSize = hatSize = 32;
  textFont(createFont("Helvetica", 32));
  textAlign(CENTER, BOTTOM);
  
  // List available serial ports.
  println(Serial.list());
  // Setup which serial port to use.
  myPort = new Serial(this, Serial.list()[3], 9600);
}

void draw () {  

  // Return true if a beat corresponding to the frequency range of a kick/snare/hat drum beat
  // has been detected. And send the results to the serial port.
  if (beat.isKick()) {
    x1 = 'K';
    kickSize = 64;
  } else {
    x1 = 'N';
  }
  if (beat.isSnare()) {
    x2 = 'S';
    snareSize = 64;
  } else {
    x2 = 'N';
  }
  if (beat.isHat()) {
    x3 = 'H';
    hatSize = 64;
  } else {
    x3 = 'N';
  }
  
  byte arrayX[] = new byte[3];
  arrayX[0] = byte(x1);
  arrayX[1] = byte(x2);
  arrayX[2] = byte(x3);
  myPort.write (arrayX);
  
  // Draw text to the screen.
  // The font size will become bigger
  fill(0);
  rect(0, 9*height/10-80, width-1, 80);
  fill(255);
  textSize(kickSize);
  text("KICK", width/4, 9*height/10);
  textSize(snareSize);
  text("SNARE", width/2, 9*height/10);
  textSize(hatSize);
  text("HAT", 3*width/4, 9*height/10);
  kickSize = constrain(kickSize * 0.95, 32, 64);
  snareSize = constrain(snareSize * 0.95, 32, 64);
  hatSize = constrain(hatSize * 0.95, 32, 64);
}

void serialEvent (Serial myPort) {
  // Read the string from the serial port.
  String inString = myPort.readStringUntil('\n');

  if (inString != null) {
    // Trim off any whitespace:
    inString = trim(inString);
    // Convert to an int
    println(inString);
    int currentHeartbeat = int(inString);

    // Draw the heartbeat BPM Graph.
    float heartbeatHeight = map(currentHeartbeat, 0, 1023, 0, 550);
    stroke(0, 255, 0);
    line(positionX - 1, height - 200 - oldHeartbeatHeight, positionX, height - 200 - heartbeatHeight);
    oldHeartbeatHeight = heartbeatHeight;
    // At the edge of the screen, go back to the beginning:
    if (positionX >= width) {
      positionX = 0;
      background(0);
    } 
    else {
      // Increment the horizontal position:
      positionX++;
    }
  }
}

void keyPressed(){
  if ( key == 'r' ) song.rewind();
  if ( key == 'p' ) song.pause();
  if ( key == ' ' ) song.play();
  if ( key == 'l' ) song.loop();
}
  
