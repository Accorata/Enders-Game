public class Tether {
  private float len = 100;
  private float springConst = 0.0001;
  private PVector pos;
  private PVector dir;
  private ArrayList<PVector> points;
  private ArrayList<Triangle> triangles;

  public Tether (PVector pos_) {
    this.dir = new PVector(0, 0, 4);
    this.pos = pos_;
    this.points = calcPoints(dir);
    this.triangles = calcTriangles(points);
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
    return ps;
  }

  private ArrayList<Triangle> calcTriangles (ArrayList<PVector> points) {
    ArrayList<Triangle> ts = new ArrayList<Triangle>();
    color clr = color(100);
    //ts.add(new Triangle(points[0].copy().div(-3).add(pos), pos.copy().add(pos).add(dir.copy().div(-2)), points[2].copy(), clr));
    //ts.add(new Triangle(points[1].copy().div(-3).add(pos), pos.copy().add(pos).add(dir.copy().div(-2)), points[2].copy(), clr));
    ts.add(new Triangle(points.get(0), points.get(1), points.get(2), clr));
    //ts.add(new Triangle(points[0].copy().div(-3).add(pos), points[1].copy().div(-3).add(pos), points[2].copy().div(-3).add(pos), clr));
    //ts.add(new Triangle(points[0].copy().add(pos), points[1].copy().div(-3).add(pos), points[2].copy().div(-3).add(pos), clr));
    //ts.add(new Triangle(points[0].copy().div(-3).add(pos), points[1].copy().add(pos), points[2].copy().div(-3).add(pos), clr));
    //ts.add(new Triangle(points[0].copy().div(-3).add(pos), points[1].copy().div(-3).add(pos), points[2].copy().add(pos), clr));
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
