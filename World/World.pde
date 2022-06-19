import java.util.Collections;
Camera cam = new Camera();
PVector a = new PVector (100, 100, 100);
PVector b = new PVector (-100, 0, 100);
PVector c = new PVector (100, 0, 100);
Triangle one = new Triangle(c, c, c, color(0, 10));

void setup () {
  Sphere s = new Sphere (new PVector(0, 0, 400), 100, color(200, 0, 0), 20, 20);
  s.addToCamera(cam);
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
  //showVisualization();
  cam.display();
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
  }
}
