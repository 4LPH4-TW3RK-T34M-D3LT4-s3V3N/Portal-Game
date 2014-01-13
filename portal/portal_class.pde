class Portal {
  PVector loc;
  PVector shootLoc;
  int size;
  boolean appear = false;
  color c;
  int orient;
  boolean justPortaled = false;
  /*
  0 = portal is on the floor
   1 = wall (right)
   2 = wall (left)
   3 = ceiling
   */
  float wut = 0;

  Portal(color _c)
  {
    c = _c;
    // orient = 0;
    if (c == color(0, 0, 255))
    {
      loc = new PVector(50, 3);
      //  orient = 3;
    }
    else
    {
      loc = new PVector(50, 3);
    }
  }
  void display()
  {
    if (appear)
    {
      fill(c);
      if (orient == 0 || orient == 3)
      {
        rect(loc.x, loc.y, 50, 5);
      }
      if (orient == 2 || orient == 1)
      {
        rect(loc.x, loc.y, 5, 50);
      }
    }
  }
  void shoot(Player p)
  {
    stroke(0, 255, 0);
    strokeWeight(1);
    float rise = (mouseY-p.loc.y)/100;
    float run = (mouseX-p.loc.x)/100;
    while (get (int (p.loc.x+ (run*wut)), int(p.loc.y+(rise*wut))) != color(255) && get (int (p.loc.x+ (run*wut)), int(p.loc.y+(rise*wut))) != color(0))
    {
      // ellipse(p.loc.x+(run*wut), p.loc.y+(rise*wut), 30, 30);
      wut+=.1;
      shootLoc = new PVector(p.loc.x+ (run*wut), p.loc.y+(rise*wut));
      if (shootLoc.x > width || shootLoc.x < 0  || shootLoc.y > height || shootLoc.y < 0)
      {
        return;
      }
    }
    fill(255, 0, 0);
    wut = 0;
    for (int i =0; i < 20; i++)
    {
      // line(p.loc.x, p.loc.y, p.loc.x+(run*i), p.loc.y+(rise*i));
    }
  }
  void appear()
  {
    appear = true;
    loc = shootLoc;
    if (get(int(shootLoc.x), int(shootLoc.y)) != color(255))
    {
      appear = false;
    }
    checkOrient();
  }
  void checkOrient()
  {
    for (int i = 0; i < 50; i++)
    {
      if (get(int(shootLoc.x-25+i), int(shootLoc.y)) == color(195))
      {
        if (mouseX > player.loc.x)
        {
          orient = 2;
        }
        else if (mouseX < player.loc.x)
        {
          orient = 1;
        }
        return;
      }
      else
        if (mouseY > player.loc.y)
        {
          orient = 0;
        }
        else if (mouseY < player.loc.y)
        {
          orient = 3;
        }
    }
  }
  void dissapear()
  {
    if (key == 'r' || key == 'R')
    {
      appear = false;
    }
  }
  void checkObject(Cube c, Portal partner)
  {
    if (appear && partner.appear)
    {
      if (dist(c.loc.x, c.loc.y, loc.x, loc.y) < 20 || dist(c.loc.x+c.vel.x, c.loc.y+c.vel.y, loc.x, loc.y) < 20)
      {
        if (partner.orient == 0)
        {
          if (orient == 0)
          {
            if (c.vel.y > 0)
            {
              c.vel.y*=-1;
            }
            else if (c.vel.y == 0)
            {
              c.vel.y = -2;
            }
          }
          if (orient == 1 || orient == 2)
          {
            if (c.vel.y >= 0)
            {
              c.vel.y = -2;
            }
          }
          c.loc.set(partner.loc.x, partner.loc.y-20);
        }
        else if (partner.orient == 3)
        {
          if (c.vel.y < 0)
          {
            c.vel.y*=1;
          }
          c.loc.set(partner.loc.x, partner.loc.y+20);
        }
        else if (partner.orient == 1)
        {
          if (orient == 0 || orient == 3)
          {
            c.vel.x = c.vel.y;
          }
          c.loc.set(partner.loc.x+20, partner.loc.y);
        }
        else if (partner.orient == 2)
        {
          if (orient == 4)
          {
          }
          c.loc.set(partner.loc.x-20, partner.loc.y);
        }
      }
    }
  }

  void checkPlayer(Player p, Portal partner)
  {
    if (appear && partner.appear)
    {
      if (dist(p.loc.x, p.loc.y, loc.x, loc.y) < 25 || dist(p.loc.x+p.vel.x, p.loc.y+p.vel.y, loc.x, loc.y) < 25)
      {
        if (partner.orient == 0)
        {
          if (orient == 0)
          {
            if (p.vel.y > 0)
            {
              p.vel.y*=-1;
            }
            else if (p.vel.y == 0)
            {
              p.vel.y = -2;
            }
          }
          if (orient == 1 || orient == 2)
          {
            if (p.vel.y >= 0)
            {
              p.vel.y = -2;
            }
          }
          p.loc.set(partner.loc.x, partner.loc.y-27);
        }
        else if (partner.orient == 3)
        {
          if (p.vel.y < 0)
          {
            p.vel.y*=-1;
          }
          p.loc.set(partner.loc.x, partner.loc.y+27);
        }
        else if (partner.orient == 1)
        {
          if (orient == 0 || orient == 3)
          {
            p.vel.x = p.vel.y;
          }
          p.loc.set(partner.loc.x+26, partner.loc.y);
        }
        else if (partner.orient == 2)
        {
          p.loc.set(partner.loc.x-26, partner.loc.y);
        }
      }
    }
  }
}

