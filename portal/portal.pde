//////////////////////
// 4LPHA-TW3RK-T34M //
//   D3LT4-s3V3N    //
//     STUDIO       //
//    PRESENTS      //
//////////////////////

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
  player = new Player("p34Ch3S", width/2, height/2);
}
void draw()
{
  level1.display();
  player.display();
  cube.fall();
  cube.hitPlayer(player);
  player.fall();
  player.onGround();
  player.hitCeiling();
  cube.display();
  blue.display();
  orange.display();
  orange.checkObject(cube, blue);
  orange.checkPlayer(player, blue);
  //  blue.checkPlayer(player, orange);
  player.move();
}

