public class Camera {
  private PVector loc;
  private ArrayList<Triangle> Triangles = new ArrayList<Triangle>();
  private float fromScreen = 1000000;
  private PVector pos = new PVector(0, 0, 0);
  private PVector sight = new PVector(0, 0, 300);
  private PVector viewX = new PVector(1, 0, 0);
  private PVector viewY = new PVector(0, 1, 0);

  public Camera() {
    this.loc = new PVector(0, 0, -fromScreen);
  }

  private void proj(Triangle t) {
    if (!(t.points[0].z < loc.z && t.points[1].z < -1 * fromScreen && t.points[2].z < -1 * fromScreen)) {
      float[][] pT = new float[3][2];
      int count = 0;
      for (PVector point : t.points) {
        try {
          float scX = 0;
          float scY = 0;
          if (point.z <= -1 * fromScreen) {
            scX = (((fromScreen * point.x) / ((-1 * fromScreen + 1) + fromScreen)) + width/2);
            scY = (((fromScreen * point.y) / ((-1 * fromScreen + 1) + fromScreen)) + height/2);
          } else {      
            scX = (((fromScreen * point.x) / (point.z + fromScreen)) + width/2);
            scY = (((fromScreen * point.y) / (point.z + fromScreen)) + height/2);
          }
          pT[count][0] = scX;
          pT[count][1] = scY;
          count++;
        } 
        catch (Exception e) {
          break;
        }
      }
      fill(t.clr);
      //if (!quantize) noStroke();
      triangle(pT[0][0], pT[0][1], pT[1][0], pT[1][1], pT[2][0], pT[2][1]);
    }
  }
  public void display() {
    for (Triangle t : Triangles) {
      t.update_close();
    }
    Collections.sort(Triangles);
    //Collections.sort(sc.getTriangles());
    //for (Triangle t : sc.getTriangles()) {
    //  proj(t);
    //}
    for (Triangle t : Triangles) {
      //if (t.ID != -1) 
      project(t);
    }
  }
  private void project (Triangle t) {
    ArrayList<PVector> points = new ArrayList<PVector>();
    PVector perspective = pos.copy();//.add(sight);
    for (PVector point : t.getPoints()) {
      points.add(projPoint(point));
    }
    triangle(points.get(0).x, points.get(0).y, points.get(1).x, points.get(1).y, points.get(2).x, points.get(2).y);
  }
  private PVector projPoint(PVector point) {
    PVector fin = new PVector (0, 0);
    if (point.z <= -1 * fromScreen) {
      fin.add(viewX.copy().mult(fromScreen * point.x + width/2));
      fin.add(viewY.copy().mult(fromScreen * point.y + height/2));
    } else {      
      fin.add(viewX.copy().mult(fromScreen * point.x / (point.z + fromScreen) + width/2));
      fin.add(viewY.copy().mult(fromScreen * point.y / (point.z + fromScreen) + height/2));
    }
    return fin;
  }
  public void proj (PVector test) {
    PVector perspective = pos.copy();//.add(sight);
    float xTheta = radians(90);
    if (test.x != 0) {
      xTheta = acos(perspective.z/test.x);
    } 
    float x = test.x*sin(xTheta) + width/2;
    float yTheta = radians(90);
    if (test.y != 0) {
      yTheta = acos(perspective.z/test.y);
    } 
    float y = test.y*sin(yTheta) + height/2;
    circle(x, y, 3);
  }

  public void addTriangle (Triangle a) {
    Triangles.add(a);
  }
}