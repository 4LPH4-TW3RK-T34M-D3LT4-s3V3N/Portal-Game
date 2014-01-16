class Level
{
  int whichLevel;
  PImage design;
  Level(int _whichLevel, String designName)
  {
    whichLevel = _whichLevel;
    design = loadImage(designName);
  }
  void display()
  {
    imageMode(CORNER);
    if (currentLevel == whichLevel)
    {
      image(design, 0, 0);
    }
  }
}
class tLevel
{
  int whichLevel;
  PImage design;
  tLevel(int _whichLevel, String designName)
  {
    whichLevel = _whichLevel;
    design = loadImage(designName);
  }
  void display()
  {
    imageMode(CORNER);
    if (whichTLevel == whichLevel)
    {
      image(design, 0, 0);
    }
  }
}

