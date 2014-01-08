class player {

  String name;
  PVector loc, vel, acc;
  player(String playername, int locx, int locy) {
    name = playername;
    loc = new PVector(locx, locy);
    vel = new PVector(0, 0);
    acc = new PVector(0, 0);
  }

  void display() {
    fill(255, 0, 0);
    rect(loc.x+15, loc.y+50, 15, 50);
  }

  void update() {
    loc.add(vel);
    vel.add(acc);
  }

  void move() {
    if (keyPressed && key == 'd') {
      vel.x = 1;
    } 
    else if (keyPressed && key == 'a') {
      vel.x = -1;
    } 
    else {
      vel.x = 0;
    }

    if (keyPressed && key == ' ') {
      vel.y = -3;
    }
  }
  
}

