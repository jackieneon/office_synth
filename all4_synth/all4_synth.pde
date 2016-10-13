import oscP5.*;
import netP5.*;
OscP5 oscP5;

import processing.sound.*;
SawOsc saw; //1
SinOsc sine; //2
SqrOsc square; //3
TriOsc triangle; //4

//saw
float v_toggle1 = 0.0f;
float v_fader1 = 0.0f;
float v_rotary1 = 0.0f;

//sine
float v_toggle2 = 0.0f;
float v_fader2 = 0.0f;
float v_rotary2 = 0.0f;

//square
float v_toggle3 = 0.0f;
float v_fader3 = 0.0f;
float v_rotary3 = 0.0f;


//triangle
float v_toggle4 = 0.0f;
float v_fader4 = 0.0f;
float v_rotary4 = 0.0f;



boolean needsRedraw = true;
boolean needsRedraw2 = true;
boolean needsRedraw3 = true;
boolean needsRedraw4 = true;


boolean xyPadNeedsRedraw = true;
boolean xyPadNeedsRedraw2 = true;
boolean xyPadNeedsRedraw3 = true;
boolean xyPadNeedsRedraw4 = true;


float xPad1 = 120, yPad1 = 120; 
float xPad2 = 120, yPad2 = 120; 
float xPad3 = 110, yPad3 = 120; 
float xPad4 = 100, yPad4 = 120; 

int [] xyPadStrip = new int [5];
float n;
float l;
float m;
float o;

void setup() {
  size(320, 440);
  //  frameRate(25);

  saw = new SawOsc(this);
  saw.play();
  saw.amp(0.0);

  sine = new SinOsc(this);
  sine.play();
  sine.amp(0.0);   

  square = new SqrOsc(this);
  square.play();
  square.amp(0.0); 

  triangle = new TriOsc(this);
  triangle.play();
  triangle.amp(0.0);       


  /* start oscP5, listening for incoming messages at port 8000 */
  oscP5 = new OscP5(this, 8000);
}

void oscEvent(OscMessage theOscMessage) {

  String addr = theOscMessage.addrPattern();
  float  val  = theOscMessage.get(0).floatValue();

  //saw
  if (addr.equals("/1/toggle1")) { 
    v_toggle1 = val;
  }
  if (addr.equals("/1/fader1")) { 
    v_fader1 = val;
  }
  if (addr.equals("/1/rotary1")) { 
    v_rotary1 = val;
  }

  //sine
  if (addr.equals("/2/toggle2")) { 
    v_toggle2 = val;
  }
  if (addr.equals("/2/fader2")) { 
    v_fader2 = val;
  }
  if (addr.equals("/2/rotary2")) { 
    v_rotary2 = val;
  }

  //square
  if (addr.equals("/3/toggle3")) { 
    v_toggle3 = val;
  }
  if (addr.equals("/3/fader3")) { 
    v_fader3 = val;
  }
  if (addr.equals("/3/rotary3")) { 
    v_rotary3 = val;
  }

  //triangel 
  if (addr.equals("/4/toggle4")) { 
    v_toggle4 = val;
  }
  if (addr.equals("/4/fader4")) { 
    v_fader4 = val;
  }
  if (addr.equals("/4/rotary4")) { 
    v_rotary4 = val;
  }


  needsRedraw = true;
  //saw
  if (addr.indexOf("/1/xy3") !=-1) { // the 8 X Y area
    xPad1 =  (theOscMessage.get(0).floatValue());
    yPad1 =  (theOscMessage.get(1).floatValue());
    //println(" x = "+xPad1+" y = "+yPad1);  // uncomment to see x & Y values
    //println("n=" + xPad1 + yPad1);
    xyPadNeedsRedraw = true;
  }

  needsRedraw2 = true;
  //sine
  if (addr.indexOf("/2/xy4") !=-1) { // the 8 X Y area
    xPad2 =  (theOscMessage.get(0).floatValue());
    yPad2 =  (theOscMessage.get(1).floatValue());
    //println(" x = "+xPad2+" y = "+yPad2);  // uncomment to see x & Y values
    //println("l=" + xPad2 + yPad2);
    xyPadNeedsRedraw2 = true;
  }

  needsRedraw3 = true;
  //square
  if (addr.indexOf("/3/xy5") !=-1) { // the 8 X Y area
    xPad3 =  (theOscMessage.get(0).floatValue());
    yPad3 =  (theOscMessage.get(1).floatValue());
    //println(" x = "+xPad3+" y = "+yPad3);  // uncomment to see x & Y values
    //println("m =" + xPad3 + yPad3);
    xyPadNeedsRedraw3 = true;
  }

  needsRedraw4 = true;
  //triangle
  if (addr.indexOf("/4/xy6") !=-1) { // the 8 X Y area
    xPad4 =  (theOscMessage.get(0).floatValue());
    yPad4 =  (theOscMessage.get(1).floatValue());
    //println(" x = "+xPad4+" y = "+yPad4);  // uncomment to see x & Y values
    //println("o =" + xPad4 + yPad4);
    xyPadNeedsRedraw4 = true;
  }
}

void draw() {
  //println("float m =", m);
  //println("float o =", o);
  //println("float n =", n);
  //println("float l =", l);

  //float n;
  //float l;
  //float m;
  //float o;


  //Saw on/off =================================================================================== 
  if (needsRedraw == true) {
    fill(0);
    stroke(0, 196, 168);  

    rect(17, 369, 60, 50);
    fill(0, 196, 168);

    if (v_toggle1 == 1.0f) {
      rect(22, 374, 50, 40);
    }

    // fader outlines
    fill(0);
    stroke(255, 237, 0);
    rect(17, 95, 60, 255);

    // fader fills
    fill(255, 237, 0);
    rect(17, 95 + 255 - v_fader1*255, 60, v_fader1*255);
    //println(v_fader1);

println("test1");

    needsRedraw = false;

    if (xyPadNeedsRedraw == true) redrawxyPad();  // only redraw the screen if we need to
    n = xPad1 + yPad1;
    println("n is =", n);
    saw.freq(map(n, 0, 2, 80.0, 200.));

//Saw vloume
  saw.amp(v_fader1);
  if (v_toggle1 == 0.0f) {
    saw.amp(0.0);
  }
  saw.pan(v_rotary1);
  println("test2");  

}

  
  //Saw end=====================================================================================

  //Sine========================================================================================    
  //sine on/off
  if (needsRedraw2 == true) {
    fill(0);
    stroke(0, 196, 168);  

    rect(17, 369, 60, 50);
    fill(0, 196, 168);

    if (v_toggle2 == 1.0f) {
      rect(22, 374, 50, 40);
    }

    //Sine wave play
    // fader outlines
    fill(0);
    stroke(255, 237, 0);
    rect(17, 95, 60, 255);

    // fader  fills
    fill(255, 237, 0);
    rect(17, 95 + 255 - v_fader1*255, 60, v_fader1*255);
    //println(v_fader2);

    needsRedraw2 = false;

    if (xyPadNeedsRedraw2 == true) redrawxyPad2();  // only redraw the screen if we need to
    l = xPad2 + yPad2;
    println("l is =", l);
    sine.freq(map(l, 0, 2, 80.0, 400.));

      //Sine vloume 
  sine.amp(v_fader2);
  if (v_toggle2 == 0.0f) {
    sine.amp(0.0);
  }
      sine.pan(v_rotary2);    
println("test3");
  }

  // Sine end ========================================================================================

  //square on/off =================================================================================== 
  if (needsRedraw == true) {
    fill(0);
    stroke(0, 196, 168);  

    rect(17, 369, 60, 50);
    fill(0, 196, 168);

    if (v_toggle3 == 1.0f) {
      rect(22, 374, 50, 40);
    }

    // fader outlines
    fill(0);
    stroke(255, 237, 0);
    rect(17, 95, 60, 255);

    // fader fills
    fill(255, 237, 0);
    rect(17, 95 + 255 - v_fader3*255, 60, v_fader3*255);
    //println(v_fader3);
  }
    needsRedraw3 = false;

    if (xyPadNeedsRedraw3 == true){ redrawxyPad3();  // only redraw the screen if we need to
    m = xPad3 + yPad3;
    println("m is", m);
    square.freq(map(m, 0, 2, 80.0, 200.));
    }
    //square vloume
  square.amp(v_fader3);
  if (v_toggle3 == 0.0f) {
    square.amp(0.0);
  }
  square.pan(v_rotary3);  


  //square end=====================================================================================

  //triangle on/off =================================================================================== 
  if (needsRedraw == true) {
    fill(0);
    stroke(0, 196, 168);  

    rect(17, 369, 60, 50);
    fill(0, 196, 168);

    if (v_toggle4 == 1.0f) {
      rect(22, 374, 50, 40);
    }

    // fader outlines
    fill(0);
    stroke(255, 237, 0);
    rect(17, 95, 60, 255);

    // fader fills
    fill(255, 237, 0);
    rect(17, 95 + 255 - v_fader4*255, 60, v_fader4*255);
    println(v_fader4);
  }
    needsRedraw4 = false;

    if (xyPadNeedsRedraw4 == true){ redrawxyPad4();  // only redraw the screen if we need to
    o = xPad4 + yPad4;
    println("o is", o);
    triangle.freq(map(o, 0, 2, 80.0, 200.));
  }

  //triangle vloume
  triangle.amp(v_fader4);
  if (v_toggle4 == 0.0f) {
    triangle.amp(0.0);
  }
  triangle.pan(v_rotary4);
  //triangle end=====================================================================================
}
//saw
void redrawxyPad() { // redraw the screen
  strokeWeight(2);
  fill(40, 40, 40);
  stroke(250, 250, 0);
  rect(15, 15, 260, 260);  // yellow outline
  noStroke(); 
  int x1 =  int(xPad1*240)+15;
  int y1 =  int(yPad1*240)+15;
  fill(250, 250, 0);
  rect( x1, y1, 20, 20);  // draw square
  stroke(250, 250, 0);
  strokeWeight(1);
  line(x1+10, 15, x1+10, 275);
  line(15, y1+10, 275, y1+10);
  strokeWeight(2);
  // draw the strip at the bottom
  stroke(25, 150, 250);
  for ( int x = 1; x<5; x++) {
    //    fill(40,40,40);
    //    rect( x*60-30, 300, 50, 40);  // draw blank square
    if (xyPadStrip[x] == 1) {     // fill it in if that one is pressed
      fill(25, 150, 250);
      rect( x*60-20, 310, 30, 20);
    }
  }
  xyPadNeedsRedraw = false;  // we have now redrawn it, don't do it again until we have another OSC message
}
//sine
void redrawxyPad2() { // redraw the screen
  strokeWeight(2);
  fill(40, 40, 40);
  stroke(250, 250, 0);
  rect(15, 15, 260, 260);  // yellow outline
  noStroke(); 
  int x2 =  int(xPad2*240)+15;
  int y2 =  int(yPad2*240)+15;
  fill(250, 250, 0);
  rect( x2, y2, 20, 20);  // draw square
  stroke(250, 250, 0);
  strokeWeight(1);
  line(x2+10, 15, x2+10, 275);
  line(15, y2+10, 275, y2+10);
  strokeWeight(2);
  // draw the strip at the bottom
  stroke(25, 150, 250);
  for ( int x = 1; x<5; x++) {
    //    fill(40,40,40);
    //    rect( x*60-30, 300, 50, 40);  // draw blank square
    if (xyPadStrip[x] == 1) {     // fill it in if that one is pressed
      fill(25, 150, 250);
      rect( x*60-20, 310, 30, 20);
    }
  }
  xyPadNeedsRedraw2 = false;  // we have now redrawn it, don't do it again until we have another OSC message
}
//square
void redrawxyPad3() { // redraw the screen
  strokeWeight(2);
  fill(40, 40, 40);
  stroke(250, 250, 0);
  rect(15, 15, 260, 260);  // yellow outline
  noStroke(); 
  int x3 =  int(xPad3*240)+15;
  int y3 =  int(yPad3*240)+15;
  fill(250, 250, 0);
  rect( x3, y3, 20, 20);  // draw square
  stroke(250, 250, 0);
  strokeWeight(1);
  line(x3+10, 15, x3+10, 275);
  line(15, y3+10, 275, y3+10);
  strokeWeight(2);
  // draw the strip at the bottom
  stroke(25, 150, 250);
  for ( int x = 1; x<5; x++) {
    //    fill(40,40,40);
    //    rect( x*60-30, 300, 50, 40);  // draw blank square
    if (xyPadStrip[x] == 1) {     // fill it in if that one is pressed
      fill(25, 150, 250);
      rect( x*60-20, 310, 30, 20);
    }
  }
  xyPadNeedsRedraw3 = false;  // we have now redrawn it, don't do it again until we have another OSC message
}

//truangle
void redrawxyPad4() { // redraw the screen
  strokeWeight(2);
  fill(40, 40, 40);
  stroke(250, 250, 0);
  rect(15, 15, 260, 260);  // yellow outline
  noStroke(); 
  int x4 =  int(xPad4*240)+15;
  int y4 =  int(yPad4*240)+15;
  fill(250, 250, 0);
  rect( x4, y4, 20, 20);  // draw square
  stroke(250, 250, 0);
  strokeWeight(1);
  line(x4+10, 15, x4+10, 275);
  line(15, y4+10, 275, y4+10);
  strokeWeight(2);
  // draw the strip at the bottom
  stroke(25, 150, 250);
  for ( int x = 1; x<5; x++) {
    //    fill(40,40,40);
    //    rect( x*60-30, 300, 50, 40);  // draw blank square
    if (xyPadStrip[x] == 1) {     // fill it in if that one is pressed
      fill(25, 150, 250);
      rect( x*60-20, 310, 30, 20);
    }
  }
  xyPadNeedsRedraw4 = false;  // we have now redrawn it, don't do it again until we have another OSC message
}