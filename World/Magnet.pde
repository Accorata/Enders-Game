public class Magnet extends Sphere implements Object {
  private float pullRadius = 100;
  
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
        //o.vel.add(new PVector(0,0,1));
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
