
class Button {

  PVector loc;
  boolean pressed;
  boolean play = true;
  int h;
  int w;

  Button(int x, int y)
  {
    loc = new PVector(x, y);
    w = 75;
    h = 10;
  }
  void display()
  {
    noStroke();
    fill(254, 0, 0);
    rect(loc.x, loc.y, w, h);
  }
  boolean checkPress()
  {
    for (int i = -30; i < 30; i++)
    {
      if (get(int(loc.x+i), int(loc.y-6)) != color(195))
      {
        return true;
      }
    }
    return false;
  }
  void press()
  {
    if (checkPress())
    {    
      if (play)
      {
        buttonPlayer = minim.loadFile("Portal2_sfx_button_positive.mp3");
      }
      play = false;
      buttonPlayer.play();
      pressed = true;
      if (h > 5)
      {
        loc.y++;
        h--;
      }
      else if (h <= 5)
      {
        h = 5;
      }
    }
    else
    {
      if (!play)
      {
        buttonPlayer = minim.loadFile("Portal2_sfx_button_negative.mp3");
      }
      play = true;
      buttonPlayer.play();
      pressed = false;
      if (h < 10)
      {
        h++;
        loc.y--;
      }
      if (h >= 10)
      {
        h = 10;
      }
    }
  }
}

