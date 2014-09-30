//I found some random code during my endless browsings of Processing galleries and fell in love with it. 
//As you can see, there are so many unsubtle references to Twin Peaks. I don't know how it happened.
// First, you think 'oh, that changing text could be great for a poem'... And then you look for soundtracks and look for a cherry pie.

int offX, offY, offZ;
float ang, spd;
PImage heygirl;
import ddf.minim.*;

AudioPlayer player;
Minim minim;//audio context

 
//variables 
ArrayList verts;
float dispSz, edgeLength;
String strName, strNotes;
int currID;
 

void setup() {
  size(800,600, P3D);
  background(0);
  noStroke();
  lights();
  smooth(100);
  textMode(SCREEN);
  textSize(150);
  heygirl =loadImage("room.jpg");
  minim = new Minim(this);
  player = minim.loadFile("coffee.mp3", 2048);
  player.play();

   
  // positional variables
  offY = height/2;
  offX = offY - 20;
  offZ = -offY;
   
  //angle and speed for rotation
  ang = 0.1;
  spd = 0.05;
   
  //set up initial polyhedron
  verts = new ArrayList();
  currID = 0;
  setupPoly(currID);
}
 
//================================================================
 
void draw() {
  //setup the view
  background(heygirl); 
  translate(offX, offY, offZ);
  rotateX(sin(-ang*0.3)*0.5);
  rotateY(ang);
  drawAxis();
   
  //draw the polyhedron
  strokeWeight(50);
  stroke(0);
  for (int i=0; i<verts.size(); i++)
    for (int j=i + 1; j<verts.size(); j++)
      if (isEdge(i, j))
        vLine((vert)verts.get(i), (vert)verts.get(j));
     
  //show some notes
  fill(0,0,0);
  text(strName, height - 500,500);
  text(strNotes, height - 100, 50);
  text("next...", height - 10, height - 10);
   
  //bump up the angle for the spin
  ang += spd;
}
 
 
void stop()
{
  player.close();
  minim.stop();
  super.stop();
}


void mouseReleased() {
  //change
  setupPoly(++currID);
}
 
 
void vLine(vert v1, vert v2) {
  line(v1.x*dispSz, v1.y*dispSz, v1.z*dispSz, v2.x*dispSz, v2.y*dispSz, v2.z*dispSz);
}
 
//================================================================
 
boolean isEdge(int vID1, int vID2) {
  int pres = 100;
  vert v1 = (vert)verts.get(vID1);
  vert v2 = (vert)verts.get(vID2);
  float d = sqrt(sq(v1.x - v2.x) + sq(v1.y - v2.y) + sq(v1.z - v2.z)) + .00001;
  return (int(d*pres)==int(edgeLength*pres));
 
}
 
 
class vert {
  float x, y, z;
  vert(float xx, float yy, float zz) {
    x = xx;
    y = yy;
    z = zz;
  }
}
 
void addVerts(float x, float y, float z) {
  verts.add (new vert(x, y, z));
  if (z != 0.0) verts.add (new vert(x, y, -z)); 
  if (y != 0.0) {
    verts.add (new vert(x, -y, z));
    if (z != 0.0) verts.add (new vert(x, -y, -z));
  } 
  if (x != 0.0) {
    verts.add (new vert(-x, y, z));
    if (z != 0.0) verts.add(new vert(-x, y, -z));
    if (y != 0.0) {
      verts.add (new vert(-x, -y, z));
      if (z != 0.0) verts.add (new vert(-x, -y, -z));
    }
  }
}
 
 
void addPermutations(float x, float y, float z) {
  addVerts(x, y, z);
  addVerts(z, x, y);
  addVerts(y, z, x);
}
 
void drawAxis() {
  strokeWeight(.5);
  stroke(0, 128, 0);
  line(-300, 0, 0, 0, 0, 0);
  stroke(0, 0, 128);
  line(0, -300, 0, 0, 0, 0);
  stroke(128, 0, 0);
  line(0, 0, -300, 0, 0, 0);
  strokeWeight(.25);
  stroke(0, 128, 0);
  line(300, 0, 0, 0, 0, 0);
  stroke(0, 0, 128);
  line(0, 300, 0, 0, 0, 0);
  stroke(128, 0, 0);
  line(0, 0, 300, 0, 0, 0);
}
 
//================================================================
 
void setupPoly(int id) {
   
  float PHI = (1 + sqrt(5))/2; 
  float ROOT2 = sqrt(2);
   
  verts.clear(); 
   
  switch (id) {
    case 0:
      strName = "1";
      strNotes = "THROUGH";
      addVerts(1, 1, 1);
      edgeLength = 2;
      dispSz = 250;
      break;     
    case 1:
      strName = "2";
      strNotes = "THE DARKNESS";
      addPermutations(1, 0, 0);
      edgeLength = ROOT2;
      dispSz = 250;
      break;     
    case 2:     
      strName = "3";
      strNotes = "OF FUTURE";
      addVerts(1, 1, 1);
      addPermutations(0, 1/PHI, PHI);
      edgeLength = 2/PHI;
      dispSz = 250;
      break;     
    case 3:
      strName = "4";
      strNotes = "PAST";
      addPermutations(0, 1, PHI);
      edgeLength = 2.0;
      dispSz = 250;
      break;     
    case 4:
      strName = "5";
      strNotes = "THE MAGICIAN";
      addVerts(1, 1, 1);
      addPermutations(0, 0, 2);
      edgeLength = sqrt(3);
      dispSz = 250;
      break;     
    case 5:
      strName = "6";
      strNotes = "LONGS";
      addVerts(sq(PHI), sq(PHI), sq(PHI));
      addPermutations(sq(PHI), 0, pow(PHI, 3));
      addPermutations(0, PHI, pow(PHI, 3));
      edgeLength = PHI*sqrt(PHI + 2);
      dispSz = 250;
      break;
    case 6:
      strName = "7";
      strNotes = "TO SEE";
      addPermutations(1, 0, 1);
      edgeLength = ROOT2;
      dispSz = 250;
      break;     
    case 7:
      strName = "8";
      strNotes = "ONCE";
      addPermutations(ROOT2 - 1, 1, 1);
      edgeLength = 2*(ROOT2 - 1);     
      dispSz = 250;
      break;     
    case 8:
      strName = "9";
      strNotes = "CHANTS OUT";
      addPermutations(0, 1, 2);
      addPermutations(2, 1, 0);
      edgeLength = ROOT2;
      dispSz = 250;
      break;     
    case 9:
      strName = "10";
      strNotes = "BETWEEN";
      addPermutations(ROOT2 + 1, 1, 1);
      edgeLength = 2;
      dispSz = 250;
      break;     
    case 10:
      strName = "11";
      strNotes = "TWO";
      addPermutations(ROOT2 + 1, 2*ROOT2 + 1, 1);
      addPermutations(ROOT2 + 1, 1, 2*ROOT2 + 1);
      edgeLength = 2;
      dispSz = 250;
      break;     
    case 11:
      strName = "12";
      strNotes = "WORLDS";
      addPermutations(0, 0, 2*PHI);
      addPermutations(1, PHI, sq(PHI));
      edgeLength = 2;
      dispSz = 250;
      break;     
    case 12:
      strName = "13";
      strNotes = "FIRE";
      addPermutations(0, 1/PHI, PHI + 2);
      addPermutations(1/PHI, PHI, 2*PHI);
      addPermutations(PHI, 2, sq(PHI));
      edgeLength = 2*(PHI - 1);
      dispSz = 250;
      break;     
    case 13:
      strName = "14";
      strNotes = "WALK";
      addPermutations(0, 1, 3*PHI);
      addPermutations(2, 2*PHI + 1, PHI);
      addPermutations(1, PHI + 2, 2*PHI);
      edgeLength = 2;
      dispSz = 250;
      break;     
    case 14:
      strName = "15";
      strNotes = "WITH";
      addPermutations(1, 1, pow(PHI, 3));
      addPermutations(sq(PHI), PHI, 2*PHI);
      addPermutations(PHI + 2, 0, sq(PHI));
      edgeLength = 2;
      dispSz = 250;
      break;     
    case 15:
      strName = "16";
      strNotes = "ME";
      addPermutations(1/PHI, 1/PHI, PHI + 3);
      addPermutations(2/PHI, PHI, 2*PHI + 1);
      addPermutations(1/PHI, sq(PHI), 3*PHI - 1);
      addPermutations(2*PHI - 1, 2, PHI + 2);
      addPermutations(PHI, 3, 2*PHI);
      edgeLength = 2*PHI - 2;
      dispSz = 250;
      break;     
    default :
      currID = 0;
      setupPoly(currID);
  }
}

