import java.util.Collections;
Camera cam = new Camera();
PVector a = new PVector (100, 0, 0);
PVector b = new PVector (-100, 0, 0);
PVector c = new PVector (100, 100, 0);
Triangle one = new Triangle(a, b, c, color(0));

void setup () {
  size(400, 400);
  cam.addTriangle(one);
  cam.display();
}
