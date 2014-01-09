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
  void fall()
  {
    if (get(int(loc.x+15), int(loc.y+15)) == color(195))
    {
      vel.add(acc);
      limitVel();
      loc.add(vel);
    }
    else //if(get(int(loc.x+15), int(loc.y+15)) == color(0))
    {
      while (get (int (loc.x+15), int(loc.y+14)) == color(0) || get(int (loc.x+15), int(loc.y+14)) == color(255))
      {
        loc.y--;
      }
      vel.set(0, 0);
    }
  }
  void hitPlayer(Player p)
  {
    if (dist(loc.x, loc.y, p.loc.x, p.loc.y) < 24 && loc.x > p.loc.x && p.loc.y > loc.y-15)
    {
      if (loc.x > p.loc.x && p.loc.y > loc.y-15)
      {
        loc.x = p.loc.x+21;
      }
      else  if (loc.x < p.loc.x && p.loc.y > loc.y-15)
      {
        loc.x = p.loc.x-21;
      }
      loc.x = p.loc.x+23;
    }
    else if (dist(loc.x, loc.y, p.loc.x, p.loc.y) < 25 && loc.x < p.loc.x && p.loc.y > loc.y-15)
    {   
      loc.x = p.loc.x-23;
    }
  }
}

