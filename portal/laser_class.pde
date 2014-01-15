class Laser
{
  PVector loc;
  boolean vertical;
  boolean moving;
  int wut;
  int moveLength;
  boolean buttonPress  = false;
  Button b;
  int move = 1;
  int moveSpeed = 1;
  Laser(int x, int y, boolean _vertical)
  {
    loc = new PVector(x, y);
    vertical = _vertical;
    moving = false;
    b = new Button(-100, -100);
  }
  Laser(int x, int y, boolean _vertical, Button _b)
  {
    loc = new PVector(x, y);
    vertical = _vertical;
    moving = false;
    buttonPress = true;
    b = _b;
  }
  Laser(int x, int y, boolean _vertical, int _moveLength)
  {
    loc = new PVector(x, y);
    vertical = _vertical;
    moving = true;
    moveLength = _moveLength;
    b = new Button(-100, -100);
  }
  void assignButton(int x, int y)
  {
    buttonPress = true;
    b = new Button(x, y);
  }
  void display()
  {
    if (!b.pressed && buttonPress || !buttonPress) {   
      if (!vertical)
      {
        wut = 0;
        while (get (int (loc.x+wut), int(loc.y)) == color(195))
        {
          fill(254, 0, 0);
          noStroke();
          ellipse(loc.x+wut, loc.y, 5, 5);
          wut+=5;
        }
        wut = 0;
        while (get (int (loc.x+wut-6), int(loc.y)) == color(195))
        {
          fill(254, 0, 0);
          noStroke();
          ellipse(loc.x+wut-2, loc.y, 5, 5);
          wut-=5;
        }
      }
      else if (vertical)
      {
        wut = 0;
        while (get (int (loc.x), int(loc.y+wut)) == color(195))
        {
          fill(254, 0, 0);
          noStroke();
          ellipse(loc.x, loc.y+wut, 5, 5);
          wut+=5;
        }
        wut = 0;
        while (get (int (loc.x), int(loc.y+wut-6)) == color(195))
        {
          fill(254, 0, 0);
          noStroke();
          ellipse(loc.x, loc.y+wut, 5, 5);
          wut-=5;
        }
      }
    }
  }
  void checkButton()
  {
    b.display();
    b.press();
  }
  void hitPlayer(Player p)
  {
    if (checkPlayer(p))
    {
      lose = true;
    }
  }
  boolean checkPlayer(Player p)
  {
    for (int i = -6; i < 6; i++)
    {
      if (get(int(p.loc.x+i), int(p.loc.y)) == color(254, 0, 0))
      {
        return true;
      }
    }
    return false;
  }
  void move()
  {
    if (!b.pressed && buttonPress || !buttonPress)
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
          if (move >= moveLength || move <= 0)
          {
            moveSpeed*=-1;
          }
        }
      }
    }
  }
}

