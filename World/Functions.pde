public void addToWorld (Sphere s) {
  world.add(s);
  spheres.add(s);
}

public void addToWorld (Tether t) {
  world.add(t);
  tethers.add(t);
}

public void setLight () {
  ArrayList<Triangle> triangles = new ArrayList<Triangle>(); 
  for (Object o : world) {
    for (Triangle t : o.getTriangles()) {
      triangles.add(t);
    }
  }
  for (Triangle t : triangles) {
    t.light = 0;
    t.updateClose(cam);
  }
  Collections.sort(triangles);
  int i = triangles.size()-1;
  while (i >= 0 && triangles.get(i).close < 200) {
    triangles.get(i).light = 100-triangles.get(i).close/2;
    i--;
  }
}

//public static void rotateAxisOnX(PVector axis, float deg) {
//  if (deg != 0) {
//    float rad = radians(deg);
//    PVector temp = new PVector(axis.z, axis.y);
//    temp.rotate(rad);
//    axis.y = temp.y;
//    axis.z = temp.x;
//  }
//}
//public static void rotateAxisOnY(PVector axis, float deg) {
//  if (deg != 0) {
//    float rad = radians(deg);
//    PVector temp = new PVector(axis.x, axis.z);
//    temp.rotate(rad);
//    axis.x = temp.x;
//    axis.z = temp.y;
//  }
//}
//public static void rotateAxisOnZ(PVector axis, float deg) {
//  if (deg != 0) {
//    float rad = radians(deg);
//    PVector temp = new PVector(axis.x, axis.y);
//    temp.rotate(rad);
//    axis.x = temp.x;
//    axis.y = temp.y;
//  }
//}
//public Triangle copyOfTri(Triangle t) {
//  return new Triangle(t.points, t.clr, t.center, t.close);
//}
//PVector[] inverse(PVector one, PVector two, PVector three) {
//  PVector[] ans = new PVector[3];
//  for (int i = 0; i<3; i++) {
//    ans[i] = new PVector(0, 0, 0);
//  }
//  ans[0].x = (two.y * three.z - three.y * two.z);
//  ans[0].y = -(one.y * three.z - three.y * one.z);
//  ans[0].z = (one.y * two.z - two.y * one.z);
//  ans[1].x = -(two.x * three.z - three.x * two.z);
//  ans[1].y = (one.x * three.z - three.x * one.z);
//  ans[1].z = -(one.x * two.z - two.x * one.z);
//  ans[2].x = (two.x * three.y - three.x * two.y);
//  ans[2].y = -(one.x * three.y - three.x * one.y);
//  ans[2].z = (one.x * two.y - two.x * one.y);
//  return ans;
//}
