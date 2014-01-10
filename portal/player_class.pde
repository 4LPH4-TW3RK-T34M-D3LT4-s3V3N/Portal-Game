class Player {

  String name;
  PVector loc, vel, acc;
  int velSet;
  Player(String playername, int locx, int locy) {
    name = playername;
    loc = new PVector(locx, locy);
    vel = new PVector(0, 0);
    acc = new PVector(0, .1);
    velSet = 20;
  }
  color terminalVel()
  {
    for (int i = 0; i < vel.y; i++)
    {
      if (get(int(loc.x+7.5), int(loc.y+19+i)) != color(195))
      {
        return get(int(loc.x+7.5), int(loc.y+19+i));
      }
    }
    return color(195);
  }
  boolean onGround() 
  {
    if (get(int(loc.x+7.5), int(loc.y+20)) == color(0) || get(int(loc.x+7.5), int(loc.y+20)) == color(255, 0, 255))
    {
      while (get (int (loc.x+7.5), int(loc.y+19)) == color(0) || get (int (loc.x+7.5), int(loc.y+19)) == color(255, 0, 255))
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
  boolean hitWall()
  {
    if (get(int(loc.x-6), int(loc.y)) == color(0))
    {
      while (get (int (loc.x-6), int(loc.y)) == color(0))
      {
        loc.x++;
      }
      return true;
    }
    else if (get(int(loc.x+10), int(loc.y)) == color(0))
    {
      while (get(int (loc.x+10), int(loc.y)) == color(0))
      {
        loc.x--;
      }
      return true;
    }
   // else if (get(int(loc.x-6), int(loc.y+20)) == color(195))
   // {
   //   return false;
   // }
    else {
      return false;
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
  void display() {
    fill(255, 0, 0);
    noStroke();
    rectMode(CENTER);
    rect(loc.x, loc.y, 12, 45);
  }
  void fall()
  {
    if (get(int(loc.x), int(loc.y+24)) == color(195) && terminalVel() == color(195))
    {
      vel.add(acc);
      limitVel();
      loc.add(vel);
    }
    if (hitCeiling() || onGround())
    {
      vel.y = 0;
    }
    if (hitWall())
    {
      vel.x = 0;
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

    if (keys[0]) {
      vel.x = 1;
    } 
    else if (keys[1]) {
      vel.x = -1;
    } 
    else {
      vel.x = 0;
    }

    if (keys[2] && onGround() == true) {
      vel.y = -3;
    }      
    loc.add(vel);
  }
}

