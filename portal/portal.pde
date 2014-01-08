Cube cube;
Level level1;

void setup()
{
  size(800, 500);
  cube = new Cube(width/2, height/2);
  level1 = new Level(1, "Level 1.png");
}
void draw()
{
  level1.display();
  cube.display();
  cube.fall();
}

