Cube cube;
Portal orange;
Portal blue;
Level level1;
Player player;

void setup()
{
  size(800, 500);
  cube = new Cube(width/2, height/2);
  level1 = new Level(1, "Level 1.png");
  orange = new Portal(color(255, 115, 0));
  blue = new Portal(color(0, 0, 255));
  player = new Player("P34CH35", 20, 20);
}
void draw()
{
  level1.display();
  cube.fall();
  cube.display();
  blue.display();
  orange.display();
  orange.checkObject(cube, blue);
  player.fall();
  player.display();
  player.update();
  player.move();
}

