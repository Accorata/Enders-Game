public interface Item {
  public void use();
  public void display();
}

public class Gun implements Item {
  private float bulletSpeed;

  public Gun () {
    this(10);
  }
  public Gun (float bulletSpeed_) {
    this.bulletSpeed = bulletSpeed_;
  }

  public void use () {
    Bullet bullet = new Bullet(cam.pos.copy().sub(cam.viewX.copy().div(4)).sub(cam.viewY.copy().div(4)), cam.viewZ.copy(), bulletSpeed);
    world.add(bullet);
    bullets.add(bullet);
  }
  public void display() {
    noStroke();
    fill(50);
    triangle(width-200, height-150, width-50, height, width, height-50);
  }
}

public class TetherGun implements Item {
  public void use () {
    for (Tether t : tethers) {
      if (t.attached) {
        cam.setDirTowards(t.pos.copy().sub(cam.pos), 0.3);
      }
    }
  }
  public void display() {
    noStroke();
    fill(100);
    triangle(width-100, height-100, width-50, height, width, height-50);
  }
}
