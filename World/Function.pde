float dist(PVector a, PVector b) {
  return a.copy().sub(b).mag();
}
