public class Item {
  private boolean gun = false;
  private float bulletSpeed;

  public Item () {
  }
  public Item (float bulletSpeed_) {
    this.gun = true;
    this.bulletSpeed = bulletSpeed_;
  }

  public void use () {
    if (gun) {
      Bullet bullet = new Bullet(cam.pos.copy().sub(cam.viewX.copy().div(4)).sub(cam.viewY.copy().div(4)), cam.viewZ.copy(), bulletSpeed);
      world.add(bullet);
      bullets.add(bullet);
    } else {
      for (Tether t : tethers) {
        if (t.attached) {
          cam.setDirTowards(t.pos.copy().sub(cam.pos), 0.3);
        }
      }
    }
  }
}
