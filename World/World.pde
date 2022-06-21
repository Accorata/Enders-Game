import java.util.Collections;
public Camera cam = new Camera();
public ArrayList<Sphere> world = new ArrayList<Sphere>(); 
public ArrayList<Tether> tethers = new ArrayList<Tether>();
PVector a = new PVector (100, 100, 100);
PVector b = new PVector (-100, 0, 100);
PVector c = new PVector (100, 0, 100);
Triangle one = new Triangle(c, c, c, color(0, 10));
PVector dir = new PVector(0, 0, 0);
float speed = 0.01;
final boolean test = false;
public boolean grab = false;


void setup () {
  //tethers.add(new Tether(cam.pos.copy()));
  //Sphere outside = new Sphere (new PVector(0, 0, 0), 10000, color(255), 20, 20);
  Sphere s = new Sphere (new PVector(0, 0, 400), 100, color(200, 0, 0), 20, 20);
  Sphere s2 = new Sphere (new PVector(-200, 0, 600), 100, color(200, 0, 0), 20, 20);
  //outside.addToCamera(cam);
  addToWorld(s);
  addToWorld(s2);
  size(800, 800);
  //cam.addTriangle(one);
  if (test) {
    speed *=1000;
  }
}
PVector sight = new PVector(0, -300);
PVector xAxis = new PVector(-150, 0);
PVector xAxisInv;
PVector sightInv;
//PVector yAxis = new PVector(0, -150, 0);
//Tether thing = new Tether(new PVector(100, 100, 100));
void draw () {
  background(255);
  cam.display();
  //showVisualization();
  if (!test) {
    cam.boost(dir);
    cam.move();
  } else {
    cam.move(dir);
  }

  //println(cam.num);
  //println(frameRate);
}

void keyPressed() {
  switch(key) {
  case 'j':
    cam.rotateY(-10);
    rotateAxisOnZ(sight, -5);
    rotateAxisOnZ(xAxis, -5);
    break;
  case 'l':
    cam.rotateY(10);
    rotateAxisOnZ(sight, 5);
    rotateAxisOnZ(xAxis, 5);
    break;
  case 'i':
    cam.rotateX(10);
    break;
  case 'k':
    cam.rotateX(-10);
    break;
  case 'w':
    dir.z = speed;
    break;
  case 's':
    dir.z = -speed;
    break;
  case 'a':
    dir.x = speed;
    break;
  case 'd':
    dir.x = -speed;
    break;
    //case 'u':
    //  cam.rotateZ(-10);
    //  break;
    //case 'o':
    //  cam.rotateZ(10);
    //  break;
  case 'g':
    grab = cam.attemptGrab();
    break;
  case 't':
    Tether teth = new Tether(cam.pos.copy());
    tethers.add(teth);
    for (Triangle t : teth.calcTriangles()) {
      cam.addTriangle(t);
    }
    break;
  case 'r':
    tethers = new ArrayList<Tether>();
    break;
  case 'v':
    cam.vel = new PVector(0, 0, 0);
    break;
  }
}
void keyReleased () {
  switch(key) {
  case 'w':
    dir.z = 0;
    break;
  case 's':
    dir.z = 0;
    break;
  case 'a':
    dir.x = 0;
    break;
  case 'd':
    dir.x = 0;
    break;
  case 'g':
    grab = false;
    break;
  }
}
