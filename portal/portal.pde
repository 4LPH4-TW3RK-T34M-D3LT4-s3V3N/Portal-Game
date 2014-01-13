Cube cube;
Portal orange;
Portal blue;
Level level1, level2;
Player player;
Turret[] turret=new Turret[2];
boolean[] keys;

ArrayList<Bullet> bullet1 = new ArrayList<Bullet>();
ArrayList<Bullet> bullet2 = new ArrayList<Bullet>();

void setup()
{
  size(800, 500);
  cube = new Cube(width/2, height/2);
  level1 = new Level(1, "Level 1.png");
  level2 = new Level(1, "Level 2.png");
  orange = new Portal(color(255, 115, 0));
  blue = new Portal(color(0, 0, 255));
  player = new Player("P34CH35", 20, 20);
  turret[0]= new Turret(200, 300);
  turret[1]= new Turret(600, 300);
  keys=new boolean[3];
  keys[0]=false;
  keys[1]=false;
  keys[2]=false;
}
void draw()
{
  level1.display();
  //level2.display();
  cube.fall();
  cube.hitPlayer(player);
  cube.display();
  blue.display();
  orange.display();
  orange.checkObject(cube, blue);
  orange.checkPlayer(player, blue);  
  blue.checkPlayer(player, orange);
  player.fall();
  orange.shoot(player);
  blue.shoot(player);
  //  blue.checkPlayer(player, orange);
  player.display();
  player.move();
  for (int i=0;i<turret.length;i++) {
    turret[i].display();
    turret[i].limitVel();
    turret[i].fall();
    turret[i].hitPlayer(player);
  }
  for (int i = bullet1.size()-1; i >=0; i--) {
    Bullet b = bullet1.get(i);
    b.display();
    b.update();
    b.hit();
    if (b.life <= 0) {
      bullet1.remove(i);
    }
  }
  for (int i = bullet2.size()-1; i >=0; i--) {
    Bullet b = bullet2.get(i);
    b.display();
    b.update();
    b.hit();
    if (b.life <= 0) {
      bullet2.remove(i);
    }
  }
  bullet1.add(new Bullet(turret[0].loc.x, turret[0].loc.y, player.loc.x, player.loc.y));
  bullet2.add(new Bullet(turret[1].loc.x, turret[1].loc.y, player.loc.x, player.loc.y));
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

