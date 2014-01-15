class movingWall
{
  PVector loc;
  boolean white;
  int h;
  int w;
  Button b;  
  boolean buttonPress = false;
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
  void checkButton()
  {
    b.display();
    b.press();
  }
  void move()
  {      
    if (b.pressed && buttonPress || !buttonPress)
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
  }
}

