class Asteroid {
     final int size;  // number of sides
     PVector center;  // position of center, in screen coordinates
     final PVector v;  // velocity, per second, in screen coordinates

  Asteroid(int s, PVector c, PVector v_) {
    size = s;
    center = c;
    v = v_;
  }
  
  // Create a new Asteroid with a random position & velocity.  The
  // position is uniformly distributed over the window area.  The
  // velocity is in a random direction, always with magnitude 100
  // pixels/second.
  Asteroid() {
    size = 8;
    center = new PVector(random(width), random(height));
    v = new PVector(100,0);
    v.rotate(random(TWO_PI));
  } 

  // Update the position of the Asteroid according to its velocity.
  // The argument dt is the elapsed time in milliseconds since the
  // last update.  Modifies the Asteroid.
  public void update(float dt) {
    PVector dv = v.copy();
    dv.mult(dt/1000);
    center.add(dv);
    center.x = (center.x + width) % width;
    center.y = (center.y + height) % height;
  }

  // Draw a polygon with the current style.  `polygon(x, y, r, n)`
  // draws a n-sided polygon with its circumcenter at (x,y), with a
  // distance r from the center to each vertex.
  private void polygon(float x, float y, float radius, int npoints) {
    float angle = TWO_PI / npoints;
    beginShape();
    for (float a = 0; a < TWO_PI; a += angle) {
      float sx = x + cos(a) * radius;
      float sy = y + sin(a) * radius;
      vertex(sx, sy);
    }
    endShape(CLOSE);
  }
  
  int childShape() { // Returns the number of sides of asteroids created when this one splits
    return size-1;
  }
  
  boolean canSplit() { // Returns true if asteroid has more than 4 sides, otherwise returns false
    if (size > 4) {
      return true;
    } else {
      return false;
    }
  }
  
  float radius() {
    if (size == 4) {
      return 10;
    } else if (size == 5) {
      return 12.7;
    } else if (size == 6) {
      return 16;
    } else if (size == 7) {
      return 20.2;
    } else {
      return 25.4;
    }
  }
  
  void render() {
    float angle = TWO_PI / this.size;
    beginShape();
    for (float a = 0; a < TWO_PI; a += angle) {
      float sx = this.center.x + cos(a) * this.radius();
      float sy = this.center.y + sin(a) * this.radius();
      vertex(sx, sy);
    }
    endShape(CLOSE);
  }
  
  Pair<PVector, PVector> childVelocities() {
    PVector v1 = v.copy();
    PVector v2 = v.copy();
    v1.x = v1.x * 1.1; // Multiply magnitude of each point in each vector by 1.1
    v1.y = v1.y * 1.1;
    v2.x = v2.x * 1.1;
    v2.y = v2.y * 1.1;
    v1.rotate(PI/6); // Rotate the two vectors
    v2.rotate(-PI/6);
    Pair<PVector, PVector> ret = new Pair(v1, v2);
    return ret;
  }
  
  Pair<Asteroid, Asteroid> children() {
    Asteroid a1 = new Asteroid(childShape(), this.center.copy(), childVelocities().a);
    Asteroid a2 = new Asteroid(childShape(), this.center.copy(), childVelocities().b);
    Pair<Asteroid, Asteroid> ret = new Pair(a1, a2);
    return ret;
  }
}