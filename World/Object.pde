public interface Object {
  public void addToCamera (Camera c);
  public ArrayList<Triangle> getTriangles ();
  public void update ();
  public boolean moveable ();
  public PVector getPos ();
  public PVector getVel ();
  public void accelerate (PVector a);
}
