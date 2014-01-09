class Player {

  String name;
  PVector loc, vel, acc;
  int velSet;
  Player(String playername, int locx, int locy) {
    name = playername;
    loc = new PVector(locx, locy);
    vel = new PVector(0, 0);
    acc = new PVector(0, .1);
    velSet = 10;
  }

  void display() {
    fill(255, 0, 0);
    rectMode(CENTER);
    rect(loc.x, loc.y, 12, 45);
    loc.add(vel);
  }
  void fall()
  {
    if (get(int(loc.x+7.5), int(loc.y+24)) == color(195))
    {
      vel.add(acc);
      limitVel();
    }
  }
  boolean onGround() 
  {
    if (get(int(loc.x+7.5), int(loc.y+20)) == color(0))
    {
      while (get (int (loc.x+7.5), int(loc.y+19)) == color(0))
      {
        loc.y--;
      }
      return true;
    }
    else if (get(int(loc.x+7.5), int(loc.y+20)) == color(195))
    {
      return false;
    }
    else {
      return true;
    }
  } 
  boolean hitCeiling()
  {
    if (get(int(loc.x+7.5), int(loc.y-24)) == color(0))
    {
      while (get (int (loc.x+7.5), int(loc.y-23)) == color(0))
      {
        loc.y++;
      }
      return true;
    }
    else {
      return false;
    }
  }
  void limitVel()
  {
    if (vel.y > velSet)
    {
      vel.y = velSet;
    }
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

    if (keyPressed && key == ' ' && onGround() == true) {
      vel.y = -3;
    }
  }
}

