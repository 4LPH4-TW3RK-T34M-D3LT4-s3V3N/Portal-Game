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
  ArrayList<Bullet> bullet = new ArrayList<Bullet>();//each turret gets an arrayList of bullets
  boolean rTrue = false;
  boolean lTrue = false;
  boolean die;
  int life = 400;
  AudioPlayer player;
  int justPlayed = 1;
  PImage image;
  Turret(float x, float y, boolean leftorRight)
  {
    loc = new PVector(x, y);
    vel = new PVector(0, 0);
    acc = new PVector(0, .1);
    player = minim.loadFile("noSound.mp3");
    if (leftorRight)//makes turret face left or right
    {
      lTrue = true;
      image = turretpicr;
    }
    if (!leftorRight)
    {
      rTrue = true;
      image = turretpicl;
    }
  }
  void display()
  {
    fill(250);//display turret
    player.setGain(gain);
    player.play();
    fill(250, life);
    noStroke();
    rectMode(CENTER);
    //rect(loc.x, loc.y, 20, 40);
    if (die && life <= 0)
    {
      loc.set(-100, -100);
    }
  }
  void limitVel()//keeps turret from going infinitely dast
  {
    if (vel.y > velSet)
    {
      vel.y = velSet;
    }
  }
 
  void fall()
  {
    if (get(int(loc.x+10), int(loc.y+21)) == color(195))//turret falls
    {
      vel.add(acc);
      limitVel();
      loc.add(vel);
    }
    else
    {
      while (get (int (loc.x+10), int(loc.y+20)) != color(195))//puts turret back on the ground
      {
        loc.y--;
      }
      if (vel.y >= velSet)//kills turret if it moves too fast
      {
        die();
      }
      vel.set(0, 0);
    }
  }
  void die()//kills turret
  {
    die = true;
    if (justPlayed != 3)
    {
      player = minim.loadFile("turretDead" + int(random(6)) + ".wav");
      justPlayed = 3;
    }
    if (die)
    {
      life--;
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
  boolean checkPlayer(Player p)//check for player
  {
    if (dist(loc.x, 0, p.loc.x, 0) < 100 && p.loc.y <= loc.y+15 && p.loc.y > loc.y-100) {
      if (timer==true) {
        startTime=millis();
        timer=false;
      }
    }
    else {
      timer=true;
    }
    if (dist(loc.x, 0, p.loc.x, 0) < 100 && p.loc.y <= loc.y+15 && p.loc.y > loc.y-100)
    {
      return true;
    }
    else
    {
      return false;
    }
  }
  void show() {//dsplay picture of turret
    imageMode(CENTER);
    if (!die)
    {
      tint(255, life);
      if (rTrue) {
        image(turretpicr, loc.x, loc.y-10, 50, 70);
      }
      if (lTrue) {
        image(turretpicl, loc.x, loc.y-10, 50, 70);
      }
    }
  }

  void shoot(Player p, float px) {//shoot player depending on direction its facing
    if (!die)
    {
      run=(px-loc.x);
      if (checkPlayer(p))
      {
        if (justPlayed == 1 && !shoot)
        {
          justPlayed = 2;
          player = minim.loadFile("targetFound" + int(random(7)) + ".wav");
        }
        if (rTrue) {//shows a red laser before shooting
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
        if (justPlayed == 2)
        {
          player = minim.loadFile("targetLost" + int(random(2)) + ".wav");
          justPlayed = 1;
        }
        int random = int(random(0, 2000));
        if (random == 0 & justPlayed != 0)
        {
          player = minim.loadFile("lookTarget" + int(random(4)) + ".wav");
          justPlayed = 1;
        }
      }

      for (int i = bullet.size()-1; i >=0; i--) {//shoots bullet
        Bullet b = bullet.get(i);
        b.hit();
        b.display();
        b.update();
        if (b.life <= 0) {
          bullet.remove(i);
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
}
