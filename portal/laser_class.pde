class Laser
{
  PVector loc;//location of laser
  boolean vertical;//decide if the laser is vertical or horizontal
  boolean moving;//decide if the laser is moving
  int span;//helps decide how far the laser shoots
  int moveLength;//how much the laser will move
  boolean buttonPress  = false;//decides if the laser is assigned to a button
  Button b;//the button a laser can be assigned to
  int move = 1;
  int moveSpeed = 1;
  Laser(int x, int y, boolean _vertical)
  {
    loc = new PVector(x, y);
    vertical = _vertical;
    moving = false;
    b = new Button(-100, -100);//puts button off the screen if its not assigned
  }
  Laser(int x, int y, boolean _vertical, int _moveLength)//two different constructors deciding if the laser will move or not
  {
    loc = new PVector(x, y);
    vertical = _vertical;
    moving = true;
    moveLength = _moveLength;
    b = new Button(-100, -100);
  }
  void assignButton(int x, int y)//assign a button to the laser
  {
    buttonPress = true;
    b = new Button(x, y);
  }
  void display()
  {
    if (!b.pressed && buttonPress || !buttonPress) {   
      if (!vertical)
      {
        span = 0;
        while (get (int (loc.x+span), int(loc.y)) == color(195))//laser will continue spanning if there is grey in the line directly above and below (or across, if horizontal) its initial location PVector
        {
          fill(254, 0, 0);
          noStroke();
          ellipse(loc.x+span, loc.y, 5, 5);
          span+=5;
        }
        span = 0;
        while (get (int (loc.x+span-6), int(loc.y)) == color(195))
        {
          fill(254, 0, 0);
          noStroke();
          ellipse(loc.x+span-2, loc.y, 5, 5);
          span-=5;
        }
      }
      else if (vertical)
      {
        span = 0;
        while (get (int (loc.x), int(loc.y+span)) == color(195))
        {
          fill(254, 0, 0);
          noStroke();
          ellipse(loc.x, loc.y+span, 5, 5);
          span+=5;
        }
        span = 0;
        while (get (int (loc.x), int(loc.y+span-6)) == color(195))
        {
          fill(254, 0, 0);
          noStroke();
          ellipse(loc.x, loc.y+span, 5, 5);
          span-=5;
        }
      }
    }
  }
  void checkButton()//displays button
  {
    b.display();
    b.press();
  }
  void hitPlayer(Player p)
  {
    if (checkPlayer(p))//player will die if it hits thw lazer
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
    for (int i = -6; i < 6; i++)
    {
      if (get(int(p.loc.x), int(p.loc.y+i)) == color(254, 0, 0))
      {
        return true;
      }
    }
    return false;
  }
  void move()//moves laser the same way a movingWall is moved (see movingWall class)
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

