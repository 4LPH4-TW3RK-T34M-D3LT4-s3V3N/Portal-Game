class Player {

  String name;
  PVector loc, vel, acc;
  Player(String playername, int locx, int locy) {
    name = playername;
    loc = new PVector(locx, locy);
    vel = new PVector(0, 0);
    acc = new PVector(0, .1);
  }

  void display() {
    fill(255, 0, 0);
    rect(loc.x+15, loc.y+50, 15, 50);
  }
  void fall()
  {
    if (get(int(loc.x+15+7.5), int(loc.y+50+25)) == color(0))
    {
      println("YAS");
      while (get (int (loc.x+15+7.5), int(loc.y+50+23)) == color(0))
      {
        loc.y--;
      }
      vel.set(0, 0);
    }
    else {
      vel.add(acc);
      loc.add(vel);
    }
  }
  void update() {
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
    }      loc.add(vel);

  }
}

