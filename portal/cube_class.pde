class Cube
{
  PVector loc;
  PVector vel;
  PVector acc;
  int size;
  boolean pressing;
  int velSet = 30;
  Cube(float x, float y)
  {
    loc = new PVector(x, y);
    vel = new PVector(0, 0);
    acc = new PVector(0, .1);
  }
  void display()
  {
    fill(255, 0, 255);
    noStroke();
    rectMode(CENTER);
    rect(loc.x, loc.y, 30, 30);
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
  void fall()
  {
    if (!goGround(loc, 30, 30))
    {
      vel.add(acc);
      limitVel();
      loc.add(vel);
    }
    else
    {
      vel.y = 0;
      while (get (int (loc.x), int(loc.y-16)) != color(195))
      {
        loc.y--;
      }
    }
  }
  boolean hitWall()
  {
    if (get(int(loc.x+16), int(loc.y)) != color(195))
    {
      return true;
    }
    else if (get(int(loc.x-16), int(loc.y)) != color(195))
    {
      return true;
    }
    else
      return false;
  }
  void hitPlayer(Player p)
  {
    if (get(int(loc.x-22), int(loc.y)) == color(255, 0, 0))
    {
      if (!hitWall())
      {
        loc.x = p.loc.x+27;
      }
    }
    else if (get(int(loc.x+22), int(loc.y)) == color(255, 0, 0))
    {
      if (!hitWall())
      {
        loc.x = p.loc.x-27;
      }
    }
  }
}


