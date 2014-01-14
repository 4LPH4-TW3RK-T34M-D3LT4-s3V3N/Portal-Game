class Laser
{
  PVector loc;
  boolean vertical;
  boolean moving;
  int wut;
  int moveLength;
  int move = 1;
  int moveSpeed = 1;
  Laser(int x, int y, boolean _vertical)
  {
    loc = new PVector(x, y);
    vertical = _vertical;
    moving = false;
  }
  Laser(int x, int y, boolean _vertical, int _moveLength)
  {
    loc = new PVector(x, y);
    vertical = _vertical;
    moving = true;
    moveLength = _moveLength;
  }
  void display()
  {
    if (!vertical)
    {
      wut = 0;
      while (get (int (loc.x+wut), int(loc.y)) == color(195))
      {
        fill(254, 0, 0);
        noStroke();
        ellipse(loc.x+wut, loc.y, 1, 1);
        wut++;
      }
      wut = 0;
      while (get (int (loc.x+wut-2), int(loc.y)) == color(195))
      {
        fill(254, 0, 0);
        noStroke();
        ellipse(loc.x+wut-2, loc.y, 1, 1);
        wut--;
      }
      print(wut);
    }
    else if (vertical)
    {
      wut = 0;
      while (get (int (loc.x), int(loc.y+wut)) == color(195))
      {
        fill(254, 0, 0);
        noStroke();
        ellipse(loc.x, loc.y+wut, 1, 1);
        wut++;
      }
      wut = 0;
      while (get (int (loc.x), int(loc.y+wut-2)) == color(195))
      {
        fill(254, 0, 0);
        noStroke();
        ellipse(loc.x, loc.y+wut, 1, 1);
        wut--;
      }
    }
  }
  void move()
  {
    if (moving)
    {
      if (!vertical)
      {
        loc.y+=moveSpeed;
        move+=moveSpeed;
        if (move >= moveLength || move <= 0)
        {
          moveSpeed*=-1;
        }
      }
      else
      {
        loc.x+=moveSpeed;
        move+=moveSpeed;
        println(move);
        if (move >= moveLength || move <= 0)
        {
          moveSpeed*=-1;
        }
      }
    }
  }
}

