class Turret
{ 
  PVector loc;
  PVector vel;
  PVector acc;
  int size;
  boolean hello;
  boolean shoot = true;
  int velSet = 30;
  ArrayList<Bullet> bullet = new ArrayList<Bullet>();

  Turret(float x, float y)
  {
    loc = new PVector(x, y);
    vel = new PVector(0, 0);
    acc = new PVector(0, .1);
  }
  void display()
  {
    fill(250);
    noStroke();
    rectMode(CENTER);
    rect(loc.x, loc.y, 20, 40);
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
    if (!goGround(loc, 20, 40))
    {
      vel.add(acc);
      limitVel();
      loc.add(vel);
    }
    else
    {
      vel.y = 0;
      if (goCeil(loc, 20, 40))
      {
        while (get (int (loc.x), int(loc.y-21)) != color(195))
        {
          loc.y++;
        }
      }
    }
  }
  void hitPlayer(Player p)
  {
    if (dist(loc.x, loc.y, p.loc.x, p.loc.y) <17 && loc.x > p.loc.x && p.loc.y > loc.y-20)
    {
      loc.x = p.loc.x+17;
    }
    else if (dist(loc.x, loc.y, p.loc.x, p.loc.y) < 17 && loc.x < p.loc.x && p.loc.y > loc.y-20)
    {   
      loc.x = p.loc.x-17;
    }
  }
  boolean checkPlayer(Player p)
  {
    if (dist(loc.x, 0, p.loc.x, 0) < 100 && p.loc.y <= loc.y+15 && p.loc.y > loc.y-100)
    {
      return true;
    }
    else
    {
      return false;
    }
  }
  
  void shoot(Player p) {
    if (checkPlayer(p))
    {
      shoot = true;
    }
    else
    {
      shoot = false;
    }

    for (int i = bullet.size()-1; i >=0; i--) {
      Bullet b = bullet.get(i);
      b.hit();
      b.display();
      b.update();
      if (b.life <= 0) {
        bullet.remove(i);
      }
    }
    if (shoot) {
      bullet.add(new Bullet(loc.x, loc.y, p.loc.x, p.loc.y));
    }
  }
}

