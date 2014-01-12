//#MOTOWNFOREVA!  #TWERKIN  #DOABACKFLIP
boolean Options = false;
boolean Credits = false;
boolean Physics = false;
boolean Screen = true;
color Brandon = color(0, 100, 255);
color AJ = color(255, 100, 0);
color Irek = color(100, 255, 100);
color Clayton = color(65, 0, 125);
color RaceWhite = color(240, 230, 175); 
color RaceBlack = color(125, 75, 50);
Cube cube;
Portal orange;
Portal blue;
Level level1, level2, level3;
Player player;
boolean[] keys;
int currentLevel = 0;
Turret[] turret=new Turret[2];
ArrayList<Bullet> bullet = new ArrayList<Bullet>();

void setup()
{
  size(800, 500);
  cube = new Cube(width/2, height/2);
  level1 = new Level(1, "Level 1.png");
  level2 = new Level(2, "Level 2.png");
  level3 = new Level(3, "Level 3.png");
  orange = new Portal(color(255, 115, 0));
  blue = new Portal(color(0, 0, 255));
  player = new Player("P34CH35", 20, 50);
  turret[0]= new Turret(200, 300);
  turret[1]= new Turret(600, 300);
  keys=new boolean[3];
  keys[0]=false;
  keys[1]=false;
  keys[2]=false;
}
void draw()
{
  if (currentLevel == 0)
  {
    if (Screen) {
      background(250);
      rectMode(CENTER);
      fill(0);
      rect(width/2, height/2+10, 40, 80);
      stroke(5);
      line(0, 0, width/2-75, height/2-50);
      line(width, 0, width/2+75, height/2-50);
      line(0, height, width/2-75, height/2+50);
      line(width, height, width/2+75, height/2+50);
      noFill();
      rect(width/2, height/2, 150, 100);
      noStroke();
      fill(255, 125, 0);
      rect(width/2-250, 425, 200, 75);
      rect(width/2+250, 425, 200, 75);
      if (inbetween(width/2-250, 425, 200, 75)) {
        Options = true;
        Screen = false;
      }
      if (inbetween(width/2+250, 425, 200, 75)) {
        Physics = true;
        Screen = false;
      }
      if(inbetween(width/2, height/2+10, 40, 80))
      {
        currentLevel++;
      }
      fill(0, 0, 255);
      rect(width/2, 425, 200, 75);
      if (inbetween(width/2, 425, 200, 75)) {
        Credits = true;
        Screen = false;
      }

      fill(0);
      textAlign(CENTER);
      textMode(CENTER);
      textSize(50);
      text("Physics", width/2-250, 438);
      text("Options", width/2+250, 438); 
      text("Credits", width/2, 438);
      text("Portal: The Second Dimension", width/2, 100);
    }
    if (Credits) {

      background(0, 0, 255); 
      strokeWeight(1);
      stroke(0);
      if (back(inbetween(50, 50, 50, 50))) {
        Screen = true;
        Credits = false;
      }

      character(width/2+75, height/2-25, "Brandon\nDonohue", Brandon, RaceWhite, "UI Designer");
      character(width/2+225, height/2+25, "AJ\nSavoca", AJ, RaceWhite, "Monkey Boy");
      character(width/2-75, height/2+25, "Irek\nSciezcka", Irek, RaceWhite, "Graphics");
      character(width/2-225, height/2-25, "Clayton\nMcLean", Clayton, RaceBlack, "HeadProgrammer");
    }
    if (Physics) {
      background(255, 125, 0);
      if (back(inbetween(50, 50, 50, 50))) {
        Screen = true;
        Physics = false;
      }
    }
    if (Options) {
      background(255, 125, 0);
      if (back(inbetween(50, 50, 50, 50))) {
        Screen = true;
        Options = false;
      }
    }
  }
  else
  {
    level1.display();
    level2.display();
    level3.display();


    orange.checkObject(cube, blue);
    orange.checkPlayer(player, blue);  
    blue.checkPlayer(player, orange);
    blue.checkObject(cube, orange);
    player.checkDoor();

    cube.display();

    cube.fall();
    player.fall();

    orange.shoot(player);
    blue.shoot(player);

    player.display();
    cube.hitPlayer(player);

    player.move();
    player.friction();
    cube.friction();
    blue.display();
    orange.display();
    for (int i=0;i<turret.length;i++) {
      turret[i].display();
      turret[i].limitVel();
      turret[i].fall();
      turret[i].hitPlayer(player);
    }
    for (int i = bullet.size()-1; i >=0; i--) {
      Bullet b = bullet.get(i);
      b.display();
      b.update();
      b.hit();
      if (b.life <= 0) {
        bullet.remove(i);
      }
    }
  }
  // bullet.add(new Bullet(turret[0].loc.x, turret[0].loc.y, player.loc.x, player.loc.y));
  //bullet.add(new Bullet(turret[1].loc.x, turret[1].loc.y, player.loc.x, player.loc.y));
}
void keyPressed()
{
  if (currentLevel != 0)
  {
    if (key=='d') {
      keys[0]=true;
    }
    if (key=='a') {
      keys[1]=true;
    }
    if (key==' ') {
      keys[2]=true;
    }
  }
}

void keyReleased()
{
  if (currentLevel != 0)
  {
    if (key=='d') {
      keys[0]=false;
    }
    if (key=='a') {
      keys[1]=false;
    }
    if (key==' ') {
      keys[2]=false;
    }
    orange.dissapear();
    blue.dissapear();
  }
}

void mousePressed()
{
  if (currentLevel != 0)
  {
    if (mouseButton == LEFT)
    {
      orange.appear();
    }
    if (mouseButton == RIGHT)
    {
      blue.appear();
    }
  }
}
void initializeLevel()
{
  if (currentLevel != 0)
  {
    orange = new Portal(color(255, 115, 0));
    blue = new Portal(color(0, 0, 255));
    if (currentLevel == 2)
    {
      player = new Player("P34CH35", 20, 50);
      cube = new Cube(width/2, height/2);
    }
    if (currentLevel == 3)
    {
      player = new Player("P34CH35", 20, 50);
      cube = new Cube(width/2, height/2);
    }
  }
}

