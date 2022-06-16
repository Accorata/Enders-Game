float dist(PVector a, PVector b) {
  return a.copy().sub(b).mag();
}

float magProject(PVector u, PVector v) {
  return u.dot(v)/v.mag();
}
