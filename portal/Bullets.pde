class Bullet {
  PVector loc, vel, acc;
  int size;
  int life;

  Bullet(float x, float y) {
    loc = new PVector(x,y);
    vel = new PVector(2,0);
    acc = new PVector(0, 0);
    size = 5;
    life = 100;
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
}
