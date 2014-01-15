class Bullet {
  PVector loc, vel, ploc;
  int size;
  int life;
  float rise, run;
  Bullet(float x, float y, float px, float py) {
    loc = new PVector(x, y);
    ploc=new PVector(px, py);

    rise = (y-py);
    run = (x-px); 
    
    vel = new PVector(-run/10, -rise/10);// the /50 makes it go slower
    size = 1;
    life = 100;
  }

  void display() {
    fill(1);
    stroke(1);
    strokeWeight(2);
    ellipse(loc.x, loc.y, size, size);
  }

  void update() {
    loc.add(vel);
    life--;
  }
  void hit() {
    if (get(int(loc.x), int(loc.y)) == color(0) || get(int(loc.x), int(loc.y)) == color(255)||get(int(loc.x), int(loc.y)) == color(255, 0, 255) ||get(int(loc.x), int(loc.y)) == color(255, 0, 0)) {
      life=0;
    }
  }
}

