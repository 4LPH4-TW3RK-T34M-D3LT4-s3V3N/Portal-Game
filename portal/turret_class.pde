class Turret
{ 
  PVector loc;
  PVector vel;
  PVector acc;
  int size;
  float run;
  float startTime;
  boolean shoot = true;
  int velSet = 30;
  boolean timer=true;
  ArrayList<Bullet> bullet = new ArrayList<Bullet>();
  boolean rTrue = false;
  boolean lTrue = false;

  Turret(float x, float y, boolean leftorRight)
  {
    loc = new PVector(x, y);
    vel = new PVector(0, 0);
    acc = new PVector(0, .1);
    if (leftorRight)
    {
      lTrue = true;
    }
    if (!leftorRight)
    {
      rTrue = true;
    }
  }
  void display()
  {
    fill(250);
    noStroke();
    rectMode(CENTER);
    //rect(loc.x, loc.y, 20, 40);
  }
  void limitVel()
  {
    if (vel.y > velSet)
    {
      vel.y = velSet;
    }
  }
  void fall()
  {
    if (get(int(loc.x+10), int(loc.y+21)) == color(195))
    {
      vel.add(acc);
      limitVel();
      loc.add(vel);
    }
    else //if(get(int(loc.x+15), int(loc.y+15)) == color(0))
    {
      while (get (int (loc.x+10), int(loc.y+30)) == color(0) || get(int (loc.x+10), int(loc.y+30)) == color(255))
      {
        loc.y--;
      }
      vel.set(0, 0);
    }
  }
  void faceLeft() {
    lTrue=true;
  }
  void faceRight() {
    rTrue=true;
  }
  void hitPlayer(Player p)
  {
    if (dist(loc.x, loc.y, p.loc.x, p.loc.y) <17 && loc.x > p.loc.x && p.loc.y > loc.y-20)
    {
      loc.x = p.loc.x+17;
    }
    else if (dist(loc.x, loc.y, p.loc.x, p.loc.y) < 17 && loc.x < p.loc.x && p.loc.y > loc.y-20)
    {   
      loc.x = p.loc.x-17;
    }
  }
  boolean checkPlayer(Player p)
  {
    if (dist(loc.x, 0, p.loc.x, 0) < 100 && p.loc.y <= loc.y+15) {
      if (timer==true) {
        startTime=millis();
        timer=false;
      }
    }
    else {
      timer=true;
    }
    if (dist(loc.x, 0, p.loc.x, 0) < 100 && p.loc.y <= loc.y+15)
    {
      return true;
    }
    else
    {
      return false;
    }
  }
  void show() {
    imageMode(CENTER);
    if (rTrue) {
      image(turretpicr, loc.x, loc.y-10, 50, 70);
    }
    if (lTrue) {
      image(turretpicl, loc.x, loc.y-10, 50, 70);
    }
  }

  void shoot(Player p, float px) {
    run=(px-loc.x);
    if (checkPlayer(p))
    {
      if (rTrue) {
        stroke(250, 0, 0);
        strokeWeight(2);
        line(p.loc.x, p.loc.y, loc.x+10, loc.y-13);
      }

      if (lTrue) {
        stroke(250, 0, 0);
        strokeWeight(2);
        line(p.loc.x, p.loc.y, loc.x-10, loc.y-13);
      }
      if (((millis()-startTime))>800) {
        shoot = true;
      }
    }
    else
    {
      shoot = false;
    }

    for (int i = bullet.size()-1; i >=0; i--) {
      Bullet b = bullet.get(i);
      b.hit();
      b.display();
      b.update();
      if (b.life <= 0) {
        bullet.remove(i);
      }
    }
    if (shoot) {
      if (rTrue) {
        if (run>0) {
          bullet.add(new Bullet(loc.x+10, loc.y-13, p.loc.x, p.loc.y));
        }
      }
      if (lTrue) {
        if (run<0) {

          bullet.add(new Bullet(loc.x-10, loc.y-13, p.loc.x, p.loc.y));
        }
      }
    }
  }
}

