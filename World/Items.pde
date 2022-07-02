public interface Item {
  public void use();
}

public class Gun implements Item {
  public void use () {
    Bullet bullet = new Bullet(cam.pos.copy().sub(cam.viewX.copy().div(4)).sub(cam.viewY.copy().div(4)), cam.viewZ.copy(), bulletSpeed);
    world.add(bullet);
    bullets.add(bullet);
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
}
