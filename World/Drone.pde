public class Drone extends Camera {
  public Drone (PVector pos_, PVector vel_) {
    super(pos_, vel_);
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
