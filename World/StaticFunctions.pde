public static float dist(PVector a, PVector b) {
  return a.copy().sub(b).mag();
}

public static PVector rotateOn(PVector pv, PVector axis, float deg) {
  float sin = sin(radians(deg));
  float cos = cos(radians(deg));
  PVector rowOne = new PVector(cos+sq(axis.x)*(1-cos), axis.x*axis.y*(1-cos)-axis.z*sin, axis.x*axis.z*(1-cos)+axis.y*sin);
  PVector rowTwo = new PVector(axis.x*axis.y*(1-cos)+axis.z*sin, cos+sq(axis.y)*(1-cos), axis.y*axis.z*(1-cos)-axis.x*sin);
  PVector rowThree = new PVector(axis.x*axis.z*(1-cos)-axis.y*sin, axis.y*axis.z*(1-cos)+axis.x*sin, cos+sq(axis.z)*(1-cos));
  PVector ans = new PVector(0, 0, 0);
  ans.add(rowOne.mult(pv.x));
  ans.add(rowTwo.mult(pv.y));
  ans.add(rowThree.mult(pv.z));
  return ans;
}

public static PVector project(PVector u, PVector v) {
  return v.copy().mult(u.dot(v)/sq(v.mag()));
}

public static float sigmoid (float x) {
  return 1/(1+exp(-x));
}

public color darken (color c, float x) {
  float r = red(c)-x;
  if (r < 0) r = 0;
  float g = green(c)-x;
  if (g < 0) g = 0;
  float b = blue(c)-x;
  if (b < 0) b = 0;
  return color(r, g, b);
}
