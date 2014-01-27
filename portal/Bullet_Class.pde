class Bullet {
  PVector loc, vel, ploc;
  int size;
  int life;
  float rise, run;
  AudioSnippet bulletPlayer;
int stopPlaying; //stops bullet from playing in order to prevent lag
  Bullet(float x, float y, float px, float py) {
    loc = new PVector(x, y);
    ploc=new PVector(px, py);

    rise = (py-y);
    run = (px-x); 

    vel = new PVector(run/10, rise/10);// the /50 makes it go slower
    size = 1;
    life = 100;
    bulletPlayer = minim.loadSnippet("Portal2_sfx_turret_machine_gun.mp3");
    bulletPlayer.setGain(gain);
    bulletPlayer.play();
    stopPlaying = millis() + 100;
  }

  void display() {//display bullet as a color close to black
    if (life > 0)
    {
      fill(1);
      stroke(1);
      strokeWeight(2);
      ellipse(loc.x, loc.y, size, size);
    }
  }

  void update() {//bullet's life goes down so it doesnt not display when life is 0
    loc.add(vel);
    life--;
    if(stopPlaying < millis())
    {
      bulletPlayer.pause();
    }
  }
  void hit() {
    if (get(int(loc.x), int(loc.y)) == color(0) || get(int(loc.x), int(loc.y)) == color(255)||get(int(loc.x), int(loc.y)) == color(255, 0, 255) ||get(int(loc.x), int(loc.y)) == color(255, 0, 0)) {
      life=0;
      if (get(int(loc.x), int(loc.y)) == color(255, 0, 0))
      {
        lose =true;
      }
    }
  }
}

