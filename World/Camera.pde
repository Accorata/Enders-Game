public class Camera {
  private ArrayList<Triangle> Triangles = new ArrayList<Triangle>();
  private PVector pos;
  private PVector vel;
  final float sight = 300;
  private PVector viewX = new PVector(1, 0, 0);
  private PVector viewY = new PVector(0, 1, 0);
  private PVector viewZ = new PVector(0, 0, 1);

  public Camera() {
    this.pos = new PVector(0, 0, 0);
    this.vel = new PVector(0, 0, 0);
  }

  public void display() {
    for (Triangle t : Triangles) {
      t.updateClose();
    }
    Collections.sort(Triangles);
    for (Triangle t : Triangles) {
      //noStroke();
      projTri(t);
    }
    for (Tether t : tethers) {
      PVector one = projPoint(t.getPos());
      if (one != null) {
        line(one.x, one.y, width-100, height-100);
      }
    }
  }

  private boolean projTri (Triangle t) {
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
    PVector movedPoint = point.copy().sub(pos);
    float rotatedX = movedPoint.dot(viewX.copy().normalize());
    float rotatedY = movedPoint.dot(viewY.copy().normalize());
    float rotatedZ = movedPoint.dot(viewZ.copy().normalize());
    PVector ans = new PVector (0, 0);
    if (rotatedZ > 0) {
      ans.x = (sight * -rotatedX/rotatedZ)+width/2;
      ans.y = (sight * -rotatedY/rotatedZ)+height/2;
    } else {
      return null;
    }
    return ans;
  }
  public void addTriangle (Triangle a) {
    Triangles.add(a);
  }
  public void rotateX (float deg) {
    viewY = rotateOn(viewY, viewX, deg);
    viewZ = rotateOn(viewZ, viewX, deg);
    viewX = rotateOn(viewX, viewX, deg);
  }
  public void rotateY (float deg) {
    viewX = rotateOn(viewX, viewY, deg);
    viewZ = rotateOn(viewZ, viewY, deg);
    viewY = rotateOn(viewY, viewY, deg);
  }
  public void rotateZ (float deg) {
    viewX = rotateOn(viewX, viewZ, deg);
    viewY = rotateOn(viewY, viewZ, deg);
    viewZ = rotateOn(viewZ, viewZ, deg);
  }
  public void boost (PVector dir) {
    PVector translated = new PVector(0, 0, 0);
    translated.add(viewX.copy().mult(dir.x));
    translated.add(viewY.copy().mult(dir.y));
    translated.add(viewZ.copy().mult(dir.z));
    vel.add(translated);
  }
  public void move () {
    if (grab) {
      if (vel.mag() < 0.2) {
        vel = new PVector(0, 0, 0);
      } else {
        vel.div(1.1);
      }
    }
    move(vel);
  }
  public void move (PVector dir) {
    pos.add(dir);
    for (Sphere s : world) {
      if (s.isWithin(pos, 0)) {
        pos = s.displace(pos);
        PVector normal = s.getNormal(pos).normalize();
        vel.div(2);
        vel.add(project(vel, normal).setMag(vel.dot(normal)*2));
      }
    }
    //for (Tether t : tethers) {
    //  dir.add(t.force(pos));
    //}
  }
  public boolean attemptGrab () {
    boolean grabbed = false;
    for (Sphere s : world) {
      if (s.isWithin(pos, 20)) {
        grabbed = true;
        break;
      }
    }
    return grabbed;
  }
}
