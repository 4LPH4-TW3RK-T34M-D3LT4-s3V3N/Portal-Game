import ddf.minim.spi.*;//import music stuff
import ddf.minim.signals.*;
import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.ugens.*;
import ddf.minim.effects.*;

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
Level[] levels = new Level[36];//array for all levels
tLevel[] tLevels = new tLevel[6];//array for all tutorial levels
String[] loadData;
int changeLevel;
Player player;
Laser[] lasers;
boolean[] keys;
int currentLevel = 0;
int whichTLevel = 0;
Turret[] turret;
movingWall[] walls;
PImage portalCursor, portalBlue, portalOrange, portalNone;
PImage door, doorclosed;
PImage turretpicr, turretpicl;
boolean pause;
int pausedTime;
int newTime;
int resultTime;
Minim minim, portalMinim;
AudioPlayer soundEffects;
AudioPlayer music;
int maxMusic = 3;
int saveLevel;
int gain = 0;
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
  portalCursor=loadImage("portal cursor.png");
  portalBlue=loadImage("portalbluecursor.png");
  portalOrange=loadImage("portalorangecursor.png");
  portalNone=loadImage("portalnonecursor.png");
  door=loadImage("door.png");
  doorclosed=loadImage("doorclosed.png");
  turretpicr=loadImage("turret.png");
  turretpicl=loadImage("turret2.png");
  minim = new Minim(this);
  music = minim.loadFile("menu" + int(random(1, maxMusic)) + ".mp3");
  music.setGain(gain);
  music.loop();
  loadData = loadStrings("data.txt");
  changeLevel = int(loadData[0]);
}
void intro()
{
  background(0);
  imageMode(CENTER);
  noTint();
  image(loadImage("title screen.png"), width/2, height/2);
}
void draw()
{
  if (millis() <= 5000)//displays intro screen for 5 seconds
  {
    intro();
    return;
  }
  music.setGain(gain);
  if (orange.appear && blue.appear) {//displays different cursor depending on if the portals are appearing or not
    cursor(portalNone);
  }
  else if (orange.appear) {
    cursor(portalBlue);
  }
  else if (blue.appear) {
    cursor(portalOrange);
  }
  else {
    cursor(portalCursor);
  }
  if (currentLevel == 0 && whichTLevel == 0)//displays menu if actual game is not playing
  {
    if (Screen) {
      background(250);
      rectMode(CENTER);
      fill(0);
      rect(width/2, height/2, 40, 80);
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
      if (dist(width/2, height/2, mouseX, mouseY)<50) {
        imageMode(CENTER);
        noTint();
        image(door, width/2, height/2, 200, 130);
      }
      else {
        imageMode(CENTER);
        noTint();
        image(doorclosed, width/2, height/2, 200, 130);
      }
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
      textSize(20);
      text("Press P at any time during the game to pause", width/2, 490);
    }
    if (Credits) {//displays credits
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
    if (Physics) {//make tutorial true
      background(255, 125, 0);
      if (back(inbetween(50, 50, 50, 50))) {
        Screen = true;
        Physics = false;
      }
    }
    if (Options) {//display options screen
      background(255, 125, 0);
      text("There are no options, but you an press m to mute/unmute sound", width/2, height/2);
      Screen = true;
      Options = false;
    }
  }

  else
  {
    //the functions of each class required for the actual levels will be executed here. They must be executed in a specific order for the game to work properly.
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

    player.checkDoor();
    for (int i=0;i<turret.length;i++) {

      turret[i].display();
    }
    for (int i = 0; i < cubes.length; i++)
    {
      cubes[i].display();
      cubes[i].fall();
    }
    for (int i=0;i<turret.length;i++) {
      turret[i].limitVel();
      turret[i].fall();
      turret[i].show();
    }

    player.move();

    orange.checkPlayer(player, blue);  
    blue.checkPlayer(player, orange);
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
    if (lose)//display lose screen and stops looping
    {
      textAlign(CENTER);
      fill(0, 255, 0);
      textSize(30);
      text("YOU LOSE, Press ENTER to restart level", width/2, height/2);
      noLoop();
    }
    if (win)//display win screen and stops looping
    {
      textAlign(CENTER);
      fill(0, 255, 0);
      textSize(30);
      if (currentLevel == levels.length-1 && !tutorial || whichTLevel == 5 && tutorial)
      {
        text("ALL LEVELS COMPLETE, \nPress ENTER to go to main menu", width/2, height/2);//displays winning screen for when the entire game is won
      }
      else
      {
        text("YOU WIN, Press ENTER to go to next level", width/2, height/2);
      }
      noLoop();
    }
  }
}
void keyPressed()
{
  if (key == 'm' || key == 'M')//sets the gain to a small number to give the illusion of muting when the m key is pressed
  {
    if (gain == 0)
    {
      gain = -1000;
    }
    else if (gain == -1000)
    {
      gain = 0;
    }
  }
  if (key == 'e' || key == 'E')//goes back to the menu if the game is paused
  {
    if (pause)
    {
      whichTLevel = 0;
      currentLevel = 0;
      tutorial = false;
      Screen = true;
      pause = false;
      music.pause();
      music = minim.loadFile("menu" + int(random(1, maxMusic)) + ".mp3");//reloads music
      music.setGain(gain);
      music.loop();
      loop();
    }
  }
  if (key == 'r' || key == 'R')
  {
    if (blue.appear || orange.appear)//this will play a sound effect when the portals dissapear
    {
      soundEffects = minim.loadFile("portal_close" + int(random(1, 3)) + ".mp3");
      soundEffects.setGain(gain);
      soundEffects.play();
    }
    if (pause)
    {
      if (!tutorial)//the level will be reinitialzed if R is pressed and the game is paused
      {
        initializeLevel();
      }
      else
      {
        initialzeTLevel();
      }
      pause = false;
      loop();
    }
  }
  if (currentLevel != 0 || whichTLevel != 0)//player moves when these keys are pressed
  {
    if (key=='d' || key=='d') {
      keys[0]=true;
    }
    if (key=='a' || key=='A') {
      keys[1]=true;
    }
    if (key==' ') {
      keys[2]=true;
    }

    if (keyCode == ENTER && lose)
    {
      if (!tutorial)
      {
        initializeLevel();//reinitialize level if lost
        lose = false;
        loop();
      }
      else
      {
        lose = false;
        initialzeTLevel();//reinitialize tutorial level if lost
        loop();
      }
    }
    else if (keyCode == ENTER && win)
    {
      if (!tutorial)
      {
        currentLevel++;//change current level
        changeLevel++;//changes value of changeLevel to equal currentLevel, necessary if a level is quit by pressing "E"
        if (currentLevel == levels.length)//goes back to menu screen if all levels are cleared
        {
          currentLevel = 0;
          changeLevel = 1;
          saveLevel = 1;
          Screen = true;
        }
        else
        {
          saveLevel = currentLevel;
        }
        String[] wut = {
          currentLevel + ""
        };
        if (currentLevel == 0)//this will keep the save level from becoming 0, which doesn't exist
        {
          wut = new String[1];
          wut[0] = 1 + "";
        }
        saveStrings( "data.txt", wut);//saves a text file with the value of the current level
        initializeLevel();//initialize the next level
        win = false;
        loop();
      }
      else
      {
        whichTLevel++;//change tutorial level
        win = false;
        if (whichTLevel == 6)//go back to menu screen
        {
          Screen = true;
          tutorial = false;
          Physics = false;
          whichTLevel = 0;
        }
        else
        {
          initialzeTLevel();//initialize elements in the next tutorial Level
        }
        loop();
      }
    }
    if (key == 'p' || key == 'P')
    {
      if (!win && !lose)//game can only be paused if the game is still looping
      {
        pause = !pause;
        if (pause)
        {
          textAlign(CENTER);
      fill(0, 255, 0);
          textSize(30);
          text("PAUSED, Press P to resume, press E to go to menu \n press R to restart Level", width/2, height/2);
          pausedTime = millis();
          noLoop();
        }
        if (!pause)
        {
          newTime = millis();
          resultTime = newTime-pausedTime;
          for (int i = 0; i < turret.length; i++)//this will keep the turret timer accurate after the game is paused
          {
            turret[i].startTime = resultTime + turret[i].startTime;
          }
          loop();
        }
      }
    }
  }
}

void keyReleased()
{
  if (currentLevel != 0 || whichTLevel != 0)//player stops moving when these keys are released
  {
    if (key=='d' || key=='D') {
      keys[0]=false;
    }
    if (key=='a' || key=='A') {
      keys[1]=false;
    }
    if (key==' ') {
      keys[2]=false;
    }
    orange.dissapear();//portals will dissapear if the r key is releeased
    blue.dissapear();
  }
}

void mousePressed()
{
  if (currentLevel != 0 || whichTLevel != 0)
  {
    if (mouseButton == LEFT)//Orange portal is controlled by left mouse button, and the blue portal is controlled by the right mouse button.
    {
      orange.appear();
    }
    if (mouseButton == RIGHT)
    {
      blue.appear();
    }
  }
}
/*Instead of having to make different objects for each level,
 an array of the laser, movingWall, cube, and turret classes is created.
 These arrays will change value depending on what level is currently being played.
 The number of necessary objects in each level is put, and the different objects
 can simply be initialized inside the array. Portals are always reinitialized, and the player
 only requires one of itself, so no array is needed. This works for normal and tutorial levels.*/

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
      cubes = new Cube[0];
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
    if (currentLevel == 9)
    {
      turret = new Turret[0];
      walls = new movingWall[1];
      walls[0] = new movingWall(180, 25, 100, 30, true, false, 472);
      walls[0].assignButton(52, 490);
      cubes = new Cube[1];
      cubes[0] = new Cube(606, 477);
      lasers = new Laser[1];
      lasers[0] = new Laser(182, 485, true, 575);
      player = new Player("P34CH35", 61, 180);
    }
    if (currentLevel == 10)
    {  
      turret = new Turret[0];
      walls = new movingWall[1];
      walls[0] = new movingWall(283, 126, 75, 10, false, true, 350);
      cubes = new Cube[0];
      lasers = new Laser[1];
      lasers[0] = new Laser(10, 474, false);
      player = new Player("P34CH35", 28, 84);
    }
    if (currentLevel == 11)
    {  
      turret = new Turret[1];
      turret[0] = new Turret(345, 458, true);
      walls = new movingWall[1];
      walls[0] = new movingWall(750, 180, 76, 10, false, true, 300);
      walls[0].assignButton(590, 414);
      cubes = new Cube[1];
      cubes[0] = new Cube(106, 456);
      lasers = new Laser[0];
      player = new Player("P34CH35", 313, 170);
    }
    if (currentLevel == 12)
    {  
      turret = new Turret[0];
      walls = new movingWall[0];
      cubes = new Cube[0];
      lasers = new Laser[0];
      player = new Player("P34CH35", 45, 118);
    }
    if (currentLevel == 13)
    {  
      turret = new Turret[0];
      walls = new movingWall[0];
      cubes = new Cube[1];
      cubes[0] = new Cube(587, 196);
      lasers = new Laser[1];
      lasers[0] = new Laser(26, 450, false);
      lasers[0].assignButton(68, 365);
      player = new Player("P34CH35", 400, 50);
    }
    if (currentLevel == 14)
    {  
      turret = new Turret[1];
      turret[0] = new Turret(400, 437, true);
      walls = new movingWall[0];
      cubes = new Cube[0];
      lasers = new Laser[2];
      lasers[0] = new Laser(26, 300, false, 200);
      lasers[1] = new Laser(26, 400, false, 100);
      player = new Player("P34CH35", 45, 118);
    }
    if (currentLevel == 15)
    {  
      turret = new Turret[0];
      walls = new movingWall[0];
      cubes = new Cube[0];
      lasers = new Laser[1];
      lasers[0]  = new Laser(466, 470, false);
      player = new Player("P34CH35", 45, 118);
    }
    if (currentLevel == 16)
    {  
      turret = new Turret[0];
      walls = new movingWall[0];
      cubes = new Cube[0];
      lasers = new Laser[0];
      player = new Player("P34CH35", 45, 228);
    }
    if (currentLevel == 17 )
    {  
      turret = new Turret[0];
      walls = new movingWall[0];
      cubes = new Cube[0];
      lasers = new Laser[0];
      player = new Player("P34CH35", 45, 228);
    }
    if (currentLevel == 18 )
    {  
      turret = new Turret[0];
      walls = new movingWall[0];
      cubes = new Cube[0];
      lasers = new Laser[0];
      player = new Player("P34CH35", 45, 228);
    }
    if (currentLevel == 19 )
    {  
      turret = new Turret[0];
      walls = new movingWall[0];
      cubes = new Cube[0];
      lasers = new Laser[0];
      player = new Player("P34CH35", 45, 228);
    }
    if (currentLevel == 20 )
    {  
      turret = new Turret[0];
      walls = new movingWall[0];
      cubes = new Cube[0];
      lasers = new Laser[0];
      player = new Player("P34CH35", 45, 228);
    }
    if (currentLevel == 21)
    {  
      turret = new Turret[0];
      walls = new movingWall[0];
      cubes = new Cube[0];
      lasers = new Laser[5];
      lasers[0] = new Laser(21, 252, false);
      lasers[1] = new Laser(22, 257, false);
      lasers[2] = new Laser(23, 262, false);
      lasers[3] = new Laser(24, 267, false);
      lasers[4] = new Laser(25, 272, false);

      player = new Player("P34CH35", 42, 49);
    }
    if (currentLevel == 22)
    {  
      turret = new Turret[0];
      walls = new movingWall[0];
      cubes = new Cube[0];
      lasers = new Laser[0];
      player = new Player("P34CH35", 30, 365);
    }
    if (currentLevel == 23 )
    {  
      turret = new Turret[0];
      walls = new movingWall[0];
      cubes = new Cube[0];
      lasers = new Laser[0];
      player = new Player("P34CH35", 30, 365);
    }
    if (currentLevel == 24 )
    {  
      turret = new Turret[7];
      turret[0] = new Turret(150, 427, true);
      turret[1] = new Turret(250, 427, true);
      turret[2] = new Turret(350, 427, true);
      turret[3] = new Turret(450, 427, true);
      turret[4] = new Turret(550, 427, true);
      turret[5] = new Turret(650, 427, true);
      turret[6] = new Turret(750, 427, true);

      walls = new movingWall[0];
      cubes = new Cube[0];
      lasers = new Laser[0];
      player = new Player("P34CH35", 30, 365);
    }
    if (currentLevel == 25)
    {  
      turret = new Turret[0];
      walls = new movingWall[0];
      cubes = new Cube[0];
      lasers = new Laser[0];
      player = new Player("P34CH35", 30, 365);
    }
      if (currentLevel == 26)
    {  
      turret = new Turret[0];
      walls = new movingWall[0];
      cubes = new Cube[0];
      lasers = new Laser[0];
      player = new Player("P34CH35", 30, 365);
    }
      if (currentLevel == 27)
    {  
      turret = new Turret[0];
      walls = new movingWall[0];
      cubes = new Cube[1];
      cubes[0] = new Cube(width/2, 50);
      lasers = new Laser[0];
      player = new Player("P34CH35", 30, 365);
    }
      if (currentLevel == 28)
    {  
      turret = new Turret[0];
      walls = new movingWall[0];
      cubes = new Cube[0];
      lasers = new Laser[0];
      player = new Player("P34CH35", 30, 365);
    }
      if (currentLevel == 29)
    {  
      turret = new Turret[0];
      walls = new movingWall[0];
      cubes = new Cube[0];
      lasers = new Laser[0];
      player = new Player("P34CH35", 30, 365);
    }
      if (currentLevel == 30)
    {  
      turret = new Turret[1];
      turret[0] = new Turret(202,426,true);
      walls = new movingWall[0];
      cubes = new Cube[0];
      lasers = new Laser[0];
      player = new Player("P34CH35", 30, 365);
    }
     if (currentLevel == 31)
    {  
      turret = new Turret[0];
      walls = new movingWall[0];
      cubes = new Cube[0];
      lasers = new Laser[0];
      player = new Player("P34CH35", 30, 365);
    }
     if (currentLevel == 32)
    {  
      turret = new Turret[0];
      walls = new movingWall[0];
      cubes = new Cube[0];
      lasers = new Laser[0];
      player = new Player("P34CH35", 30, 365);
    }
     if (currentLevel == 33)
    {  
      turret = new Turret[0];
      walls = new movingWall[0];
      cubes = new Cube[0];
      lasers = new Laser[0];
      player = new Player("P34CH35", 30, 365);
    }
     if (currentLevel == 34 )
    {  
      turret = new Turret[7];
      turret[0] = new Turret(150, 427, true);
      turret[1] = new Turret(250, 427, true);
      turret[2] = new Turret(350, 427, true);
      turret[3] = new Turret(450, 427, true);
      turret[4] = new Turret(550, 427, true);
      turret[5] = new Turret(650, 427, true);
      turret[6] = new Turret(750, 427, true);

      walls = new movingWall[0];
      cubes = new Cube[0];
      lasers = new Laser[0];
      player = new Player("P34CH35", 30, 365);
    }
     if (currentLevel == 35)
    {  
      turret = new Turret[7];
      turret[0] = new Turret(150, 427, true);
      turret[1] = new Turret(250, 427, true);
      turret[2] = new Turret(350, 427, true);
      turret[3] = new Turret(450, 427, true);
      turret[4] = new Turret(550, 427, true);
      turret[5] = new Turret(650, 427, true);
      turret[6] = new Turret(750, 427, true);

      walls = new movingWall[0];
      cubes = new Cube[0];
      lasers = new Laser[0];
      player = new Player("P34CH35", 30, 365);
    }
  }
}

