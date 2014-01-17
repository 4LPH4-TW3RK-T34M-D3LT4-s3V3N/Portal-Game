boolean Options = false;
boolean Credits = false;
boolean Physics = false;
boolean Screen = true;
boolean lose = false;
boolean tutorial = false;
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
Level[] levels = new Level[9];
tLevel[] tLevels = new tLevel[5];
Player player;
Laser[] lasers;
boolean[] keys;
int currentLevel = 0;
int whichTLevel = 0;
Turret[] turret;
movingWall[] walls;
int changeLevel = 1;

void setup()
{
  size(800, 500);
  for (int i = 1; i < levels.length; i++)
  {
    levels[i-1] = new Level(i, "Level " + i + ".png");
  }
  for (int i = 1; i < tLevels.length; i++)
  {
    tLevels[i-1] = new tLevel(i, "Tutorial" + i + ".png");
  }
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
  if (currentLevel == 0 && whichTLevel == 0)
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
      if (inbetween(width/2+250, 425, 200, 75)) {
        Options = true;
        Screen = false;
      }
      if (inbetween(width/2-250, 425, 200, 75)) {
        Physics = true;
        Screen = false;
        tutorial = true;
        whichTLevel = 1;
        initialzeTLevel();
      }
      if (inbetween(width/2, height/2+10, 40, 80))
      {
        currentLevel = changeLevel;
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
    if (!tutorial)
    {
      for (int i = 1; i < levels.length; i++)
      {
        levels[i-1].display();
      }
    }
    else
    {
      for (int i = 1; i < tLevels.length; i++)
      {
        tLevels[i-1].display();
      }
    }
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
    for (int i=0;i<turret.length;i++) 
    {
      blue.checkTurret(turret[i], orange);
      orange.checkTurret(turret[i], blue);
    }
    orange.checkPlayer(player, blue);  
    blue.checkPlayer(player, orange);
    player.checkDoor();
    player.move();

    for (int i = 0; i < cubes.length; i++)
    {
      cubes[i].display();
      cubes[i].fall();
    }
    for (int i=0;i<turret.length;i++) {
      turret[i].display();
      turret[i].limitVel();
      turret[i].fall();
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
    for (int i=0;i<turret.length;i++) {
      turret[i].hitPlayer(player);
      turret[i].shoot(player, player.loc.x);
    }
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
  print(Credits);
}
void keyPressed()
{
  if (currentLevel != 0 || whichTLevel != 0)
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
      if (!tutorial)
      {
        initializeLevel();
        lose = false;
        loop();
      }
      else
      {
        win = false;
        initialzeTLevel();
        loop();
      }
    }
    else if (keyCode == ENTER && win)
    {
      if (!tutorial)
      {
        currentLevel++;
        initializeLevel();
        win = false;
        loop();
      }
      else
      {
        whichTLevel++;
        win = false;
        if (whichTLevel == 5)
        {
          turret = new Turret[0];
          walls = new movingWall[0];
          cubes = new Cube[0];
          lasers = new Laser[0];
          player = new Player("P34CH35", 20, 200);
          Screen = true;
          tutorial = false;
          Physics = false;
          whichTLevel = 0;
        }
        else
        {
          initialzeTLevel();
        }
        loop();
      }
    }
  }
}

void keyReleased()
{
  if (currentLevel != 0 || whichTLevel != 0)
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
  if (currentLevel != 0 || whichTLevel != 0)
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
void initialzeTLevel()
{
  orange = new Portal(color(255, 115, 0));
  blue = new Portal(color(0, 0, 255));
  if (whichTLevel == 1)
  {
    turret = new Turret[0];
    walls = new movingWall[0];
    cubes = new Cube[0];
    lasers = new Laser[0];
    player = new Player("P34CH35", 20, 200);
  }
  if (whichTLevel == 2)
  {
    turret = new Turret[0];
    walls = new movingWall[0];
    cubes = new Cube[1];
    lasers = new Laser[1];
    player = new Player("P34CH35", 20, 200);
    cubes[0] = new Cube(100, 300);
    lasers[0] = new Laser(546, 100, true);
    lasers[0].assignButton(445, 490);
  }
  if (whichTLevel == 3)
  {
    turret = new Turret[0];
    walls = new movingWall[0];
    cubes = new Cube[0];
    lasers = new Laser[0];
    player = new Player("P34CH35", 20, 200);
  }
  if (whichTLevel == 4)
  {
    turret = new Turret[1];
    walls = new movingWall[0];
    cubes = new Cube[0];
    lasers = new Laser[0];
    player = new Player("P34CH35", 20, 200);
    turret[0] = new Turret(400, 460, true);
  }
  if (whichTLevel == 5)
  {
    turret = new Turret[0];
    walls = new movingWall[0];
    cubes = new Cube[0];
    lasers = new Laser[0];
    player = new Player("P34CH35", 20, 200);
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
      walls = new movingWall[0];
      lasers = new Laser[0];
      turret = new Turret[2];
      turret[0]= new Turret(200, 300, true);
      turret[1]= new Turret(600, 300, false);
      player = new Player("P34CH35", 20, 50);
      cubes = new Cube[1];
      cubes[0] = new Cube(width/2, height/2);
    }
    if (currentLevel == 2)
    {
      turret = new Turret[0];
      walls = new movingWall[0];
      cubes = new Cube[0];
      lasers = new Laser[0];
      player = new Player("P34CH35", 20, 50);
    }
    if (currentLevel == 3)
    {
      turret = new Turret[0];
      walls = new movingWall[0];
      cubes = new Cube[0];
      lasers = new Laser[0];
      player = new Player("P34CH35", 20, 50);
    }
    if (currentLevel == 3)
    {
      turret = new Turret[0];
      walls = new movingWall[0];
      cubes = new Cube[0];
      lasers = new Laser[0];
      player = new Player("P34CH35", 20, 50);
    }
    if (currentLevel == 4)
    {
      turret = new Turret[0];
      walls = new movingWall[1];
      cubes = new Cube[2];
      cubes[0] = new Cube(650, 39);
      cubes[1] = new Cube(218, 390);
      lasers = new Laser[1];
      lasers[0] = new Laser(733, 491, true);
      walls[0] = new movingWall(144, 104, 131, 25, false, false, 300);
      lasers[0].assignButton(702, 79);
      walls[0].assignButton(535, 485);
      player = new Player("P34CH35", 20, 50);
    }
    if (currentLevel == 5)
    {  
      turret = new Turret[1];
      turret[0] = new Turret(389, 456, true);
      walls = new movingWall[0];
      cubes = new Cube[0];
      lasers = new Laser[0];
      player = new Player("P34CH35", 20, 50);
    }
    if (currentLevel == 6)
    {  
      turret = new Turret[0];
      walls = new movingWall[0];
      cubes = new Cube[0];
      lasers = new Laser[0];
      player = new Player("P34CH35", 20, 50);
    }
    if (currentLevel == 7)
    {  
      turret = new Turret[0];
      walls = new movingWall[0];
      cubes = new Cube[0];
      lasers = new Laser[0];
      player = new Player("P34CH35", 20, 400);
    }
    if (currentLevel == 8)
    {  
      turret = new Turret[0];
      walls = new movingWall[0];
      cubes = new Cube[0];
      lasers = new Laser[0];
      player = new Player("P34CH35", 760, 36);
    }
  }
}
