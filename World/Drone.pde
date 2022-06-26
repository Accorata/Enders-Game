public class Drone extends Camera {
  public Drone (PVector pos_, PVector vel_) {
    super(pos_, vel_);
    super.viewX = cam.viewX;
    super.viewY = cam.viewY;
    super.viewZ = cam.viewZ;
  }

  @Override
    public void displayTethers() {
    super.screen.stroke(0);
    PVector two = super.projPoint(cam.pos);
    if (two != null) {
      for (Tether t : tethers) {
        PVector one = super.projPoint(t.getPos());
        if (one != null) {
          super.screen.strokeWeight(sigmoid(t.displacement/-4)*1.5);
          super.screen.line(one.x, one.y, two.x, two.y);
        }
      }
      super.screen.fill(0);
      super.screen.circle(two.x, two.y, 10);
    }
  }
  @Override
    public void move () {
    move(super.vel);
  }
  @Override
    public void move (PVector dir) {
    super.pos.add(dir);
    for (Sphere s : world) {
      if (s.isWithin(super.pos, 0)) {
        super.pos = s.displace(super.pos);
        PVector normal = s.getNormal(super.pos).normalize();
        super.vel.div(2);
        super.vel.add(project(super.vel, normal).setMag(super.vel.dot(normal)*2));
      }
    }
  }
}
