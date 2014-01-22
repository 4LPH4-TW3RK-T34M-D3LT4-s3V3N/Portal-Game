class Button {

  PVector loc;//location PVector
  boolean pressed;//decides if button is pressed or not
  boolean play = true;//keeps button from playing sound continuously
  int h;//height of button
  int w;//width of button
  AudioPlayer buttonPlayer;//sound effect player
  Button(int x, int y)
  {
    loc = new PVector(x, y);
    w = 75;
    h = 10;
    buttonPlayer = minim.loadFile("noSound.mp3");//keeps button from playing its sound effect by playing nothing
  }
  void display()//display an almost perfectly red rectangle
  {
    noStroke();
    fill(254, 0, 0);
    rect(loc.x, loc.y, w, h);
  }
  boolean checkPress()
  {
    for (int i = -30; i < 30; i++)
    {
      if (get(int(loc.x+i), int(loc.y-6)) != color(195))//if a pixel above the button is not the green background color, return true
      {
        return true;
      }
    }
    return false;
  }
  void press()
  {
    if (checkPress())
    {    
      if (play && h == 5)//makes sure the sound is only played once by making play false
      {      
        buttonPlayer = minim.loadFile("Portal2_sfx_button_positive.mp3");//reloads buttonPlayer to play sound effect
        play = false;
      }    
      buttonPlayer.setGain(gain);
      buttonPlayer.play();
      pressed = true;
      if (h > 5)//makes h smaller and increases loc.y to make it look like the button is getting pushed
      {
        loc.y++;
        h--;
      }
      else if (h <= 5)//keeps h from getting smaller once it reaches 5
      {
        h = 5;
      }
    }
    else
    {
      if (!play && h == 10)//makes sure the sound is only played once by making play true
      {
        buttonPlayer = minim.loadFile("Portal2_sfx_button_negative.mp3");//reloads buttonPlayer to play sound effect
        play = true;
      }        
      buttonPlayer.setGain(gain);
      buttonPlayer.play();
      pressed = false;
      if (h < 10)//increases h and decreases loc.y to make it look like the button is being unpressed
      {
        h++;
        loc.y--;
      }
      if (h >= 10)//keeps button from going past 10 pixels high
      {
        h = 10;
      }
    }
  }
}
