Cube cube;
Portal orange;
Portal blue;
Level level1, level2;
Player player;
Turret[] turret=new Turret[2];
boolean[] keys;
float rise,run;
PImage portalCursor,portalBlue,portalOrange,portalNone;


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
  portalCursor=loadImage("portal cursor.png");
  portalBlue=loadImage("portalbluecursor.png");
  portalOrange=loadImage("portalorangecursor.png");
  portalNone=loadImage("portalnonecursor.png");
}
void draw()
{
  cursor(portalCursor);
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
    turret[i].shoot(player,player.loc.x);
  }
  turret[0].faceLeft();
  turret[1].faceRight();
}
void keyPressed()
{
  if (key=='d'|| key == 'D') {
    keys[0]=true;
  }
  if (key=='a'||key == 'A') {
    keys[1]=true;
  }
  if (key==' ') {
    keys[2]=true;
  }
}

void keyReleased()
{
  if (key=='d'|| key == 'D') {
    keys[0]=false;
  }
  if (key=='a'||key == 'A') {
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

