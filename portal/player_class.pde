class Player {

  String name;
  PVector loc, vel, acc;
  int velSet;
  Player(String playername, int locx, int locy) {
    name = playername;
    loc = new PVector(locx, locy);
    vel = new PVector(0, 0);
    acc = new PVector(0, .1);
    velSet = 20;
  }

  void display() {
    fill(255, 0, 0);
    rectMode(CENTER);
    rect(loc.x, loc.y, 12, 45);
  }
  void fall()
  {
    if (get(int(loc.x+7.5), int(loc.y+24)) == color(195))
    {
      vel.add(acc);
      limitVel();
      loc.add(vel);
    }
    else if (get(int(loc.x+7.5), int(loc.y+24)) == color(0) || get(int(loc.x+7.5), int(loc.y+24)) == color(255,0,255))
    {
      while (get (int (loc.x+7.5), int(loc.y+20)) == color(0) || get (int (loc.x+7.5), int(loc.y+20)) == color(255,0,255))
      {
        loc.y--;
      }
      vel.set(0, 0);
    }
  }
  void hitCube(Cube c)
  {
    if (dist(loc.x, loc.y, c.loc.x, c.loc.y) < 22)
      if (loc.y > c.loc.y)
      {
        loc.y = c.loc.y-15;
      }
  }
  void hitCeiling()
  {
    if (get(int(loc.x+7.5), int(loc.y-24)) == color(0))
    {
      while (get (int (loc.x+7.5), int(loc.y-23)) == color(0))
      {
        loc.y++;
      }
      vel.set(0, 0);
    }
  }
  void limitVel()
  {
    if (vel.y > velSet)
    {
      vel.y = velSet;
    }
  }

  void move() {
    
    
    
    
    
    
    
    if (keys[0]) {
      vel.x = 1;
    } 
    else if (keys[1]) {
      vel.x = -1;
    } 
    else {
      vel.x = 0;
    }

    if (keys[2]) {
      vel.y = -1;
      
    }      
    loc.add(vel);
  }
}

