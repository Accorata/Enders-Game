public class Tether {
  private float len = 100;
  private float displacement;
  private float springConst = 0.001;
  private PVector pos;
  private PVector dir;
  private ArrayList<PVector> points;
  private ArrayList<Triangle> triangles;
  private boolean attached = false;

  public Tether (PVector pos_, PVector dir_) {
    this.dir = dir_;
    this.pos = pos_;
    this.points = calcPoints(dir);
    this.triangles = calcTriangles(points);
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
  public void update () {
    if (!attached) {
      pos.add(dir);
      for (PVector point : points) {
        point.add(dir);
      }
      for (Sphere s : world) {
        if (s.isWithin(pos, 0)) {
          this.pos = s.displace(pos);
          attached = true;
          len =  dist(pos, cam.pos);
          if (len < 200) len = 200;
        }
      }
    }
  }
  public void addToCamera (Camera c) {
    for (Triangle t : triangles) {
      t.updateClose(c);
      c.addTriangle(t);
    }
  }
  public PVector force(PVector loc) {
    PVector force = pos.copy().sub(loc);
    this.displacement = force.mag() - len;
    if (displacement < 0) return new PVector(0, 0, 0);
    force.mult(displacement);
    force.mult(springConst);
    return force;
  }
  public PVector getPos() {
    return this.pos.copy().add(this.dir.copy().div(-1.5));
  }
}
