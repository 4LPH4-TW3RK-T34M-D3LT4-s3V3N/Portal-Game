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
  boolean die;
  int life = 255;
  AudioPlayer player;
  int justPlayed = 1;
  Turret(float x, float y, boolean leftorRight)
  {
    loc = new PVector(x, y);
    vel = new PVector(0, 0);
    acc = new PVector(0, .1);
    player = minim.loadFile("noSound.mp3");
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
    player.play();
    fill(250, life);
    noStroke();
    rectMode(CENTER);
    if (life <= 0)
    {
      loc.set(-100, -100);
    }
    rect(loc.x, loc.y, 20, 40);
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
      if (vel.y >= velSet)
      {
        die = true;
      }
      while (get (int (loc.x+10), int(loc.y+19)) == color(0) || get(int (loc.x+10), int(loc.y+19)) == color(255))
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
  void die()
  {
    if (die)
    {
      life-=10;
      if (justPlayed != 3)
      {
        player = minim.loadFile("turretDead.wav");
        justPlayed = 3;
      }
    }
  }

  void shoot(Player p, float px) {
    if (!die)
    {
      run=(px-loc.x);
      if (checkPlayer(p))
      {
        if (justPlayed == 1 && !shoot)
        {
          justPlayed = 2;
          player = minim.loadFile("targetFound.wav");
        }
        stroke(250, 0, 0);
        strokeWeight(2);
        line(p.loc.x, p.loc.y, loc.x, loc.y); 
        if (((millis()-startTime))>800) {
          shoot = true;
        }
      }
      else
      {
        shoot = false;
        if (justPlayed == 2)
        {
          player = minim.loadFile("targetLost.wav");
          justPlayed = 1;
        }
        int random = int(random(0, 1000));
        if (random == 0 & justPlayed != 0)
        {
          player = minim.loadFile("lookTarget.wav");
          justPlayed = 1;
        }
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
            bullet.add(new Bullet(loc.x, loc.y, p.loc.x, p.loc.y));
          }
        }
        if (lTrue) {
          if (run<0) {

            bullet.add(new Bullet(loc.x, loc.y, p.loc.x, p.loc.y));
          }
        }
      }
    }
  }
}

