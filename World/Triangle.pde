public class Triangle implements Comparable<Triangle> {
  private PVector[] points = new PVector[3];
  private color clr;
  private PVector center;
  private float close;
  private float light = 0;

  public Triangle (PVector a_, PVector b_, PVector c_, color clr_) {
    this(a_, b_, c_, clr_, 0);
  }
  public Triangle (PVector a_, PVector b_, PVector c_, color clr_, float light_) {
    this.points[0] = a_;
    this.points[1] = b_;
    this.points[2]= c_;
    this.clr = clr_;
    this.center = calcCenter();
    this.light = light_;
  }
  public Triangle (PVector[] points_, color clr_, PVector center_, float close_) {
    this.points = points_;
    this.clr = clr_;
    this.center = center_;
    this.close = close_;
  }

  private PVector calcCenter () {
    PVector cent = new PVector(0, 0, 0);
    for (PVector point : points) {
      cent.add(point);
    }
    cent.div(3);
    return cent;
  }
  public void updateClose(Camera c) {
    this.center = calcCenter();
    this.close = dist(center, c.pos);
  }
  public PVector[] getPoints() {
    return points;
  }
  @Override
    public int compareTo(Triangle obj) {
    if (this.close > obj.close) return -1;
    if (this.close < obj.close) return 1;
    return 0;
  }
}
