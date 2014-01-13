class Bullet {
  PVector loc, vel, acc, ploc;
  int size;
  int life;
  float rise, run;
  Bullet(float x, float y, float px, float py) {
    loc = new PVector(x, y);
    ploc=new PVector(px, py);
    rise = (y-py);
    run = (x-px); 
    vel = new PVector(-run/50, -rise/50);
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
    //vel.add(acc);
    loc.add(vel);
    life--;
  }
  void hit() {
    if (get(int(loc.x), int(loc.y)) == color(0) || get(int(loc.x), int(loc.y)) == color(255)||get(int(loc.x), int(loc.y)) == color(255, 0, 255) ) {
      life=0;
    }
  }
}

