class movingWall
{
  PVector loc;//location of wall
  boolean white;//decides if the wall will be white (portal accessible) or not
  int h;//height of wall
  int w;//width of wall
  Button b;  //button that will make wall move (optional)
  boolean buttonPress = false;//decides if the wall is assigned to a button or not
  boolean moving;//decides if the wall will move or not
  int moveLength;//how much the wall will move (if it does)
  boolean vertical;//decides if the wall will move vertically or horizontally
  int moveSpeed = 1;//speed of moving wall
  int move = 1;//will help decide when to switch directions
  movingWall(int x, int y, int _w, int _h, boolean _white, boolean _vertical, int _moveLength)
  {
    loc = new PVector(x, y);
    w = _w;
    h = _h;
    white = _white;
    moveLength = _moveLength;
    vertical = _vertical;
    b = new Button(-100, -100);//puts button off the screen if its not assigned
  }
  void assignButton(int x, int y)//assigns a button to the wall
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
    for (int i = int(-w/2); i < int(w/2); i++)//check if the player's red color is above the wall
    {
      if (get(int(loc.x+i), int(loc.y-(h/2)-5)) == color(255, 0, 0))
      {
        return true;
      }
    }
    return false;
  }
  boolean checkPortal(color c)//checks if a portal is touching the wall (only appliable to white walls). Checks every side
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
  boolean checkCube()//checks if a cube is above the wall
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
  void carryPlayer(Player p)//moves the player with the wall if it is on top of the wall
  {
    if (checkPlayer() && moving && !vertical)
    {
      p.loc.x+=moveSpeed;
    }
  }
  void checkButton()//display the button the wall is assigned to
  {
    b.display();
    b.press();
  }
  void move()
  {      
    if (b.pressed && buttonPress || !buttonPress)//the wall will move infinitely if buttonPress is false because it is not assigned to a button in that case
    {
      moving = true;
      if (vertical)
      {
        loc.y+=moveSpeed;
        move+=moveSpeed;
        if (move >= moveLength || move <= 0)//move variables calculates how far the wall has moved and switches directing accordingly
        {
          moveSpeed*=-1;
        }
      }
      else if (!vertical)
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
      moving = false;//keeps object above the wall from moving when the wall is not moving
    }
  }
}
