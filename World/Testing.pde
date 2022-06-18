void showVisualization () {
  fill(0);
  strokeWeight(1);
  circle(width/2, height/2, 10);
  noFill();
  circle(width/2, height/2, 600);
  strokeWeight(2);
  line(width/2, height/2, width/2+sight.x, height/2+sight.y);
  line(width/2+sight.x-xAxis.x, height/2+sight.y-xAxis.y, width/2+sight.x+xAxis.x, height/2+sight.y+xAxis.y);
  strokeWeight(5);
  PVector object = new PVector(780, 200);
  point(object.x, object.y);
  strokeWeight(0.5);
  line(width/2+sight.x-xAxis.x*100, height/2+sight.y-xAxis.y*100, width/2+sight.x+xAxis.x*100, height/2+sight.y+xAxis.y*100);
  line(width/2, height/2, object.x, object.y);
}
