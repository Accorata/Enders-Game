public class Tether implements Object {
  private float len = 100;
  private float displacement;
  private float springConst = 0.001;
  private PVector pos;
  private PVector vel;
  private PVector dir;
  private ArrayList<PVector> points;
  private ArrayList<Triangle> triangles;
  private Object attached = null;

  public Tether (PVector pos_, PVector dir_) {
    this.dir = dir_;
    this.pos = pos_;
    this.points = calcPoints(dir);
    this.triangles = calcTriangles(points);
    this.vel = dir.copy();
  }

  private ArrayList<PVector> calcPoints(PVector dir) {
    PVector p1 = cam.viewY.copy().mult(4);
    PVector p2 = cam.viewX.copy().mult(sqrt(3)*2).add(cam.viewY.copy().mult(-2));
    PVector p3 = cam.viewX.copy().mult(-sqrt(3)*2).add(cam.viewY.copy().mult(-2));
    ArrayList<PVector> ps = new ArrayList<PVector>();
    ps.add(p1.copy().add(pos));
    ps.add(p2.copy().add(pos));
    ps.add(p3.copy().add(pos));
    ps.add(p1.copy().div(-3).add(pos));
    ps.add(p2.copy().div(-3).add(pos));
    ps.add(p3.copy().div(-3).add(pos));
    ps.add(dir.copy().div(-1.5).add(pos));
    ps.add(ps.get(0).copy().add(dir));
    ps.add(ps.get(0).copy().add(ps.get(4)).div(2));
    ps.add(ps.get(0).copy().add(ps.get(5)).div(2));
    ps.add(ps.get(1).copy().add(dir));
    ps.add(ps.get(1).copy().add(ps.get(3)).div(2));
    ps.add(ps.get(1).copy().add(ps.get(5)).div(2));
    ps.add(ps.get(2).copy().add(dir));
    ps.add(ps.get(2).copy().add(ps.get(3)).div(2));
    ps.add(ps.get(2).copy().add(ps.get(4)).div(2));
    return ps;
  }
  private ArrayList<Triangle> calcTriangles (ArrayList<PVector> points) {
    ArrayList<Triangle> ts = new ArrayList<Triangle>();
    color clr = color(100);
    ts.add(new Triangle(points.get(0), points.get(4), points.get(5), clr));
    ts.add(new Triangle(points.get(3), points.get(1), points.get(5), clr));
    ts.add(new Triangle(points.get(3), points.get(4), points.get(2), clr));
    ts.add(new Triangle(points.get(3), points.get(4), points.get(5), clr));
    ts.add(new Triangle(points.get(0), points.get(6), points.get(5), clr));
    ts.add(new Triangle(points.get(0), points.get(4), points.get(6), clr));
    ts.add(new Triangle(points.get(6), points.get(1), points.get(5), clr));
    ts.add(new Triangle(points.get(3), points.get(1), points.get(6), clr));
    ts.add(new Triangle(points.get(6), points.get(4), points.get(2), clr));
    ts.add(new Triangle(points.get(3), points.get(6), points.get(2), clr));
    ts.add(new Triangle(points.get(0), points.get(7), points.get(8), clr));
    ts.add(new Triangle(points.get(0), points.get(7), points.get(9), clr));
    ts.add(new Triangle(points.get(1), points.get(10), points.get(11), clr));
    ts.add(new Triangle(points.get(1), points.get(10), points.get(12), clr));
    ts.add(new Triangle(points.get(2), points.get(13), points.get(14), clr));
    ts.add(new Triangle(points.get(2), points.get(13), points.get(15), clr));
    return ts;
  }
  public void addToCamera (Camera c) {
    for (Triangle t : triangles) {
      t.updateClose(c);
      c.addTriangle(t);
    }
  }
  public ArrayList<Triangle> getTriangles () {
    return this.triangles;
  }
  public void update () {
    if (attached != null) {
      if (attached.moveable()) {
        vel = attached.getVel();
      } else {
        vel = new PVector(0, 0, 0);
      }
    }
    //if (!attached) {
    pos.add(vel);
    for (PVector point : points) {
      point.add(vel);
    }
    for (Sphere s : spheres) {
      if (s.isWithin(pos, 0)) {
        this.pos = s.displace(pos);
        attached = s;
        len =  dist(pos, cam.pos);
        if (len < 200) len = 200;
      }
    }
    //}
    for (Bullet b : bullets) {
      if (b.isWithin(pos, 5)) {
        destroyed.add(this);
        tethers.remove(this);
        destroyed.add(b);
        destroyedBullets.add(b);
      }
    }
  }
  public boolean moveable() {
    if (attached == null) {
      return false;
    }
    return attached.moveable();
  }
  public PVector getPos() {
    return this.pos.copy().add(this.dir.copy().div(-1.5));
  }
  public PVector getVel() {
    return this.vel;
  }
  public void accelerate (PVector a) {
    this.vel.add(a);
  }
  public PVector force(PVector loc) {
    PVector force = pos.copy().sub(loc);
    this.displacement = force.mag() - len;
    if (displacement < 0) return new PVector(0, 0, 0);
    force.mult(displacement);
    force.mult(springConst);
    return force;
  }
}
