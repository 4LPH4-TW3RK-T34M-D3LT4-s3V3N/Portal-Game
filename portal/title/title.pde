void setup() {
  size(800, 500);
}

boolean Options = false;
boolean Credits = false;
boolean Physics = false;
boolean Screen = true;
boolean Reset = false;
boolean Sound = true;
boolean Warning = false;

color Brandon = color(0, 100, 255);
color AJ = color(255, 100, 0);
color Irek = color(100, 255, 100);
color Clayton = color(65, 0, 125);
color RaceWhite = color(240, 230, 175); 
color RaceBlack = color(125, 75, 50);

void draw() {
  if (Screen) {
    background(250);
    rectMode(CENTER);
    fill(0);
    rect(width/2, height/2+10, 40, 80);
    stroke(5);
    line(0, 0, width/2-75, height/2-50);
    line(width, 0, width/2+75, height/2-50);
    line(0, height, width/2-75, height/2+50);
    line(width, height, width/2+75, height/2+50);
    noFill();
    rect(width/2, height/2, 150, 100);
    noStroke();
    fill(255, 125, 0);
    if (inbetweenCen(width/2-250, 425, 200, 75)) {
      Physics = true;
      Screen = false;
    }
    if (inbetweenCen(width/2+250, 425, 200, 75)) {
      Options = true;
      Screen = false;
    }
    fill(0, 0, 255);
    if (inbetweenCen(width/2, 425, 200, 75)) {
      Credits = true;
      Screen = false;
    }

    fill(0);
    textAlign(CENTER);
    textMode(CENTER);
    textSize(50);
    text("Physics", width/2-250, 438);
    text("Options", width/2+250, 438); 
    text("Credits", width/2, 438);
    text("Portal: The Second Dimension", width/2, 100);
  }

  if (Credits) {

    background(0, 0, 255); 
    strokeWeight(1);
    stroke(0);
    if (back(inbetweenCor(50, 50, 50, 50))) {
      Screen = true;
      Credits = false;
    }

    character(width/2+75, height/2-25, "Brandon\nDonohue", Brandon, RaceWhite, "UI Designer");
    character(width/2+225, height/2+25, "AJ\nSavoca", AJ, RaceWhite, "Monkey Boy");
    character(width/2-75, height/2+25, "Irek\nSciezcka", Irek, RaceWhite, "Graphics");
    character(width/2-225, height/2-25, "Clayton\nMcLean", Clayton, RaceBlack, "Head Programmer");
  }

  if (Physics) {
    background(255, 125, 0);
    if (back(inbetweenCor(50, 50, 50, 50))) {
      Screen = true;
      Physics = false;
    }
  }

  if (Options) {
    background(255, 125, 0);
    if (back(inbetweenCor(50, 50, 50, 50))) {
      Screen = true;
      Options = false;
    }

    rectMode(CORNER);
    fill(0);
    textSize(60);

    text("Sound", 250, 225);
    rect(150, 250, 200, 200);
    if (inbetweenCor(150, 250, 200, 200)) {
      Sound = !Sound;
    }
    fill(0);
    text("Reset", 550, 225);
    rect(450, 250, 200, 200);
    if (inbetweenCor(450, 250, 200, 200)) {
      Warning = true; 
      Options = false;
    }
  }

  if (Warning) {
    if (second()%2 == 0) {
      background(255, 0, 0);
    } 
    else if (second()%2 == 1) {
      background(0);
    }

    fill(255);
    if (inbetweenCor(300, 350, 200, 50)) {
      //Reset = true;
      //Warning = false;
      //Options = true;
      println("true");
      println(second());
    }
  }
}

