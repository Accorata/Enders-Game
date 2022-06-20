import java.util.Collections;
Camera cam = new Camera();
PVector a = new PVector (100, 100, 100);
PVector b = new PVector (-100, 0, 100);
PVector c = new PVector (100, 0, 100);
Triangle one = new Triangle(c, c, c, color(0, 10));
PVector dir = new PVector(0, 0, 0);
final float speed = 0.01;

void setup () {
  //Sphere outside = new Sphere (new PVector(0, 0, 0), 10000, color(255), 20, 20);
  Sphere s = new Sphere (new PVector(0, 0, 400), 100, color(200, 0, 0), 20, 20);
  Sphere s2 = new Sphere (new PVector(-200, 0, 600), 100, color(200, 0, 0), 20, 20);
  //outside.addToCamera(cam);
  s.addToCamera(cam);
  s2.addToCamera(cam);
  size(800, 800);
  //cam.addTriangle(one);
}
PVector sight = new PVector(0, -300);
PVector xAxis = new PVector(-150, 0);
PVector xAxisInv;
PVector sightInv;
//PVector yAxis = new PVector(0, -150, 0);
void draw () {
  background(255);
  cam.display();
  showVisualization();
  cam.boost(dir);
  cam.move();
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
  }
}
