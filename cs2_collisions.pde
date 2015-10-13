import java.util.HashSet;
Player p;

// Detect collitions between Breakers and Asteroids.  Remove the
// Asteroids involved in collisions, and replace them with smalller
// Asteroids.  Remove Breakers involved in collisions.
void handleCollisions() {
     // Asteroids which collided this timestep
  HashSet<Asteroid> collisions = new HashSet();

  // Breakers which collided this timestep.
  HashSet<Breaker> usedBreakers = new HashSet();

  // Keep track of which objects collided.  Don't delete them inside
  // the loop, because that messes up the Iterator.
  for (Breaker b : breakers) {
    for (Asteroid a : asteroids) {
      if (colliding1(a, b)) {
        collisions.add(a);
        usedBreakers.add(b);
      }
    }
  }
  
  if (p.dead == false) { // Collision between player and asteroids
    for (Asteroid a : asteroids) {
      if (colliding2(a, p)) {
        collisions.add(a);
        p.dead = true;
      }
    }
  }

  // Split or remove the Asteroids which collided
  for (Asteroid a : collisions) {
    asteroids.remove(a);
       if (a.canSplit()) {
         children = a.children();
         asteroids.add(children.a);
         asteroids.add(children.b);
       }
  }
  
  // Remove the Breakers which collided
  for (Breaker b : usedBreakers) {
    breakers.remove(b);
  }
}

// The number of (random) elements to create.
int initialAsteroids = 2;
int initialBreakers = 30;

ArrayList<Asteroid> asteroids = new ArrayList();
ArrayList<Breaker> breakers = new ArrayList();

// Store time (ms) of last update.
float t, last_t, dt;
Pair<Asteroid, Asteroid> children;

void setup() {

  // Make random Asteroids
  int i = 0;
  while(i < initialAsteroids) {
    asteroids.add(new Asteroid());
    i++;
  }
  
  p = new Player();
  size(500,500);
}

void draw() {
  clear();

  // Render all the Asteroids
  for(Asteroid a : asteroids) {
    a.render();
  }

  // Render all the Breakers
  for(Breaker b : breakers) {
    b.render();
  }
  
  // Update the positions of the Asteroids
  t = millis();
  dt = last_t - t;
  last_t = t;
  for(Asteroid a : asteroids) {
    a.update(dt);
  }
  
  for(Breaker b : breakers) {
    b.update(dt);
  }
  
  if (p.dead == false) {
    p.render();
    p.update(dt);
  }
  
  handleCollisions();
}

float distance(PVector v1, PVector v2) {
  return dist(v1.x, v1.y, v2.x, v2.y);
}

boolean colliding1(Asteroid a, Breaker b) {
  if (distance(a.center, b.center) <= a.radius() + b.radius()) {
    return true;
  } else {
    return false;
  }
}

boolean colliding2(Asteroid a, Player p) {
  if (distance(a.center, p.center) <= a.radius() + p.radius()) {
    return true;
  } else {
    return false;
  }
}

void keyPressed() { // Keyboard input
if (p.dead == false) {
  if (key == ' ') { // When spacebar is pressed
    if (p.fireCount > 1) { // Counter to control fire rate
      breakers.add(new Breaker(p.center.copy(), p.rotation));
      p.fireCount = 0;
    } else {
      p.fireCount++;
    }
  } if (keyCode == UP) { 
    if (p.v.x > -80) { // If speed is not at max
      p.v.x = p.v.x - 20; // Accelerate
    }
  if (keyCode == DOWN) {
    if (p.v.x < 0) {
      p.v.x = p.v.x + 20;
    }
  }
  }
  if (keyCode == LEFT) { // Rotate left 
    p.rotation = p.rotation-radians(10);
  } else if (keyCode == RIGHT) { // Rotate right
    p.rotation = p.rotation+radians(10);
  }
}
}
  