import java.util.Collections;
Camera cam = new Camera();
PVector a = new PVector (100, 100, 0);
PVector b = new PVector (-100, 0, 0);
PVector c = new PVector (100, 0, 0);
Triangle one = new Triangle(a, b, c, color(0, 10));

void setup () {
  Sphere s = new Sphere (new PVector(0, 0, 0), 100, color(200, 0, 0), 20, 20);
  s.addToCamera(cam);
  size(400, 400);
  cam.addTriangle(one);
}
void draw () {
  background(255);
  cam.display();
  fill(0);
  cam.proj(a);
  cam.proj(b);
  cam.proj(c);
}

void keyPressed() {
  switch(key) {
  case 'j':
    cam.rotateY(10);
    break;
  case 'l':
    cam.rotateY(-10);
    break;
  case 'i':
    cam.rotateX(-10);
    break;
  case 'k':
    cam.rotateX(10);
    break;
  }
}
