PVector sight = new PVector(0, -300);
PVector xAxis = new PVector(-150, 0);
PVector xAxisInv;
PVector sightInv;

void showVisualization () {
  recalcInverses();
  strokeWeight(1);
  fill(0);
  stroke(0, 155, 155);
  line(width/2, height/2, width/2+sightInv.x, height/2+sightInv.y);
  stroke(155, 155, 0);
  line(width/2, height/2, width/2+xAxisInv.x, height/2+xAxisInv.y);
  stroke(0);
  line(width/2+100, height/2, width/2-100, height/2);
  line(width/2, height/2+100, width/2, height/2-100);
  circle(width/2, height/2, 10);
  noFill();
  circle(width/2, height/2, 600);
  strokeWeight(2);
  line(width/2, height/2, width/2+sight.x, height/2+sight.y);
  line(width/2+sight.x, height/2+sight.y, width/2+sight.x+xAxis.x, height/2+sight.y+xAxis.y);
  strokeWeight(5);
  PVector object = new PVector(100, -200);
  point(width/2+object.x, height/2+object.y);
  strokeWeight(0.5);
  line(width/2+sight.x-xAxis.x*100, height/2+sight.y-xAxis.y*100, width/2+sight.x+xAxis.x*100, height/2+sight.y+xAxis.y*100);
  line(width/2-sight.x*100, height/2-sight.y*100, width/2+sight.x*100, height/2+sight.y*100);
  line(width/2, height/2, width/2+object.x, height/2+object.y);
  stroke(255, 0, 0);
  PVector x = project(object, xAxis);
  line(width/2+object.x, height/2+object.y, width/2+x.x, height/2+x.y);
  PVector y = project(object, xAxis);
  line(width/2+object.x, height/2+object.y, width/2+y.x, height/2+y.y);
  stroke(0);
  line(width/2-y.x*100, height/2-y.y*100, width/2+y.x*100, height/2+y.y*100);
  stroke(0, 0, 255);
  float xVal = object.dot(xAxis.copy().normalize());
  float yVal = object.dot(sight.copy().normalize());
  line(width/2, height/2, width/2-xVal, height/2);
  line(width/2, height/2, width/2, height/2-yVal);
  line(width/2, height/2-yVal, width/2-xVal, height/2-yVal);
  line(width/2-xVal, height/2, width/2-xVal, height/2-yVal);
  line(width/2, height/2, width/2-xVal, height/2-yVal);
  fill(0);
  stroke(0);
  circle(width/2-xVal, height/2-yVal, 10);
  PVector fin = new PVector(0, 0);
  fin.x = -100;
  if (yVal > 0) {
    float slope = -xVal/yVal;
    //println(slope);
    fin.x = (sight.mag() * slope)+width/2;
  }
  fin.y = height/2-300;
  line(width/2, height/2, fin.x, fin.y);
  circle(fin.x, fin.y, 25);
  //fin.y = fromScreen * loc.y / (loc.z + fromScreen)+width/2;
  //println(fin.x);
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
