import java.util.Collections;
Camera cam = new Camera();
PVector a = new PVector (100, 100, -200000);
PVector b = new PVector (-100, 0, 1000000000);
PVector c = new PVector (100, 0, 0);
Triangle one = new Triangle(a, b, c, color(0, 10));

void setup () {
  size(400, 400);
  cam.addTriangle(one);
  cam.display();
  fill(0);
  cam.proj(a);
  cam.proj(b);
  cam.proj(c);
}
