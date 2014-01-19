class Player {

  String name;
  PVector loc, vel, acc;//location, velocity, acceleration PVectors
  int velSet;//velocity set so player cannot go too fast
  Player(String playername, int locx, int locy) {
    name = playername;
    loc = new PVector(locx, locy);
    vel = new PVector(0, 0);
    acc = new PVector(0, .1);
    velSet = 15;
  }
  color terminalVel()//checks what the player will touch in the next frame using current velocity
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
  void checkDoor() {//if the player touches the light blue color of a door from the left side, the level will be won
    if (get(int(loc.x+15), int(loc.y)) == color(128, 255, 255)) {
      textSize(40);
      textAlign(CENTER);
      win = true;
      //initializeLevel();
    }
  }

  void fall()
  {
    if (!goGround(loc, 12, 45)) 
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
    if (goWall(loc, 12, 45) == 1 || goWall(loc, 12, 45) == 2)//keeps player from walking into a wall, literally
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
  void limitVel()//keeps player from falling too fast
  {
    if (vel.y > velSet)
    {
      vel.y = velSet;
    }
  }
  void friction()//horizontally slows down player
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

    if (keys[0] && goWall(loc, 12, 45) != 2) {//makes player move right if it is not touching a wall on the right side
      if (vel.x >= 0 && vel.x < 1)
      {
        vel.x = 1;
      }
    } 
    else if (keys[1] && goWall(loc, 12, 45) != 1) {//makes player move left if it is not touching a wall on the left side
      if (vel.x <= 0 && vel.x > -1)
      {
        vel.x = -1;
      }
    } 

    if (keys[2] && goGround(loc, 12, 45)) {//player will "jump" if it is on the ground
      vel.y = -3;
    }      
    loc.add(vel);
  }
}

