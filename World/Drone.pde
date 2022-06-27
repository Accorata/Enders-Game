public class Drone extends Camera implements Object {
  private ArrayList<PVector> points;
  private ArrayList<Triangle> triangles;
  
  public Drone (PVector pos_, PVector vel_) {
    super(pos_, vel_);
    super.viewX = cam.viewX;
    super.viewY = cam.viewY;
    super.viewZ = cam.viewZ;
    this.points = super.calcPoints(pos_, 3, 3, 45, 4);
    this.triangles = super.calcTriangles(points, 45, 4, color(0));
  }

  public void addToCamera (Camera c) {
    super.addToCamera(c);
  }
  public ArrayList<Triangle> getTriangles () {
    return this.triangles;
  }
  public void update (){
    drone.move();
  }
  @Override
    public void displayTethers() {
    super.screen.stroke(0);
    PVector playerPos = super.projPoint(cam.pos);
    if (playerPos != null) {
      for (Tether t : tethers) {
        PVector one = super.projPoint(t.getPos());
        if (one != null) {
          super.screen.strokeWeight(sigmoid(t.displacement/-4)*1.5);
          super.screen.line(one.x, one.y, playerPos.x, playerPos.y);
        }
      }
      super.screen.fill(0);
      super.screen.circle(playerPos.x, playerPos.y, 20);
    }
  }
  @Override
    public void move () {
    move(super.vel);
  }
  @Override
    public void move (PVector dir) {
    super.pos.add(dir);
    for (PVector point : points) {
      point.add(dir);
    }
    for (Sphere s : spheres) {
      if (s.isWithin(super.pos, 0)) {
        super.pos = s.displace(super.pos);
        PVector normal = s.getNormal(super.pos).normalize();
        super.vel.div(2);
        super.vel.add(project(super.vel, normal).setMag(super.vel.dot(normal)*2));
      }
    }
  }
}
