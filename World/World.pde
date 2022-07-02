import java.util.Collections;

public Camera cam;
public Drone currentDrone;
public ArrayList<Object> world = new ArrayList<Object>(); 
public ArrayList<Object> destroyed = new ArrayList<Object>(); 
public ArrayList<Sphere> spheres = new ArrayList<Sphere>();
public ArrayList<Tether> tethers = new ArrayList<Tether>();
public ArrayList<Bullet> bullets = new ArrayList<Bullet>();
public ArrayList<Bullet> destroyedBullets = new ArrayList<Bullet>(); 
PVector dir = new PVector(0, 0, 0);
float speed = 0.01;
final boolean test = false;
public boolean grab = false;
public boolean near = false;

void setup () {
  size(800, 800);
  cam = new Camera();
  world.add(cam);
  Sphere s = new Sphere (new PVector(0, 0, 400), 100, color(200, 0, 0), 10, 20);
  //Sphere s2 = new Sphere (new PVector(-200, 0, 600), 100, color(200, 0, 0), 10, 20);
  addToWorld(s);
  //addToWorld(s2);
  addToWorld(new Sphere (new PVector(-200, 400, 600), 100, color(0, 0, 200), 10, 20));
  if (test) {
    speed *=1000;
  }
}

void draw () {
  destroyed = new ArrayList<Object>(); 
  destroyedBullets = new ArrayList<Bullet>(); 
  background(255);
  for (Object o : world) {
    o.update();
  }
  setLight();
  cam.displayWorld();
  cam.displayUI();
  cam.display(0, 0, width, height);
  if (currentDrone != null) {
    currentDrone.displayWorld();
    currentDrone.display(450, height/2-150, 300, 300);
  }
  //showVisualization();
  println(frameRate);//+"   "+triangles.size());
  for (Object o : destroyed) {
    world.remove(o);
  }
  for (Bullet b : destroyedBullets) {
    bullets.remove(b);
  }
}

void keyPressed() {
  switch(key) {
  case 'j':
    cam.rotateY(-10);
    //rotateAxisOnZ(sight, -5);
    //rotateAxisOnZ(xAxis, -5);
    break;
  case 'l':
    cam.rotateY(10);
    //rotateAxisOnZ(sight, 5);
    //rotateAxisOnZ(xAxis, 5);
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
  case 'z':
    dir.y = speed;
    break;
  case 'x':
    dir.y = -speed;
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
    addToWorld(teth);
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
  case 'y':
    Drone drone = new Drone(cam.pos.copy(), cam.viewZ.copy().mult(2));
    world.add(drone);
    currentDrone = drone;
    break;
  case 'h':
    currentDrone = null;
    break;
  case 'e':
    Bullet bullet = new Bullet(cam.pos.copy().sub(cam.viewX.copy().div(4)).sub(cam.viewY.copy().div(4)), cam.viewZ.copy());
    world.add(bullet);
    bullets.add(bullet);
    break;
  case 'q':
    cam.zoom = true;
    //cam.zoomFactor += 5;
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
  case 'z':
    dir.y = 0;
    break;
  case 'x':
    dir.y = 0;
    break;
  case 'g':
    grab = false;
    break;
  case 'q':
    cam.zoom = false;
    //cam.zoomFactor = 100;
    break;
  }
}
