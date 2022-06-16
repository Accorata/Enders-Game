public class Triangle implements Comparable<Triangle> {
  private PVector[] points = new PVector[3];
  private color clr;
  private PVector center;
  private float close;

  public Triangle (PVector a_, PVector b_, PVector c_, color clr_) {
    this.points[0] = a_;
    this.points[1] = b_;
    this.points[2]= c_;
    this.clr = clr_;
    this.center = calcCenter();
  }

  PVector calcCenter () {
    PVector cent = new PVector(0, 0, 0);
    for (PVector point : points) {
      cent.add(point);
    }
    cent.div(3);
    return cent;
  }
  void update_close() {
    this.center = calcCenter();
    this.close = dist(center, new PVector(0, 0, -300));
  }

  @Override
    int compareTo(Triangle obj) {
    if (this.close > obj.close) return -1;
    if (this.close < obj.close) return 1;
    return 0;
  }
}
