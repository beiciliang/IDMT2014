

import processing.serial.*;
import ddf.minim.*;
import ddf.minim.analysis.*;

Serial myPort; // The serial port
Minim minim;
AudioPlayer song;
BeatDetect beat;
BeatListener bl;

int xPos = 1; // horizontal position of the graph
float oldHeartrateHeight = 0; // for storing the previous reading
int x1 = 'N', x2 = 'N', x3 = 'N';
float kickSize, snareSize, hatSize;

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
  // set the window size:
  size(600, 400);
  frameRate(25);

  // List available serial ports.
  println(Serial.list());

  // Setup which serial port to use.
  // This line might change for different computers.
  myPort = new Serial(this, Serial.list()[3], 9600);

  // set inital background:
  background(0);

  minim = new Minim(this);
  song = minim.loadFile("marcus_kellis_theme.mp3", 1024);
  song.play();
  // a beat detection object that is FREQ_ENERGY mode that 
  // expects buffers the length of song's buffer size
  // and samples captured at songs's sample rate
  beat = new BeatDetect(song.bufferSize(), song.sampleRate());
  // set the sensitivity to 300 milliseconds
  // After a beat has been detected, the algorithm will wait for 300 milliseconds 
  // before allowing another beat to be reported. You can use this to dampen the 
  // algorithm if it is giving too many false-positives. The default value is 10, 
  // which is essentially no damping. If you try to set the sensitivity to a negative value, 
  // an error will be reported and it will be set to 10 instead. 
  beat.setSensitivity(50); 
  // make a new beat listener, so that we won't miss any buffers for the analysis
  bl = new BeatListener(beat, song); 

  kickSize = snareSize = hatSize = 16;
  textFont(createFont("Helvetica", 16));
  textAlign(CENTER, BOTTOM);
}

void draw () {  
  fill(0);
  rect(width/8, 9*height/10-40, 3*width/4, 40);

  if (beat.isKick()) {
    x1 = 'K';
    kickSize = 32;
  } else {
    x1 = 'N';
  }
  if (beat.isSnare()) {
    x2 = 'S';
    snareSize = 32;
  } else {
    x2 = 'N';
  }
  if (beat.isHat()) {
    x3 = 'H';
    hatSize = 32;
  } else {
    x3 = 'N';
  }
  byte arrayX[] = new byte[3];
  arrayX[0] = byte(x1);
  arrayX[1] = byte(x2);
  arrayX[2] = byte(x3);
  myPort.write (arrayX);

  fill(255);
  textSize(kickSize);
  text("KICK", width/4, 9*height/10);
  textSize(snareSize);
  text("SNARE", width/2, 9*height/10);
  textSize(hatSize);
  text("HAT", 3*width/4, 9*height/10);
  kickSize = constrain(kickSize * 0.95, 16, 32);
  snareSize = constrain(snareSize * 0.95, 16, 32);
  hatSize = constrain(hatSize * 0.95, 16, 32);
}

void serialEvent (Serial myPort) {
  // read the string from the serial port.
  String inString = myPort.readStringUntil('\n');

  if (inString != null) {
    // trim off any whitespace:
    inString = trim(inString);
    // convert to an int
    println(inString);
    int currentHeartrate = int(inString);

    // draw the Heartrate BPM Graph.
    float heartrateHeight = map(currentHeartrate, 0, 1023, 0, height-120);
    stroke(0, 255, 0);
    line(xPos - 1, height-120 - oldHeartrateHeight, xPos, height-120 - heartrateHeight);
    oldHeartrateHeight = heartrateHeight;
    // at the edge of the screen, go back to the beginning:
    if (xPos >= width) {
      xPos = 0;
      background(0);
    } else {
      // increment the horizontal position:
      xPos++;
    }
  }
}

