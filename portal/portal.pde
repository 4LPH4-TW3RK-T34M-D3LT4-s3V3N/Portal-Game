Cube cube;
Portal orange;
Portal blue;
Level level1;
Player player;
boolean[] keys;
void setup()
{
  size(800, 500);
  cube = new Cube(width/2, height/2);
  level1 = new Level(1, "Level 1.png");
  orange = new Portal(color(255, 115, 0));
  blue = new Portal(color(0, 0, 255));
  player = new Player("P34CH35", 20, 20);
  keys=new boolean[3];
  keys[0]=false;
  keys[1]=false;
  keys[2]=false;
}
void draw()
{
  level1.display();
  cube.fall();
  cube.hitPlayer(player);
  player.hitCeiling();
  cube.display();
  blue.display();
  orange.display();
  orange.checkObject(cube, blue);
  orange.checkPlayer(player, blue);  
  player.fall();
  orange.shoot(player);
  blue.shoot(player);

  //  blue.checkPlayer(player, orange);
  player.display();
  player.move();
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
} 

void mousePressed()
{
  if (mouseButton == LEFT)
  {
    orange.shoot2();
  }
  if (mouseButton == RIGHT)
  {
    blue.shoot2();
  }
}

