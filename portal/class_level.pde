class Level // regular levels
{
  int whichLevel;//declares which level it will be in the game
  PImage design;
  Level(int _whichLevel, String designName)
  {
    whichLevel = _whichLevel;
    design = loadImage(designName);//loads level design in data folder
  }
  void display()
  {
    imageMode(CORNER);
    if (currentLevel == whichLevel)//display level design if the currentLevel integer equals whichLevel
    {
      image(design, 0, 0);
    }
  }
}
class tLevel // tutorial levels
{
  int whichLevel;//declares which level it will be in the game
  PImage design;
  tLevel(int _whichLevel, String designName)
  {
    whichLevel = _whichLevel;
    design = loadImage(designName);//loads level design in data folder
  }
  void display()
  {
    imageMode(CORNER);
    if (whichTLevel == whichLevel)//display level design if the currentLevel integer equals whichLevel
    {
      image(design, 0, 0);
    }
  }
}
