public class Magnet extends Sphere implements Object {
  public void addToCamera (Camera c) {
    super.addToCamera(c);
  }
  public ArrayList<Triangle> getTriangles () {
    return super.getTriangles();
  }
  @Override
    public void update () {
    super.update();
  }
  @Override
    public boolean moveable() {
    return false;
  }
}
