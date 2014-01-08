class Portal {
  PVector loc;
  int size;
  boolean touching;
  color c;
  Portal(color _c)
  {
    c = _c;
  }
  void display()
  {
    fill(c);
    loc = new PVector(mouseX, 490);
    if (c == color(0, 0, 255))
    {
      loc = new PVector(50, 3);
    }
    rect(loc.x, loc.y, 50, 5);
  }
  void shoot()
  {
  }
  void checkObject(Cube c, Portal partner)
  {
    if (dist(c.loc.x, c.loc.y, loc.x, loc.y) < 15)
    {
      c.loc.set(partner.loc.x, partner.loc.y);
    }
  }
}

