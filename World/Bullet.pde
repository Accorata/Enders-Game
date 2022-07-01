public class Bullet implements Object {
  ArrayList<PVector> points;
  ArrayList<Triangle> triangles;
  PVector vel;
  
  public Bullet (PVector loc, PVector dir) {
    this.points = calcPoints(loc, dir);
    this.triangles = calcTriangles(points, color(0));
    this.vel = dir;
  }
  
  public void addToCamera (Camera c) {
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
    for (PVector point : points) {
      point.add(vel);
    }
  }
  private ArrayList<PVector> calcPoints(PVector pos, PVector size) {
    ArrayList<PVector> p = new ArrayList<PVector>();
    p.add(pos);
    p.add(new PVector(pos.x, pos.y+size.y, pos.z));
    p.add(new PVector(pos.x+size.x, pos.y+size.y, pos.z));
    p.add(new PVector(pos.x+size.x, pos.y, pos.z));
    p.add(new PVector(pos.x+size.x, pos.y+size.y, pos.z+size.z));
    p.add(new PVector(pos.x+size.x, pos.y, pos.z+size.z));  
    p.add(new PVector(pos.x, pos.y+size.y, pos.z+size.z));
    p.add(new PVector(pos.x, pos.y, pos.z+size.z));
    return p;
  }
  private ArrayList<Triangle> calcTriangles(ArrayList<PVector> points, color c) {
    ArrayList<Triangle> t = new ArrayList<Triangle>();
    t.add(new Triangle(points.get(0), points.get(1), points.get(2), c));
    t.add(new Triangle(points.get(2), points.get(3), points.get(0), c));
    t.add(new Triangle(points.get(3), points.get(2), points.get(4), c));
    t.add(new Triangle(points.get(4), points.get(5), points.get(3), c));
    t.add(new Triangle(points.get(5), points.get(4), points.get(6), c));
    t.add(new Triangle(points.get(6), points.get(7), points.get(5), c));
    t.add(new Triangle(points.get(7), points.get(6), points.get(1), c));
    t.add(new Triangle(points.get(1), points.get(7), points.get(0), c));
    t.add(new Triangle(points.get(1), points.get(6), points.get(4), c));
    t.add(new Triangle(points.get(4), points.get(2), points.get(1), c));
    t.add(new Triangle(points.get(7), points.get(0), points.get(3), c));
    t.add(new Triangle(points.get(3), points.get(7), points.get(5), c));
    return t;
  }
}
