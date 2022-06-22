public class Tether {
  private float len = 100;
  private float springConst = 0.0001;
  private PVector pos;
  private PVector dir;
  private ArrayList<PVector> points;
  private ArrayList<Triangle> triangles;

  public Tether (PVector pos_) {
    this.dir = new PVector(0, 0, 2);
    this.pos = pos_;
    this.points = calcPoints(dir);
    this.triangles = calcTriangles(points);
    pos.add(dir.copy().div(-1.5));
  }

  private ArrayList<PVector> calcPoints(PVector dir) {
    PVector p1 = new PVector(0, 4, 0);
    PVector p2 = new PVector(sqrt(3)*2, -2, 0);
    PVector p3 = new PVector(-sqrt(3)*2, -2, 0);
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
  public ArrayList<Triangle> getTriangles () {
    return triangles;
  }
  public PVector force(PVector loc) {
    PVector force = pos.copy().sub(loc);
    float displacement = force.mag() - len;
    if (displacement < 0) return new PVector(0, 0, 0);
    force.mult(displacement);
    force.mult(springConst);
    return force;
  }
  public PVector getPos() {
    return pos;
  }
}
