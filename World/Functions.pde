public float dist(PVector a, PVector b) {
  return a.copy().sub(b).mag();
}

public void rotateAxisOnX(PVector axis, float deg) {
  if (deg != 0) {
    float rad = radians(deg);
    PVector temp = new PVector(axis.z, axis.y);
    temp.rotate(rad);
    axis.y = temp.y;
    axis.z = temp.x;
  }
}

public void rotateAxisOnY(PVector axis, float deg) {
  //if (deg != 0) {
  //  float rad = radians(deg);
  //  PVector temp = new PVector(axis.x, axis.z);
  //  temp.rotate(rad);
  //  axis.x = temp.x;
  //  axis.z = temp.y;
  //}
  rotateOn(axis, new PVector(0,1,0), deg);
}

public void rotateAxisOnZ(PVector axis, float deg) {
  if (deg != 0) {
    float rad = radians(deg);
    PVector temp = new PVector(axis.x, axis.y);
    temp.rotate(rad);
    axis.x = temp.x;
    axis.y = temp.y;
  }
}

public void rotateOn(PVector pv, PVector axis, float deg) {
  float sin = sin(radians(deg));
  float cos = cos(radians(deg));
  PVector rowOne = new PVector(cos+sq(axis.x)*(1-cos), axis.x*axis.y*(1-cos)-axis.z*sin, axis.x*axis.z*(1-cos)+axis.y*sin);
  PVector rowTwo = new PVector(axis.x*axis.y*(1-cos)+axis.z*sin, cos+sq(axis.y)*(1-cos), axis.y*axis.z*(1-cos)-axis.x*sin);
  PVector rowThree = new PVector(axis.x*axis.z*(1-cos)-axis.y*sin, axis.y*axis.z*(1-cos)+axis.x*sin, cos+sq(axis.z)*(1-cos));
  PVector ans = new PVector(0, 0, 0);
  ans.add(rowOne.mult(pv.x));
  ans.add(rowTwo.mult(pv.y));
  ans.add(rowThree.mult(pv.z));
  pv = ans;
}

public void addToWorld (Sphere obj) {
  obj.addToCamera(cam);
  world.add(obj);
}

PVector project(PVector u, PVector v) {
  return v.copy().mult(u.dot(v)/sq(v.mag()));
}
void recalcInverses() {
  PVector[] inv = inverse(xAxis, sight);
  xAxisInv = inv[0];
  sightInv = inv[1];
}
PVector[] inverse(PVector one, PVector two) {
  PVector[] ans = new PVector[3];
  for (int i = 0; i<2; i++) {
    ans[i] = new PVector(0, 0, 0);
  }
  float inverseDet = 1;//(one.x*two.y - one.x*two.y);
  ans[0].x = two.y*inverseDet;
  ans[0].y = -one.y*inverseDet;
  ans[1].x = -two.x*inverseDet;
  ans[1].y = one.x*inverseDet;
  return ans;
}
PVector[] inverse(PVector one, PVector two, PVector three) {
  PVector[] ans = new PVector[3];
  for (int i = 0; i<3; i++) {
    ans[i] = new PVector(0, 0, 0);
  }
  ans[0].x = (two.y * three.z - three.y * two.z);
  ans[0].y = -(one.y * three.z - three.y * one.z);
  ans[0].z = (one.y * two.z - two.y * one.z);
  ans[1].x = -(two.x * three.z - three.x * two.z);
  ans[1].y = (one.x * three.z - three.x * one.z);
  ans[1].z = -(one.x * two.z - two.x * one.z);
  ans[2].x = (two.x * three.y - three.x * two.y);
  ans[2].y = -(one.x * three.y - three.x * one.y);
  ans[2].z = (one.x * two.y - two.x * one.y);
  return ans;
}
