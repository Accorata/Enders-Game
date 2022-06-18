float dist(PVector a, PVector b) {
  return a.copy().sub(b).mag();
}

float magProject(PVector u, PVector v) {
  return u.dot(v)/v.mag();
}

PVector project(PVector u, PVector v) {
  return v.copy().mult(u.dot(v)/sq(v.mag()));
}

void rotateAxisOnX(PVector axis, float deg) {
  if (deg != 0) {
    float rad = radians(deg);
    PVector temp = new PVector(axis.z, axis.y);
    temp.rotate(rad);
    axis.y = temp.y;
    axis.z = temp.x;
  }
}

void rotateAxisOnY(PVector axis, float deg) {
  if (deg != 0) {
    float rad = radians(deg);
    PVector temp = new PVector(axis.x, axis.z);
    temp.rotate(rad);
    axis.x = temp.x;
    axis.z = temp.y;
  }
}

void rotateAxisOnZ(PVector axis, float deg) {
  if (deg != 0) {
    float rad = radians(deg);
    PVector temp = new PVector(axis.x, axis.y);
    temp.rotate(rad);
    axis.x = temp.x;
    axis.y = temp.y;
  }
}
