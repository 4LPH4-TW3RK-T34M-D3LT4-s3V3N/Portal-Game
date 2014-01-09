class Portal {
  PVector loc;
  int size;
  boolean touching;
  color c;
  int orient;
  /*
  0 = portal is on the floor
   1 = wall (right)
   2 = wall (left)
   3 = ceiling
   */
  Portal(color _c)
  {
    c = _c;
  }
  void display()
  {
    fill(c);
    loc = new PVector(mouseX, 490);
    orient = 0;
    if (c == color(0, 0, 255))
    {
      loc = new PVector(50, 3);
      orient = 3;
    }
    rect(loc.x, loc.y, 50, 5);
  }
  void shoot(Player p)
  {
    fill(0, 255, 0);
    stroke(1);
    line(mouseX, mouseY, p.loc.x, p.loc.y);
    float rise = mouseY-p.loc.y;
    float run = mouseX-p.loc.x;
    for(int i =0; i < 20; i++)
    {
    ellipse(p.loc.x + (run*i), p.loc.y+ (rise*i), 30, 30);
    }
  }
  void checkObject(Cube c, Portal partner)
  {
    if (dist(c.loc.x, c.loc.y, loc.x, loc.y) < 15)
    {
      if (partner.orient == 0)
      {
        c.loc.set(partner.loc.x, partner.loc.y);
      }
      else if (partner.orient == 3)
      {
        c.loc.set(partner.loc.x, partner.loc.y+15);
      }
    }
  }
  void checkPlayer(Player p, Portal partner)
  {
    if (dist(p.loc.x, p.loc.y, loc.x, loc.y) < 25)
    {
      if (partner.orient == 0)
      {
        p.loc.set(partner.loc.x, partner.loc.y);
      }
      else if (partner.orient == 3)
      {
        p.loc.set(partner.loc.x, partner.loc.y+25);
      }
    }
  }
}

