public class Tether {
  private float len = 100;
  private float springConst = 0.0001;
  private PVector pos;

  public Tether (PVector pos_) {
    this.pos = pos_;
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
