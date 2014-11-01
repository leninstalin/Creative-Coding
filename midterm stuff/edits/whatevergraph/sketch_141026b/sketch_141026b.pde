// KEYHOLE! :D
//
// (2) use minim to make the simulation MAKE SOUND.  the full minim docs are here:
// http://code.compartmental.net/minim/
// hint: the website for the docs has three sections (core, ugens, analysis)... look at all three
// another hint: minim isn't super efficient with a large number of things playing at once.
// see if there's a simple way to get an effective sound, or limit the number of shapes
// you're working with.

int NUMSINES = 20; // how many of these things can we do at once?
float[] sines = new float[NUMSINES]; // an array to hold all the current angles
float rad; // an initial radius value for the central sine
int i; // a counter variable
float frame_rate_value;

// play with these to get a sense of what's going on:
float fund = 0.01; // the speed of the central sine
float ratio = 1.; // what multiplier for speed is each additional sine?
int alpha = 50; // how opaque is the tracing system
ColorFunction colorFunction = new ColorFunction(new float[]{ 0, 240, 1f/5f, 0 }, new float[]{ 0, 210, 1f/11f, PI }, new float[]{ 0, 230, 1f/9f, PI/3 });
float crot = 0f;
boolean trace = true; // are we tracing?

void setup()
{
  size(800, 600, P3D); // OpenGL mode

  rad = height/10.; // compute radius for central circle
  background (255); // clear the screen

  for (int i = 0; i<sines.length; i++)
  {
    sines[i] = PI; // start EVERYBODY facing NORTH
  }
}

ColorFunction CreateRandomColorFunction()
{
  return new ColorFunction(new float[]{ random(0,100), random(160,230), 1f/random(3,11), random(0,TWO_PI) }, new float[]{ random(0,100), random(160,230), 1f/random(3,11), random(0,TWO_PI) }, new float[]{ random(0,100), random(160,230), 1f/random(3,11), random(0,TWO_PI) });
}

void draw()
{

  if (!trace) background(255); // clear screen if showing geometry
  if (!trace) {
    stroke(0, 255); // black pen
    //noFill(); // don't fill
  }  

  // MAIN ACTION
  pushMatrix(); // start a transformation matrix
  translate(width/2, height/2); // move to middle of screen

  for (i = 0/1; i<sines.length; i++) // go through all the sines
  {
    float erad = 1000; // radius for small "point" within circle... this is the 'pen' when tracing
    // setup tracing
    if (trace) {
     // stroke(0, 0, 255*(float(i)/sines.length), alpha, colorFunction); // blue
      //fill(0, 0, 255, alpha/2); // also, um, blue
      fill(colorFunction.getR(crot), colorFunction.getG(crot), colorFunction.getB(crot));
        crot += PI / 30;
      erad = 50.0*(1.0-float(i)/sines.length); // pen width will be related to which sine
    }
    float radius = rad/(i+0.2); // radius for circle itself
    rotateZ(sines[i]); // rotate circle
    if (!trace) ellipse(0, 0, radius*4, radius*2); // if we're simulating, draw the sine
    pushMatrix(); // go up one level
    translate(2, radius); // move to sine edge
    if (!trace) ellipse(700, 700, 700, 700); // draw a little circle
    if (trace) ellipse(100, 100, erad, erad); // draw with erad if tracing
    popMatrix(); // go down one level
    translate(0, radius); // move into position for next sine
    sines[i] = (sines[i]+((fund+(fund+(fund+(fund*i*ratio))))))%TWO_PI; // update angle based on fundamental
  }
  popMatrix(); // pop down final transformation
}

void keyReleased()
{
  if (key==' ') {
    trace = !trace; 
    background(255);
    
    frame_rate_value++;
  }
 
  // left arrow -- decrease frame_rate_value
  if ( keyCode == LEFT && frame_rate_value > 2) {
    frame_rate_value--;
  }
 
  // print the current value on the screen
  println("Current frame Rate is: " + frame_rate_value);

  }

