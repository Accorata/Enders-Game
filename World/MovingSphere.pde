public class MovingSphere extends Sphere implements Object {
  private PVector vel;
  private ArrayList<PVector> points;

  public MovingSphere(PVector pos, float radius, color clr, int angle, int rows) {
    super();
    super.center = pos;
    super.radius = radius;
    this.vel = new PVector(0, 0, 0);
    this.points = super.calcPoints(pos, radius, radius, angle, rows);
    super.triangles = super.calcTriangles(this.points, angle, rows, clr);
  }

  @Override
    public void addToCamera (Camera c) {
    super.addToCamera(c);
  }
  @Override
    public ArrayList<Triangle> getTriangles () {
    return super.triangles;
  }
  @Override
    public void update () {
    super.center.add(vel);
    for (PVector p : points) {
      p.add(vel);
    }
  }
  @Override
    public boolean moveable() {
    return true;
  }
  @Override
    public PVector getPos() {
    return super.center;
  }
  @Override
    public PVector getVel() {
    return this.vel;
  }
  @Override
    public void accelerate (PVector a) {
    this.vel.add(a);
  }
}
