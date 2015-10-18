class Breaker {
  final PVector center;
  float rotation;
  final PVector v; // Breaker velocity

  Breaker(PVector c, float r) {
    center = c;
    rotation = r;
    v = new PVector (-200, 0); 
  }
  
  public void update(float dt) { // Update position of breaker
    PVector dv = v.copy();
    dv.rotate(this.rotation);
    dv.mult(dt/1000);
    center.add(dv);
    center.x = (center.x + width) % width;
    center.y = (center.y + height) % height;
  }

  float radius() {
    return 5;
  }
  
  void render() {
    fill(255);
    stroke(0);
    ellipse(center.x, center.y, 5, 5);
  }
}