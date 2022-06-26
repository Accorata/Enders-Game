import java.util.Collections;
public Camera cam;
public ArrayList<Sphere> world = new ArrayList<Sphere>(); 
public ArrayList<Tether> tethers = new ArrayList<Tether>();
public ArrayList<Triangle> triangles = new ArrayList<Triangle>();
PVector dir = new PVector(0, 0, 0);
float speed = 0.01;
final boolean test = false;
public boolean grab = false;
public boolean near = false;

void setup () {
  size(800, 800);
  cam = new Camera(width, height);
  //tethers.add(new Tether(cam.pos.copy()));
  //Sphere outside = new Sphere (new PVector(0, 0, 0), 10000, color(255), 20, 20);
  Sphere s = new Sphere (new PVector(0, 0, 400), 100, color(200, 0, 0), 10, 20);
  Sphere s2 = new Sphere (new PVector(-200, 0, 600), 100, color(200, 0, 0), 10, 20);
  //outside.addToCamera(cam);
  addToWorld(s);
  //println(triangles.size());
  addToWorld(s2);
  
  //cam.addTriangle(one);
  if (test) {
    speed *=1000;
  }
}

void draw () {
  background(255);
  cam.display();
  cam.displayUI();
  //showVisualization();
  boolean push = near;
  if (push) dir.mult(10);
  //if (dir.mag() < speed*2) dir.div(10);
  if (!test) {
    cam.boost(dir);
    cam.move();
  } else {
    cam.move(dir);
  }
  if (push) dir.div(10);
  for (Tether t : tethers) {
    t.update();
  }
  println(frameRate+"   "+triangles.size());
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
  case 'u':
    cam.rotateZ(10);
    break;
  case 'o':
    cam.rotateZ(-10);
    break;
  case 'g':
    grab = cam.attemptGrab();
    break;
  case 't':
    Tether teth = new Tether(cam.pos.copy(), cam.viewZ.copy().mult(2));
    tethers.add(teth);
    break;
  case 'r':
    tethers = new ArrayList<Tether>();
    break;
  case 'f':
    for (Tether t : tethers) {
      if (t.attached) {
        cam.setDirTowards(t.pos.copy().sub(cam.pos), 0.3);
      }
    }
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
