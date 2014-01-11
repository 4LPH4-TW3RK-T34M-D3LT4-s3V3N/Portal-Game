class Player {

  String name;
  PVector loc, vel, acc;
  int velSet;
  Player(String playername, int locx, int locy) {
    name = playername;
    loc = new PVector(locx, locy);
    vel = new PVector(0, 0);
    acc = new PVector(0, .1);
    velSet = 15;
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
    for (int i = 0; i > vel.y; i--)
    {
      if (get(int(loc.x+7.5), int(loc.y-19+i)) != color(195))
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
    if (get(int(loc.x-6), int(loc.y)) == color(0) || get(int(loc.x-6), int(loc.y)) == color(255))
    {
      while (get (int (loc.x-6), int(loc.y)) == color(0) || get (int (loc.x-6), int(loc.y)) == color(255))
      {
        loc.x++;
      }
      return true;
    }
    else if (get(int(loc.x+10), int(loc.y)) == color(0) || get(int(loc.x+10), int(loc.y)) == color(255))
    {
      while (get (int (loc.x+10), int(loc.y)) == color(0) || get (int (loc.x+10), int(loc.y)) == color(255))
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
    if (get(int(loc.x+7.5), int(loc.y-24)) == color(0) || get(int(loc.x+7.5), int(loc.y-24)) == color(255))
    {
      while (get (int (loc.x+7.5), int(loc.y-23)) == color(0) || get (int (loc.x+7.5), int(loc.y-23)) == color(255))
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
      vel.y*=-.5;
    }
    if (hitWall())
    {
      vel.x*=-.5;
    }
  }
  void limitVel()
  {
    if (vel.y > velSet)
    {
      vel.y = velSet;
    }
  }
  void friction()
  {
    if (vel.x > 0)
    {
      vel.x-=0.1;
      if (vel.x < .01)
      {
        vel.x = 0;
      }
    }
    if (vel.x < 0)
    {
      vel.x+=.1;
      if (vel.x > -.01)
      {
        vel.x = 0;
      }
    }
  }
  void move() {

    if (keys[0]) {
      if (vel.x >= 0 && vel.x < 1)
      {
        vel.x = 1;
      }
    } 
    else if (keys[1]) {
      if (vel.x <= 0 && vel.x > -1)
      {
        vel.x = -1;
      }
    } 
    //else if(!keys[1] && ! keys[2] && vel.x == 1)
    // {
    //   vel.x = 0;
    //  }
    //  else {
    //  vel.x = 0;
    // }

    if (keys[2] && onGround() == true) {
      vel.y = -3;
    }      
    loc.add(vel);
  }
}

