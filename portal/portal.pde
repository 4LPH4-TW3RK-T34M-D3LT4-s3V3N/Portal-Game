//#MOTOWNFOREVA!  #TWERKIN  #DOABACKFLIP 
boolean Options = false;
boolean Credits = false;
boolean Physics = false;
boolean Screen = true;
boolean lose = false;
boolean win;
color Brandon = color(0, 100, 255);
color AJ = color(125, 75, 50);
color Irek = color(100, 255, 100);
color Clayton = color(65, 0, 125);
color RaceWhite = color(240, 230, 175); 
color RaceBlack = color(125, 75, 50);
Cube[] cubes;
Portal orange;
Portal blue;
Level level1, level2, level3;
Player player;
Laser[] lasers;
boolean[] keys;
int currentLevel = 0;
Turret[] turret;
movingWall[] walls;


void setup()
{
  size(800, 500);
  level1 = new Level(1, "Level 1.png");
  level2 = new Level(2, "Level 2.png");
  level3 = new Level(3, "Level 3.png");
  orange = new Portal(color(255, 115, 0));
  blue = new Portal(color(0, 0, 255));
  player = new Player("P34CH35", 20, 50);

  cubes = new Cube[0];
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
      if (inbetween(width/2, height/2+10, 40, 80))
      {
        currentLevel++;
        initializeLevel();
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
    for (int i = 0; i < walls.length; i++)
    {
      walls[i].display();
      walls[i].move();
    }


    for (int i = 0; i < cubes.length; i++)
    {
      blue.checkObject(cubes[i], orange);
      orange.checkObject(cubes[i], blue);
    }
    orange.checkPlayer(player, blue);  
    blue.checkPlayer(player, orange);
    player.checkDoor();

    for (int i = 0; i < cubes.length; i++)
    {
      cubes[i].display();
      cubes[i].fall();
    }

    player.fall();
    for (int i = 0; i < lasers.length; i++)
    {
      lasers[i].display();
      lasers[i].hitPlayer(player);
      lasers[i].move();
    }

    orange.shoot(player);
    blue.shoot(player);
    player.display();
    for (int i = 0; i < cubes.length; i++)
    {
      cubes[i].onPlayer(player);
      cubes[i].hitPlayer(player);
    }

    player.move();
    player.friction();
    for (int i = 0; i < cubes.length; i++)
    {
      cubes[i].friction();
    }

    blue.display();
    orange.display();
    for (int i = 0; i < walls.length; i++)
    {
      walls[i].checkButton();
    }
    for (int i = 0; i < lasers.length; i++)
    {
      lasers[i].checkButton();
    }
    for (int i = 0; i < cubes.length; i++)
    {
      cubes[i].displayPic();
    }
    for (int i = 0; i < walls.length; i++)
    {
      walls[i].carryPlayer(player);
      blue.wallMove(walls[i]);
      orange.wallMove(walls[i]);
    }

    //    for (int i=0;i<turret.length;i++) {
    //      turret[i].display();
    //      turret[i].limitVel();
    //      turret[i].fall();
    //      turret[i].hitPlayer(player);
    //      turret[i].shoot(player);
    //      blue.checkTurret(turret[i], orange);
    //      orange.checkTurret(turret[i], blue);
    //    }
    if (lose)
    {
      textAlign(CENTER);
      fill(255, 0, 0);
      textSize(30);
      text("YOU LOSE, Press ENTER to restart level", width/2, height/2);
      noLoop();
    }
    if (win)
    {
      textAlign(CENTER);
      fill(255, 0, 0);
      textSize(30);
      text("YOU WIN, Press ENTER to go to next level", width/2, height/2);
      noLoop();
    }
  }
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
    if (keyCode == ENTER && lose)
    {
      initializeLevel();
      lose = false;
      loop();
    }
    else if (keyCode == ENTER && win)
    {
      initializeLevel();
      win = false;
      loop();
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
    if (currentLevel == 1)
    {
      walls = new movingWall[1];
      walls[0] = new movingWall(100, 100, 75, 50, true, true, 100);
      walls[0].assignButton(200, 485);
      lasers = new Laser[1];
      lasers[0] = new Laser(500, 100, true, 100);
      lasers[0].assignButton(100, 485);
      turret = new Turret[2];
      turret[0]= new Turret(200, 300);
      turret[1]= new Turret(600, 300);
      player = new Player("P34CH35", 20, 50);
      cubes = new Cube[1];
      cubes[0] = new Cube(width/2, height/2);
    }
    if (currentLevel == 2)
    {
      turret = new Turret[0];
      walls = new movingWall[0];
      cubes = new Cube[1];
      lasers = new Laser[0];
      player = new Player("P34CH35", 20, 50);
      cubes[0] = new Cube(width/2, height/2);
    }
    if (currentLevel == 3)
    {
      turret = new Turret[0];
      walls = new movingWall[0];
      cubes = new Cube[1];
      lasers = new Laser[0];
      player = new Player("P34CH35", 20, 50);
      cubes[0] = new Cube(width/2, height/2);
    }
  }
}

