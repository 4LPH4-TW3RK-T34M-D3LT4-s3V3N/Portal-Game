class Cube
{
  PVector loc;//location of cube
  PVector vel;//velocity of cube
  PVector acc;//acceleration of cube
  int velSet = 30;//this will keep the cube from falling too fast
  Cube(float x, float y)
  {
    loc = new PVector(x, y);
    vel = new PVector(0, 0);
    acc = new PVector(0, .1);
  }
  void display()
  {
    fill(255, 0, 255);
    noStroke();
    rectMode(CENTER);
    rect(loc.x, loc.y, 30, 30);
  }
  void displayPic()
  {
    imageMode(CENTER);
    image(loadImage("companion_cube__update__by_neorame-d52nf9a.png"),loc.x, loc.y, 35,35);//display a picture of a cube directly on the purple rectangle made. For aesthetic purposes
  }
  boolean killPlayer(Player p)
  {
    for (int i = -15; i < 15; i++)//if the cube is directly above the player, return true
    {
      if (get(int(loc.x+i), int(loc.y+30)) == color(255, 0, 0))
      {
        return true;
      }
    }
    return false;
  }
  void onPlayer(Player p)
  {
    if (killPlayer(p))
    {
      lose = true;//the player will die if it is directly under a cube
    }
  }
  void limitVel()
  {
    if (vel.y > velSet)//keeps cube from going infinitely fast
    {
      vel.y = velSet;
    }
  }
  void friction()//slows cube down horizontally
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
  void fall()
  {
    if (!goGround(loc, 30, 36))//cube will fall if the pixel directly below it is not grey
    {
      vel.add(acc);
      limitVel();
      loc.add(vel);
    }
    else
    {
      vel.y = 0;
      if (goCeil(loc, 30, 30))
      {
        while (get (int (loc.x), int(loc.y-31)) != color(195))//this keeps to cube from going past the ground
        {
          loc.y++;
        }
      }
    }
  }
  boolean hitWall()//checks if the cube is touching something on either side
  {
    if (get(int(loc.x+16), int(loc.y)) != color(195))
    {
      return true;
    }
    else if (get(int(loc.x-16), int(loc.y)) != color(195))
    {
      return true;
    }
    else
      return false;
  }
  void hitPlayer(Player p)//player can "push" cube if the player is close enough
  {
    if (get(int(loc.x-22), int(loc.y)) == color(255, 0, 0))
    {
      if (!hitWall())
      {
        loc.x = p.loc.x+27;
      }
    }
    else if (get(int(loc.x+22), int(loc.y)) == color(255, 0, 0))
    {
      if (!hitWall())
      {
        loc.x = p.loc.x-27;
      }
    }
  }
}
