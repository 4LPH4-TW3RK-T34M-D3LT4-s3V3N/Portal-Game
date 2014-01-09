class Portal {
  PVector loc;
  PVector shootLoc;
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
    fill(c);
    //if(!mousePressed)
    //{
    // loc = new PVector(mouseX, 490);
    // }

    rect(loc.x, loc.y, 50, 5);
  }
  void shoot(Player p)
  {
    stroke(0, 255, 0);
    strokeWeight(1);
    float rise = (mouseY-p.loc.y)/5;
    float run = (mouseX-p.loc.x)/5;
    while (get (int (p.loc.x+ (run*wut)), int(p.loc.y+(rise*wut))) == color(195))
    {
      // ellipse(p.loc.x+(run*wut), p.loc.y+(rise*wut), 30, 30);
      wut+=.1;
      shootLoc = new PVector(p.loc.x+ (run*wut), p.loc.y+(rise*wut));
    }
    fill(255, 0, 0);
    println(wut);
    wut = 0;
    for (int i =0; i < 20; i++)
    {
      // line(p.loc.x, p.loc.y, p.loc.x+(run*i), p.loc.y+(rise*i));
    }
  }
  void shoot2()
  {
    loc = shootLoc;
    if (mouseY < shootLoc.y)
    {
      orient = 0;
    }
    else if (mouseY > shootLoc.y)
    {
      orient = 3;
    }
  }
  void checkObject(Cube c, Portal partner)
  {
    if (dist(c.loc.x, c.loc.y, loc.x, loc.y) < 15)
    {
      if (partner.orient == 0)
      {
        c.loc.set(partner.loc.x, partner.loc.y-15);
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
        p.loc.set(partner.loc.x, partner.loc.y-25);
      }
      else if (partner.orient == 3)
      {
        p.loc.set(partner.loc.x, partner.loc.y+25);
      }
    }
  }
}

