private PVector mouse = new PVector(width/2, height/2);
private PVector mouseOld = new PVector(width/2, height/2);
private float sensitivity = 100; 

public class Camera extends Sphere implements Object {
  private ArrayList<PVector> points;
  private ArrayList<Triangle> screenTriangles = new ArrayList<Triangle>();
  private PVector pos;
  private PVector vel;
  final float sight = 300;
  private PVector viewX = new PVector(1, 0, 0);
  private PVector viewY = new PVector(0, 1, 0);
  private PVector viewZ = new PVector(0, 0, 1);
  private PGraphics screen;
  private int behind;
  private boolean zoom = false;
  private float zoomFactor = 200;

  public Camera() {
    this(width, height);
  }
  public Camera(int x, int y) {
    super();
    this.pos = new PVector(0, 0, 0);
    this.vel = new PVector(0, 0, 0);
    this.points = super.calcPoints(this.pos, 3, 3, 45, 4);
    super.triangles = super.calcTriangles(this.points, 45, 4, color(0, 255, 0));
    this.screen = createGraphics(x, y);
    screen.beginDraw();
  }
  public Camera(PVector pos_, PVector vel_) {
    this(width, height);
    this.pos = pos_;
    this.vel = vel_;
  }

  @Override
    public void addToCamera (Camera c) {
    super.addToCamera(c);
  }
  @Override
    public ArrayList<Triangle> getTriangles () {
    return super.triangles;
  }
  @Override
    public void update () {
    boolean push = near;
    if (push) dir.mult(10);
    //if (dir.mag() < speed*2) dir.div(10);
    if (!test) {
      boost(dir);
      move();
    } else {
      move(dir);
    }
    if (push) dir.div(10);
  }
  @Override
    public boolean moveable() {
    return true;
  }
  @Override
    public PVector getPos() {
    return this.pos;
  }
  @Override
    public PVector getVel() {
    return this.vel;
  }
  @Override
    public void accelerate (PVector a) {
    this.vel.add(a);
  }
  public PVector[] getView () {
    PVector[] ans = new PVector[3];
    ans[0] = viewX.copy().setMag(0.5);
    ans[1] = viewY.copy().setMag(0.5);
    ans[2] = viewZ.copy().setMag(2);
    return ans;
  }
  public void display(float x, float y, float w, float h) {
    screen.endDraw();
    noFill();
    strokeWeight(4);
    stroke(0);
    rect(x-2, y-2, w+4, h+4);
    image(screen, x, y, w, h);
    screen.beginDraw();
    screen.background(255, 150);
  }
  public void displayWorld() {
    if (zoom) pos.add(viewZ.copy().mult(zoomFactor));
    screenTriangles = new ArrayList<Triangle>();
    for (Object o : world) {
      if (o != this) {
        o.addToCamera(this);
      }
    }
    Collections.sort(screenTriangles);
    screen.strokeWeight(1);
    for (Triangle t : screenTriangles) {
      projTri(t);
    }
    displayTethers();
    //println(screenTriangles.size());
    if (zoom) pos.sub(viewZ.copy().mult(zoomFactor));
  }
  public void displayTethers() {
    screen.stroke(0);
    for (Tether t : tethers) {
      PVector one = projPoint(t.getPos());
      if (one != null) {
        screen.strokeWeight(sigmoid(t.displacement/-4)*1.5);
        screen.line(one.x, one.y, width-100, height-100);
      }
    }
  }
  private boolean projTri (Triangle t) {
    ArrayList<PVector> points = new ArrayList<PVector>();
    behind = 0;
    for (PVector point : t.getPoints()) {
      PVector projected = projPoint(point);
      if (projected == null) {
        return false;
      }
      points.add(projected);
    }
    color c = darken(t.clr, 100-t.light);
    screen.fill(c);
    screen.stroke(c);
    screen.triangle(points.get(0).x, points.get(0).y, points.get(1).x, points.get(1).y, points.get(2).x, points.get(2).y);
    return true;
  }
  private PVector projPoint(PVector point) {
    PVector movedPoint = point.copy().sub(pos);
    PVector ans = new PVector (0, 0);
    float rotatedZ = movedPoint.dot(viewZ.copy().normalize());

    float rotatedX = movedPoint.dot(viewX.copy().normalize());
    float rotatedY = movedPoint.dot(viewY.copy().normalize());
    try {
      if (rotatedZ < 0) {
        behind++;
        if (behind == 3) return null;
        //if (rotatedX < 0) {
        //  ans.x = 0;//(sight/2 * rotatedX);
        //} else {
        //  ans.x = width;//(sight/2 * rotatedX)+width;
        //}
        //if (rotatedY < 0) {
        //  ans.y = 0;//(sight/2 * rotatedY);
        //} else {
        //  ans.y = height;//(sight/2 * rotatedY)+height;
        //}
        ans.x = (sight * -rotatedX)+width/2;
        ans.y = (sight * -rotatedY)+height/2;
        return ans;
      } else {
        ans.x = (sight * -rotatedX/rotatedZ)+width/2;
        ans.y = (sight * -rotatedY/rotatedZ)+height/2;
        return ans;
      }
    }
    catch (Exception e) {
      return null;
    }
  }
  public void displayUI() {
    screen.strokeWeight(2);
    screen.stroke(0);
    screen.line(width/2-20, height/2, width/2+20, height/2);
    screen.line(width/2, height/2-20, width/2, height/2+20);
    screen.noFill();
    screen.circle(width/2, height/2, 700);
    Sphere closest = cam.checkNear();
    //near = (closest != null);
    if (closest != null) {
      PVector norm = closest.center;
      PVector translated = projPoint(norm);
      //new PVector(0, 0, 0);
      //translated.add(viewX.copy().mult(norm.x));
      //translated.add(viewY.copy().mult(norm.y));
      //translated.add(viewZ.copy().mult(norm.z));
      //if (translated
      if (translated != null) {
        screen.line(width/2, height/2, translated.x, translated.y);
      }
    }
    screen.fill(0);
    screen.text(""+(closest != null), 100, 100);
  }
  public void addTriangle (Triangle a) {
    screenTriangles.add(a);
  }
  public void rotateX (float deg) {
    viewY = rotateOn(viewY, viewX, deg);
    viewZ = rotateOn(viewZ, viewX, deg);
    viewX = rotateOn(viewX, viewX, deg);
  }
  public void rotateY (float deg) {
    viewX = rotateOn(viewX, viewY, deg);
    viewZ = rotateOn(viewZ, viewY, deg);
    viewY = rotateOn(viewY, viewY, deg);
  }
  public void rotateZ (float deg) {
    viewX = rotateOn(viewX, viewZ, deg);
    viewY = rotateOn(viewY, viewZ, deg);
    viewZ = rotateOn(viewZ, viewZ, deg);
  }
  public void rotateByMouse() {
    float xRotate = (height/2-mouse.y)*1/sensitivity;
    float yRotate = (mouse.x-width/2)*1/sensitivity;
    rotateX(xRotate);
    rotateY(yRotate);
    mouse.x -= (mouse.x-width/2)/20;
    mouse.y -= (mouse.y-height/2)/20;
    mouse.x += mouseX-mouseOld.x;
    mouse.y += mouseY-mouseOld.y;
    mouseOld.x = mouseX;
    mouseOld.y = mouseY;
  }
  public void boost (PVector dir) {
    PVector translated = new PVector(0, 0, 0);
    translated.add(viewX.copy().mult(dir.x));
    translated.add(viewY.copy().mult(dir.y));
    translated.add(viewZ.copy().mult(dir.z));
    this.accelerate(translated);
  }
  public void setDirTowards (PVector dir, float speed) {
    vel.div(1.1);
    vel.add(dir.setMag(speed));
  }
  public void move () {
    move(vel);
  }
  public void move (PVector dir) {
    if (grab) {
      if (vel.mag() < 0.2) {
        vel = new PVector(0, 0, 0);
      } else {
        vel.div(1.1);
      }
    }
    pos.add(dir);
    for (PVector point : points) {
      point.add(dir);
    }
    for (Sphere s : spheres) {
      if (s.isWithin(pos, 0)) {
        pos = s.displace(pos);
        PVector normal = s.getNormal(pos).normalize();
        vel.div(2);
        vel.add(project(vel, normal).setMag(vel.dot(normal)*2));
      }
    }
    for (Tether t : tethers) {
      if (t.attached != null) {
        dir.add(t.force(pos));
      }
    }
  }
  public Sphere checkNear () {
    for (Sphere s : spheres) {
      if (s.isWithin(pos, 20)) {
        return s;
      }
    }
    return null;
  }
  public boolean attemptGrab () {
    boolean grabbed = false;
    if (near) grabbed = true;
    return grabbed;
  }
}
