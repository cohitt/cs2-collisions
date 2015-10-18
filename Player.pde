// Things to add:
// Add inertia
// Allow multiple key inputs at once

class Player { // Create the class
  PVector center; // PVector center variable
  final PVector v; // PVector velocity variable 
  float rotation; // Angle of rotation variable
  int fireCount; // Controls how fast the player can fire
  boolean dead; // Whether the player is dead or alive
  
  Player() { // Constructor method 
    center = new PVector(width/2, height/2); // Set initial position to middle of screen
    v = new PVector(0, 0); // Set velocity to 0
    rotation = 0; 
    fireCount = 4;
    dead = false;
  }
  
  public void update(float dt) { // Method to update location based on velocity
    PVector dv = v.copy();
    dv.mult(dt/1000);
    center.add(dv);
    center.x = (center.x + width) % width;
    center.y = (center.y + height) % height;
  }
  
  float radius() { // Return radius
    return 15;
  }
  
  void render() { // Method to draw the player object as a triangle
    pushMatrix();
    translate(this.center.x, this.center.y);
    rotate(this.rotation);
    triangle(15, 0, -15, -10, -15, 10);
    popMatrix();
  }
}