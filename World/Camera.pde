public class Camera {
  private ArrayList<Triangle> Triangles = new ArrayList<Triangle>();
  private PVector pos;
  private PVector sight = new PVector(0, 0, 300);
  private PVector viewX = new PVector(1, 0, 0);
  private PVector viewY = new PVector(0, 1, 0);

  public Camera() {
    this.pos = new PVector(0, 0, 0);
  }
  
  public void display() {
    for (Triangle t : Triangles) {
      t.update_close();
    }
    Collections.sort(Triangles);
    for (Triangle t : Triangles) {
      proj(t);
    }
  }
  private boolean proj (Triangle t) {
    ArrayList<PVector> points = new ArrayList<PVector>();
    for (PVector point : t.getPoints()) {
      PVector projected = projPoint(point);
      if (projected == null) {
        return false;
      }
      points.add(projected);
    }
    fill(t.clr);
    triangle(points.get(0).x, points.get(0).y, points.get(1).x, points.get(1).y, points.get(2).x, points.get(2).y);
    return true;
  }
  private PVector projPoint(PVector point) {
    PVector fin = new PVector (0, 0);
    float rotatedX = point.dot(viewX.copy().normalize());//+width/2;
    float rotatedY = point.dot(viewY.copy().normalize());//+height/2;
    float rotatedZ = point.dot(sight.copy().normalize());
    if (rotatedZ > 0) {
      fin.x = (sight.mag() * -rotatedX/rotatedZ)+width/2;
      fin.y = (sight.mag() * -rotatedY/rotatedZ)+height/2;
    } else {
      return null;
    }
    return fin;
  }
  public void addTriangle (Triangle a) {
    Triangles.add(a);
  }
  public void rotateX (float deg) {
    rotateAxisOnX(viewX, deg);
    rotateAxisOnX(viewY, deg);
    rotateAxisOnX(sight, deg);
  }
  public void rotateY (float deg) {
    rotateAxisOnY(viewX, deg);
    rotateAxisOnY(viewY, deg);
    rotateAxisOnY(sight, deg);
  }
  public void rotateZ (float deg) {
    rotateAxisOnZ(viewX, deg);
    rotateAxisOnZ(viewY, deg);
    rotateAxisOnZ(sight, deg);
  }
}
