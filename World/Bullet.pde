public class Bullet implements Object {
  ArrayList<PVector> points;
  PVector pos;
  ArrayList<Triangle> triangles;
  PVector vel;

  public Bullet (PVector loc, PVector dir, float speed) {
    this.points = calcPoints(loc, cam.getView());
    this.pos = loc;
    this.triangles = calcTriangles(points, color(0));
    this.vel = dir.mult(speed);
  }

  public void addToCamera (Camera c) {
    for (Triangle t : triangles) {
      c.addTriangle(t);
    }
  }
  public ArrayList<Triangle> getTriangles () {
    return this.triangles;
  }
  public void update () {
    pos.add(vel);
    for (PVector point : points) {
      point.add(vel);
    }
    for (Sphere s : spheres) {
      if (s.isWithin(pos, 2)) {
        destroyed.add(this);
        bullets.remove(this);
      }
    }
  }
  public boolean moveable() {
    return true;
  }
  public PVector getPos() {
    return this.pos;
  }
  public PVector getVel() {
    return this.vel;
  }
  public void accelerate (PVector a) {
    this.vel.add(a);
  }
  public boolean isWithin (PVector loc, float flex) {
    return dist(loc, pos) <= 2+flex;
  }
  private ArrayList<PVector> calcPoints(PVector pos, PVector[] size) {
    ArrayList<PVector> p = new ArrayList<PVector>();
    p.add(pos.copy());
    p.add(pos.copy().add(size[1]));
    p.add(pos.copy().add(size[0]).add(size[1]));
    p.add(pos.copy().add(size[0]));
    p.add(pos.copy().add(size[0]).add(size[1]).add(size[2]));
    p.add(pos.copy().add(size[0]).add(size[2]));  
    p.add(pos.copy().add(size[1]).add(size[2]));
    p.add(pos.copy().add(size[2]));
    return p;
  }
  private ArrayList<Triangle> calcTriangles(ArrayList<PVector> points, color c) {
    ArrayList<Triangle> t = new ArrayList<Triangle>();
    t.add(new Triangle(points.get(0), points.get(1), points.get(2), c));
    t.add(new Triangle(points.get(2), points.get(3), points.get(0), c));
    t.add(new Triangle(points.get(3), points.get(2), points.get(4), c));
    t.add(new Triangle(points.get(4), points.get(5), points.get(3), c));
    t.add(new Triangle(points.get(5), points.get(4), points.get(6), c));
    t.add(new Triangle(points.get(6), points.get(7), points.get(5), c));
    t.add(new Triangle(points.get(7), points.get(6), points.get(1), c));
    t.add(new Triangle(points.get(1), points.get(7), points.get(0), c));
    t.add(new Triangle(points.get(1), points.get(6), points.get(4), c));
    t.add(new Triangle(points.get(4), points.get(2), points.get(1), c));
    t.add(new Triangle(points.get(7), points.get(0), points.get(3), c));
    t.add(new Triangle(points.get(3), points.get(7), points.get(5), c));
    return t;
  }
}
