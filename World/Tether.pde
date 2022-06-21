public class Tether {
  private float len = 100;
  private float springConst = 0.0001;
  private PVector pos;
  private PVector dir;
  private PVector[] points = new PVector[3];
  private ArrayList<Triangle> triangles;

  public Tether (PVector pos_) {
    points[0] = new PVector(0, 4, 0);
    points[1] = new PVector(sqrt(3)*2, -2, 0);
    points[2] = new PVector(-sqrt(3)*2, -2, 0);
    this.dir = new PVector(0, 0, 4);
    this.pos = pos_;
    this.triangles = calcTriangles();
  }
  
  public ArrayList<Triangle> calcTriangles () {
    ArrayList<Triangle> ts = new ArrayList<Triangle>();
    ts.add(new Triangle(points[0].copy().div(-3).add(pos), points[1].copy().div(-3).add(pos), points[2].copy().div(-3).add(pos), color(0)));
    ts.add(new Triangle(points[0].copy().add(pos), points[1].copy().div(-3).add(pos), points[2].copy().div(-3).add(pos), color(0)));
    ts.add(new Triangle(points[0].copy().div(-3).add(pos), points[1].copy().add(pos), points[2].copy().div(-3).add(pos), color(0)));
    ts.add(new Triangle(points[0].copy().div(-3).add(pos), points[1].copy().div(-3).add(pos), points[2].copy().add(pos), color(0)));
    ts.add(new Triangle(points[0].copy().div(-3).add(pos), pos.copy().add(dir), points[2].copy().add(pos).add(dir), color(0)));
    ts.add(new Triangle(points[1].copy().div(-3).add(pos), pos.copy().add(dir), points[2].copy().add(pos).add(dir), color(0)));
    return ts;
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
