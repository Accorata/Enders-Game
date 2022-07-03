public class Magnet extends Sphere implements Object {
  private float pullRadius = 100;
  private float pullStrength = 0.05;

  public Magnet(PVector pos, float radius, color clr, int angle, int rows) {
    super(pos, radius, clr, angle, rows);
  }

  public void addToCamera (Camera c) {
    super.addToCamera(c);
  }
  public ArrayList<Triangle> getTriangles () {
    return super.getTriangles();
  }
  @Override
    public void update () {
    super.update();
    for (Object o : world) {
      if (o.moveable() && isNear(o.getPos())) {
        o.accelerate(super.getNormal(o.getPos()).setMag(-pullStrength));
      }
    }
  }
  @Override
    public boolean moveable() {
    return false;
  }
  @Override
    public void accelerate (PVector a) {
  }
  public boolean isNear (PVector loc) {
    return dist(loc, super.center) <= pullRadius;
  }
}
