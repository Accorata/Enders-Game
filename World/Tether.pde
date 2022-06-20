public class Tether {
  private float len = 200;
  private float springConst = 1;
  private PVector pos;

  public Tether (PVector pos_) {
    this.pos = pos_;
  }

  public PVector force(PVector loc) {
    PVector force = pos.copy().sub(loc);
    force.mult(force.mag() - len);
    force.mult(springConst);
    return force;
  }
  public PVector getPos() {
    return pos;
  }
}
