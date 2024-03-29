public class Sphere implements Object {
  public ArrayList<Triangle> triangles;
  private PVector center;
  private float radius;
  private color clr;

  public Sphere () {
  }
  public Sphere(PVector pos, float radius, color clr, int angle, int rows) {
    this.center = pos;
    this.radius = radius;
    this.clr = clr;
    ArrayList<PVector> ps = calcPoints(pos, radius, radius, angle, rows);
    this.triangles = calcTriangles(ps, angle, rows, clr);
  }

  public void addToCamera (Camera c) {
    ArrayList<Triangle> triangles = getTriangles();
    for (Triangle t : triangles) {
      t.updateClose(c);
    }
    Collections.sort(triangles);
    for (int i = (int) (triangles.size()/2); i<triangles.size(); i++) {
      c.addTriangle(triangles.get(i));
    }
  }
  public ArrayList<Triangle> getTriangles () {
    return this.triangles;
  }
  public void update () {
  }
  public boolean moveable() {
    return false;
  }
  public boolean isWithin (PVector loc, float flex) {
    return dist(loc, center) <= radius+flex;
  }
  public PVector getPos() {
    return this.center;
  }
  public PVector getVel() {
    return null;
  }
  public void accelerate (PVector a) {
  }
  public PVector getNormal (PVector loc) {
    return loc.copy().sub(center);
  }
  public PVector displace (PVector loc) {
    return center.copy().add(getNormal(loc).setMag(radius+0.01));
  }

  public void recalcDetail (PVector loc) {
    int angle = 10;
    println ((int)(5000/(loc.copy().sub(center).mag())));
    int rows = max(10, (int)(500/(loc.copy().sub(center).mag())));
    ArrayList<PVector> ps = calcPoints(this.center, this.radius, this.radius, angle, rows);
    this.triangles = calcTriangles(ps, angle, rows, this.clr);
  }
  public ArrayList<PVector> calcPoints (PVector pos, float yRadius, float xzRadius, int angle, int rows) {
    ArrayList<PVector> points = new ArrayList<PVector>();
    int rowAngle = 360/rows;
    points.add(new PVector(pos.x, pos.y+yRadius, pos.z));
    for (int theta = angle; theta < 180; theta+=angle) {
      float rSin = xzRadius*sin(radians(theta));
      float rCos = yRadius*cos(radians(theta));
      for (int phi = 0; phi < 360; phi += rowAngle) {
        float sinP = sin(radians(phi));
        float cosP = cos(radians(phi));
        points.add(new PVector(pos.x+rSin*cosP, pos.y+rCos, pos.z+rSin*sinP));
      }
    }
    points.add(new PVector(pos.x, pos.y-yRadius, pos.z));
    return points;
  }

  public ArrayList<Triangle> calcTriangles (ArrayList<PVector> points, int angle, int rows, color clr) {
    ArrayList<Triangle> triangles = new ArrayList<Triangle>();
    triangles.add(new Triangle(points.get(0), points.get(rows), points.get(1), clr));
    for (int i = 1; i<rows; i++) {
      triangles.add(new Triangle(points.get(0), points.get(i), points.get(i+1), clr));
    }
    int levels = 180/angle;
    for (int i = 1; i<levels-1; i++) {
      triangles.add(new Triangle(points.get(rows*i), points.get(1+rows*(i-1)), points.get(rows*i+rows), clr));
      triangles.add(new Triangle(points.get(rows*i+1), points.get(1+rows*(i-1)), points.get(rows*i+rows), clr));
      for (int j = 1; j<rows; j++) {
        triangles.add(new Triangle(points.get(j+rows*(i-1)), points.get(j+1+rows*(i-1)), points.get(j+rows*i), clr));
        triangles.add(new Triangle(points.get(j+1+rows*(i-1)), points.get(j+1+rows*i), points.get(j+rows*i), clr));
      }
    }
    int end = points.size()-1;
    triangles.add(new Triangle(points.get(end), points.get(end-rows), points.get(end-1), clr));
    for (int i = 1; i<rows; i++) {
      triangles.add(new Triangle(points.get(end), points.get(end-i), points.get(end-i-1), clr));
    }
    return triangles;
  }
}
