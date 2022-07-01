public class Bullet implements Object {
  ArrayList<PVector> points;
  ArrayList<Triangle> triangles;
  PVector vel;
  
  public Bullet (PVector loc, PVector dir) {
    this.points = calcPoints(loc, cam.getView());
    this.triangles = calcTriangles(points, color(0));
    this.vel = dir;
  }
  
  public void addToCamera (Camera c) {
    for (Triangle t : triangles) {
      c.addTriangle(t);
      //t.updateClose(c);
    }
    //Collections.sort(triangles);
    //for (int i = (int) (triangles.size()/2); i<triangles.size(); i++) {
    //  c.addTriangle(triangles.get(i));
    //}
  }
  public ArrayList<Triangle> getTriangles () {
    return this.triangles;
  }
  public void update () {
    for (PVector point : points) {
      //point.add(vel);
    }
  }
  private ArrayList<PVector> calcPoints(PVector pos, PVector[] size) {
    ArrayList<PVector> p = new ArrayList<PVector>();
    p.add(pos);
    p.add(pos.copy().add(size[1]));
    p.add(pos.copy().add(size[0]).add(size[1]));
    p.add(pos.copy().add(size[0]));
    p.add(pos.copy().add(size[0]).add(size[1]).add(size[2]));
    p.add(pos.copy().add(size[0]).add(size[2]));  
    p.add(pos.copy().add(size[1]).add(size[2]));
    p.add(pos.copy().add(size[2]));
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
