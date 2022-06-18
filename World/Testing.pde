void showVisualization () {
  fill(0);
  strokeWeight(1);
  circle(width/2, height/2, 10);
  noFill();
  circle(width/2, height/2, 600);
  strokeWeight(2);
  line(width/2, height/2, width/2+sight.x, height/2+sight.y);
  line(width/2+sight.x, height/2+sight.y, width/2+sight.x+xAxis.x, height/2+sight.y+xAxis.y);
  strokeWeight(5);
  PVector object = new PVector(780-width/2, 200-height/2);
  point(width/2+object.x, height/2+object.y);
  strokeWeight(0.5);
  line(width/2+sight.x-xAxis.x*100, height/2+sight.y-xAxis.y*100, width/2+sight.x+xAxis.x*100, height/2+sight.y+xAxis.y*100);
  line(width/2-sight.x*100, height/2-sight.y*100, width/2+sight.x*100, height/2+sight.y*100);
  line(width/2, height/2, width/2+object.x, height/2+object.y);
  PVector x = project(object, sight);
  line(width/2+object.x, height/2+object.y, width/2+x.x, height/2+x.y);
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
