public class Camera {
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
    for (Sphere s : world) {
      s.addToCamera(cam);
    }
    for (Tether t : tethers) {
      t.addToCamera(cam);
    }
    Collections.sort(triangles);
    strokeWeight(1);
    //noStroke();
    for (Triangle t : triangles) {
      projTri(t);
      t.light = 0;
    }
    int i = triangles.size()-1;
    while (i >= 0 && triangles.get(i).close < 200) {
      triangles.get(i).light = 100-triangles.get(i).close/2;
      i--;
    }
    stroke(0);
    for (Tether t : tethers) {
      PVector one = projPoint(t.getPos());
      if (one != null) {
        strokeWeight(sigmoid(t.displacement/-4)*1.5);
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
    color c = darken(t.clr, 100-t.light);
    fill(c);
    stroke(c);
    triangle(points.get(0).x, points.get(0).y, points.get(1).x, points.get(1).y, points.get(2).x, points.get(2).y);
    return true;
  }
  private PVector projPoint(PVector point) {
    PVector movedPoint = point.copy().sub(pos);
    float rotatedZ = movedPoint.dot(viewZ.copy().normalize());
    if (rotatedZ < 0) return null;
    float rotatedX = movedPoint.dot(viewX.copy().normalize());
    float rotatedY = movedPoint.dot(viewY.copy().normalize());
    PVector ans = new PVector (0, 0);
    ans.x = (sight * -rotatedX/rotatedZ)+width/2;
    ans.y = (sight * -rotatedY/rotatedZ)+height/2;
    return ans;
  }
  public void displayUI() {
    strokeWeight(2);
    stroke(0);
    line(width/2-20, height/2, width/2+20, height/2);
    line(width/2, height/2-20, width/2, height/2+20);
    noFill();
    circle(width/2, height/2, 700);
    Sphere closest = cam.checkNear();
    near = (closest != null);
    if (near) {
      PVector norm = closest.center;
      PVector translated = projPoint(norm);
      //new PVector(0, 0, 0);
      //translated.add(viewX.copy().mult(norm.x));
      //translated.add(viewY.copy().mult(norm.y));
      //translated.add(viewZ.copy().mult(norm.z));
      //if (translated
      if (translated != null) {
        line(width/2, height/2, translated.x, translated.y);
      }
    }
    fill(0);
    text(""+near, 100, 100);
  }
  public void addTriangle (Triangle a) {
    triangles.add(a);
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
  public void setDirTowards (PVector dir, float speed) {
    vel.div(1.1);
    vel.add(dir.setMag(speed));
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
    for (Tether t : tethers) {
      if (t.attached) {
        dir.add(t.force(pos));
      }
    }
  }
  public Sphere checkNear () {
    for (Sphere s : world) {
      if (s.isWithin(pos, 20)) {
        return s;
      }
    }
    return null;
  }
  public boolean attemptGrab () {
    boolean grabbed = false;
    if (near) grabbed = true;
    return grabbed;
  }
}
