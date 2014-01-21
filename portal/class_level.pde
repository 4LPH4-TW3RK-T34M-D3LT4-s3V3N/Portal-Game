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
    if (currentLevel == whichLevel)
    {    imageMode(CORNER);

      image(design, 0, 0);
    }
  }
}

