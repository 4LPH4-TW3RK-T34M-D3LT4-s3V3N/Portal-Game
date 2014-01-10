class Bullet {
  PVector loc, vel, acc;
  int size;
  int life;

  Bullet(float x, float y, float px, float py) {
    loc = new PVector(x, y);
    vel = new PVector();
    acc = new PVector(0, 0);
    size = 1;
    life = 1000;
  }

  void display() {
    fill(0);
    stroke(0);
    strokeWeight(2);
    ellipse(loc.x, loc.y, size, size);
  }

  void update() {
    vel.add(acc);
    loc.add(vel);
    life--;
  }
  void hit() {
    if (get(int(loc.x), int(loc.y)) == color(0) || get(int(loc.x), int(loc.y)) == color(255)||get(int(loc.x), int(loc.y)) == color(255, 0, 255) ) {
      life=0;
    }
  }
}

