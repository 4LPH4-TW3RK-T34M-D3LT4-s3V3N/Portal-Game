int goWall(PVector _loc, float _w, float _h)//checks if the pixel next to a certain width is not grey
{
  PVector loc = new PVector(_loc.x, _loc.y);
  float w = _w/2;
  float h = _h/2;
  if (get(int(loc.x-w-3), int(loc.y)) != color(195))
  {
    while (get (int (loc.x-w-3), int(loc.y)) != color(195))
    {
      loc.x++;
    }
    return 1;
  }
  else if (get(int(loc.x+w+4), int(loc.y)) != color(195))
  {
    while (get (int (loc.x+w+4), int(loc.y)) != color(195))
    {
      loc.x--;
    }
    return 2;
  }
  else
  {
    return 0;
  }
}
boolean goCeil(PVector _loc, float _w, float _h)//checks if the pixel above the given height is not grey
{
  PVector loc = new PVector(_loc.x, _loc.y);
  float w = _w/2;
  float h = _h/2;
  if (get(int(loc.x), int(loc.y-h+1)) != color(195))
  {
    
    return true;
  }
  else 
  {
    return false;
  }
}
boolean goGround(PVector _loc, float _w, float _h)//checks if the pixel below a certain height is not grey
{
  PVector loc = new PVector(_loc.x, _loc.y);
  float w = _w/2;
  float h = _h/2;
  if (get(int(loc.x), int(loc.y+h+1)) != color(195))
  {
    return true;
  }
  else 
  {
    return false;
  }
}

