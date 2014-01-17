class Player {

  String name;
  PVector loc, vel, acc;
  int velSet;
  Player(String playername, int locx, int locy) {
    name = playername;
    loc = new PVector(locx, locy);
    vel = new PVector(0, 0);
    acc = new PVector(0, .1);
    velSet = 15;
  }
  color terminalVel()
  {
    for (int i = 0; i < vel.y; i++)
    {
      if (get(int(loc.x+7.5), int(loc.y+19+i)) != color(195))
      {
        return get(int(loc.x+7.5), int(loc.y+19+i));
      }
    }
    for (int i = 0; i > vel.y; i--)
    {
      if (get(int(loc.x+7.5), int(loc.y-19+i)) != color(195))
      {
        return get(int(loc.x+7.5), int(loc.y+19+i));
      }
    }
    return color(195);
  }



  void display() {
    fill(255, 0, 0);
    noStroke();
    rectMode(CENTER);
    rect(loc.x, loc.y, 12, 45);
  }
  void checkDoor() {
    if (get(int(loc.x+15), int(loc.y)) == color(128, 255, 255)) {
      textSize(40);
      textAlign(CENTER);
      win = true;
      //initializeLevel();
    }
  }

  void fall()
  {
    //  if (get(int(loc.x), int(loc.y+24)) == color(195) && terminalVel() == color(195))
    if (!goGround(loc, 12, 45)) //&& terminalVel() == color(195))
    {
      vel.add(acc);
      limitVel();
      loc.add(vel);
    }
    if (goCeil(loc, 12, 45) || goGround(loc, 12, 45))
    {
      while (get (int (loc.x), int(loc.y+(45/2)+1)) != color(195))
      {
        loc.y--;
      }
      while (get (int (loc.x), int(loc.y-(45/2)-1)) != color(195))
      {
        loc.y++;
      }
      vel.y*=-.25;
    }
    if (goWall(loc, 12, 45) == 1 || goWall(loc, 12, 45) == 2)
    {
      if (goWall(loc, 12, 45) == 1)
      {
        while (get (int (loc.x-3), int(loc.y)) != color(195))
        {
          loc.x++;
        }
      }
      if (goWall(loc, 12, 45) == 2)
      {
        while (get (int (loc.x+4), int(loc.y)) != color(195))
        {
          loc.x--;
        }
      }
      vel.x*=-.5;
    }
  }
  void limitVel()
  {
    if (vel.y > velSet)
    {
      vel.y = velSet;
    }
  }
  void friction()
  {
    if (vel.x > 0)
    {
      vel.x-=0.1;
      if (vel.x < .01)
      {
        vel.x = 0;
      }
    }
    if (vel.x < 0)
    {
      vel.x+=.1;
      if (vel.x > -.01)
      {
        vel.x = 0;
      }
    }
  }
  void move() {

    if (keys[0] && goWall(loc, 12, 45) != 2) {
      if (vel.x >= 0 && vel.x < 1)
      {
        vel.x = 1;
      }
    } 
    else if (keys[1] && goWall(loc, 12, 45) != 1) {
      if (vel.x <= 0 && vel.x > -1)
      {
        vel.x = -1;
      }
    } 
    //else if(!keys[1] && ! keys[2] && vel.x == 1)
    // {
    //   vel.x = 0;
    //  }
    //  else {
    //  vel.x = 0;
    // }

    if (keys[2] && goGround(loc, 12, 45)) {
      vel.y = -3;
    }      
    loc.add(vel);
  }
}

