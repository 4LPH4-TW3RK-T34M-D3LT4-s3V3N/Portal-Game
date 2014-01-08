class Cube
{
  PVector loc;
  PVector vel;
  PVector acc;
  int size;
  boolean pressing;
  Cube(float x, float y)
  {
    loc = new PVector(x, y);
    vel = new PVector(0, 0);
    acc = new PVector(0, .1);
  }
  void display()
  {
    fill(0, 0, 255);
    noStroke();
    rectMode(CENTER);
    rect(loc.x, loc.y, 30, 30);
  }
  void fall()
  {
    println(vel.y);
    //dont go faster than 30?
    if (get(int(loc.x+15), int(loc.y+15)) == color(195))
    {
      vel.add(acc);
      loc.add(vel);
    }
    else if (get(int(loc.x+15), int(loc.y+15)) == color(255, 115, 0))
    {
      vel.add(acc);
      loc.add(vel);
    }
    else if (get(int(loc.x+15), int(loc.y+15)) == color(0))
    {
      while (get (int (loc.x+15), int(loc.y+14)) == color(0))
      {
        loc.y--;
      }
      vel.set(0, 0);
    }
  }
}

