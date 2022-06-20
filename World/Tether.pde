public class Tether {
  private float len;
  private float springConst;
  private PVector pos;
  
  public Tether (PVector pos_) {
    this.pos = pos_;
  }
  
  public PVector getPos() {
    return pos;
  }
}
