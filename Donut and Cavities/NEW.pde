PImage img;
PImage back;
PImage bacon;
float x = 2;
float y = 1;
float easing = 0.05; // Numbers 0.0 to 1.0
void setup() { size(1800,1200); smooth(); noStroke(); img = loadImage("ddonut.png"); back = loadImage("texture.jpg"); bacon =loadImage ("BACON.JPG");
}

void draw() { background(back);
float targetX = mouseX; float targetY = mouseY;
           x += (targetX - x) * easing;
              y += (targetY - y) * easing;
              fill(0);
              ellipse(mouseX, mouseY, 100, 100);
              fill(01);
              ellipse(x, y, 200, 200);
              image(img, x, 0);
            }
            
class Timer {
 
  int savedTime;
  int totalTime;
 
  Timer (int tempTotalTime) {
    totalTime=tempTotalTime;
  }
 
  void start() {
    savedTime=millis();
  }
 
  boolean isFinished() {
    int passedTime=millis()-savedTime;
    if (passedTime>totalTime) {
      return true;
    }
    else {
      return false;
    }
  }
} 
