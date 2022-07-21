public class Mirror extends Camera implements Object {
  private PVector size = new PVector(100, 100, 1);

  public Mirror(PVector pos_, PVector size_) {
    super(pos_, new PVector(0, 0, 0));
    super.pos = pos_;
    this.size = size_;
  }
  
}
