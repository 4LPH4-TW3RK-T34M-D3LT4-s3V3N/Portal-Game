class movingWall
{
  PVector loc;
  boolean white;
  int h;
  int w;
  Button b;  
  boolean buttonPress = false;
  boolean moving;
  int moveLength;
  boolean vertical;
  int moveSpeed = 1;
  int move = 1;
  movingWall(int x, int y, int _w, int _h, boolean _white, boolean _vertical, int _moveLength)
  {
    loc = new PVector(x, y);
    w = _w;
    h = _h;
    white = _white;
    moveLength = _moveLength;
    vertical = _vertical;
  }
  void assignButton(int x, int y)
  {
    b = new Button(x, y);
    buttonPress = true;
  }
  void display()
  {

    rectMode(CENTER);
    fill(255);
    if (!white)
    {
      fill(0);
    }
    noStroke();
    rect(loc.x, loc.y, w, h);
  }
  boolean checkPlayer()
  {
    for (int i = int(-w/2); i < int(w/2); i++)
    {
      if (get(int(loc.x+i), int(loc.y-(h/2)-5)) == color(255, 0, 0))
      {
        return true;
      }
    }
    return false;
  }
  boolean checkPortal(color c)
  {
    for (int i = int(-w/2); i < int(w/2); i++)
    {
      if (get(int(loc.x+i), int(loc.y-(h/2)-1)) == color(c))
      {
        return true;
      }
    }
    for (int i = int(-w/2); i < int(w/2); i++)
    {
      if (get(int(loc.x+i), int(loc.y+(h/2)+1)) == color(c))
      {
        return true;
      }
    }
    for (int i = int(-w/2); i < int(w/2); i++)
    {
      if (get(int(loc.x+(w/2)+1), int(loc.y+i)) == color(c))
      {
        return true;
      }
    }
    for (int i = int(-w/2); i < int(w/2); i++)
    {
      if (get(int(loc.x-(w/2)-1), int(loc.y+i)) == color(c))
      {
        return true;
      }
    }
    return false;
  }
  boolean checkCube()
  {
    for (int i = int(-w/2); i < int(w/2); i++)
    {
      if (get(int(loc.x+i), int(loc.y-(h/2)-5)) == color(255, 0, 0))
      {
        return true;
      }
    }
    return false;
  }
  void carryPlayer(Player p)
  {
    print(checkPlayer());
    if (checkPlayer() && moving)
    {
      p.loc.x+=moveSpeed;
    }
  }
  void checkButton()
  {
    b.display();
    b.press();
  }
  void move()
  {      
    if (b.pressed && buttonPress || !buttonPress)
    {
      moving = true;
      if (!vertical)
      {
        loc.y+=moveSpeed;
        move+=moveSpeed;
        if (move >= moveLength || move <= 0)
        {
          moveSpeed*=-1;
        }
      }
      else if (vertical)
      {
        loc.x+=moveSpeed;
        move+=moveSpeed;
        if (move >= moveLength || move <= 0)
        {
          moveSpeed*=-1;
        }
      }
    }
    else
    {
      moving = false;
    }
  }
}

