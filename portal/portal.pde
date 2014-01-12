//#MOTOWNFOREVA!  #TWERKIN  #DOABACKFLIP
Cube cube;
Portal orange;
Portal blue;
Level level1, level2, level3;
Player player;
boolean[] keys;
void setup()
{
  size(800, 500);
  cube = new Cube(width/2, height/2);
  level1 = new Level(1, "Level 1.png");
  level2 = new Level(1, "Level 2.png");
  level3 = new Level(1, "Level 3.png");
  orange = new Portal(color(255, 115, 0));
  blue = new Portal(color(0, 0, 255));
  player = new Player("P34CH35", 20, 50);
  keys=new boolean[3];
  keys[0]=false;
  keys[1]=false;
  keys[2]=false;
}
void draw()
{
  //level1.display();
  //level2.display();
  level3.display();


  orange.checkObject(cube, blue);
  orange.checkPlayer(player, blue);  
  blue.checkPlayer(player, orange);
  blue.checkObject(cube, orange);

  player.fall();
  cube.fall();
  orange.shoot(player);
  blue.shoot(player);

  player.display();
  cube.display();
  cube.hitPlayer(player);

  player.move();
  player.friction();
  cube.friction();
  blue.display();
  orange.display();
}
void keyPressed()
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

void keyReleased()
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

void mousePressed()
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

