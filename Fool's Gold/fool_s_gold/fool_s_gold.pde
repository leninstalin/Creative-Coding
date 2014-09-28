/*So, this Processing sketch is basically something Mr.Presley would wear. You can make stars 'stay' on the buckle by clicking, 
but your eyes will hurt anyway, that's for sure.  I have used  this sketch http://www.openprocessing.org/sketch/65590*@* */ 

PImage elvis;
PImage scene;


float elvisX = 0.0;
float elvisY = 0.0;
float elvisA = 0.0;
float elvisS = 1.0;

float elvisXmov = 0.1;
float elvisXmovChg = 0.0;
float elvisYmov = 0.1;
float elvisYmovChg = 0.0;
float elvisArot = 0.1;
float elvisSrat = 0.0;

float initA = 0.0;// initial angle
void setup() {
  size(700, 500);
  smooth();
  background(#1f9990);
  elvis = loadImage("data/stars.png");
  scene = loadImage("data/space.jpg");
  scene = loadImage("data/space.png");

  imageMode(CENTER);

  initElvis();
}

void draw() {

  updateElvis();

  renderElvis();
}

void mousePressed() {
  initElvis();
}

void initElvis() {
  elvisX = width/2;
  elvisY = height/2;
  
  elvisA ++;
  elvisS = 0.50;
  
  initA += 2.0;

  elvisXmov = sin( radians(initA) ) * 5.0;
  elvisXmovChg = random( -0.10, 0.10);
  elvisYmov = cos( radians(initA) ) * 5000.0;
  elvisYmovChg = random( -0.03, 0.03);
  elvisArot = 5.0;
  elvisSrat = random(-0.009, -0.001);
}

void updateElvis() {
  elvisX += elvisXmov;
  elvisY += elvisYmov;
  elvisA += elvisArot;
  elvisS += elvisSrat;

  if (elvisS <= 0.01) {
    initElvis();
  }
  else if ( elvisX < -elvis.width/2 || elvisX >= width + (elvis.width/2)) {
    initElvis();
  }
  else if ( elvisY < -elvis.height/2 || elvisY >= height + (elvis.height/2)) {
    initElvis();
  }
}

void renderElvis() {
  pushMatrix();
  translate(elvisX, elvisY);
  rotate(radians(elvisA));
  image(elvis, 0, 0, elvis.width * elvisS, elvis.height * elvisS );
  popMatrix();
}

