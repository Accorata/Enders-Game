void showVisualization () {
  recalcInverses();
  strokeWeight(1);
  fill(0);
  stroke(0, 155, 155);
  line(width/2, height/2, width/2+sightInv.x, height/2+sightInv.y);
  //stroke(155, 0, 155);
  //line(width/2, height/2, width/2+xAxis.x, height/2+xAxis.y);
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
  PVector x = project(object, xAxis);//new PVector(0, 0);//
  println(x);
  println(x.x + x.y);
  println(x.mag());
  //x.add(sightInv.copy().mult(object.x));//.normalize());
  //x.add(xAxisInv.copy().mult(object.y));//.normalize());
  line(width/2+object.x, height/2+object.y, width/2+x.x, height/2+x.y);
  PVector y = project(object, xAxis);
  line(width/2+object.x, height/2+object.y, width/2+y.x, height/2+y.y);
  stroke(0);
  line(width/2-y.x*100, height/2-y.y*100, width/2+y.x*100, height/2+y.y*100);
  stroke(0, 0, 255);
  float xVal = object.dot(xAxis.copy().normalize());
  float yVal = object.dot(sight.copy().normalize())-300;//x.dot(xAxisInv.copy().normalize());//new PVector(y.mag(), x.mag());
  //println(sightInv);
  //realX.add(sightInv.copy().setMag(x.x));//.normalize());
  //realX.add(xAxisInv.copy().setMag(x.y));//.normalize());
  //line(width/2, height/2, width/2-y.mag(), height/2);
  //line(width/2-y.mag(), height/2, width/2-y.mag(), height/2+x.mag());
  //line(width/2, height/2, width/2, height/2+x.mag());
  //line(width/2, height/2+x.mag(), width/2-y.mag(), height/2+x.mag());
  //line(width/2, height/2, width/2-real.x, height/2+real.y);
  line(width/2, height/2, width/2-xVal, height/2);
  line(width/2, height/2, width/2, height/2-yVal);
  line(width/2, height/2-yVal, width/2-xVal, height/2-yVal);
  line(width/2-xVal, height/2, width/2-xVal, height/2-yVal);
  line(width/2, height/2, width/2-xVal, height/2-yVal);
  fill(0);
  stroke(0);
  circle(width/2-xVal, height/2-yVal, 10);
  //PVector fin = new PVector(0,0);
  //fin.x = sight.mag() * real.y / (sight.mag()) +width/2;// + sight.mag())
  //fin.x = y.x + width/2;
  //circle(fin.x, fin.y, 25);
  //fin.y = fromScreen * loc.y / (loc.z + fromScreen)+width/2;
  //println(realX);
}

//private PVector projPoint(PVector point) {
//    PVector fin = new PVector (0, 0);
//    float rotatedX = magProject(point, viewX);
//    float rotatedY = magProject(point, viewY);
//    float rotatedZ = magProject(point, sight);
//    PVector loc = new PVector(0, 0, 0);
//    //loc.add(project(point, viewX));
//    //loc.add(project(point, viewY));
//    loc.add(project(point, viewX));
//    println(loc);
//    //if (point.z <= -1 * fromScreen) {
//    //  fin.add(viewX.copy().mult(fromScreen * rotatedX));
//    //  fin.add(viewY.copy().mult(fromScreen * rotatedY));
//    //} 
//    //else {      
//    if (point.z >= -1 * fromScreen) {
//      //fin.add(viewX.copy().mult(fromScreen * rotatedX / (rotatedZ + fromScreen)+width/2));
//      //fin.add(viewY.copy().mult(fromScreen * rotatedY / (rotatedZ + fromScreen)+height/2));
//      fin.x = fromScreen * loc.x / (loc.z + fromScreen)+width/2;
//      fin.y = fromScreen * loc.y / (loc.z + fromScreen)+width/2;
//    }
//    return fin;
//  }
