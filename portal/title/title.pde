void setup() {
  size(800, 500);
}
boolean Options = false;
boolean Credits = false;
boolean Physics = false;
boolean Screen = true;
boolean Sound = true;
boolean Reset = false;
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
    rect(width/2-250, 425, 200, 75);
    rect(width/2+250, 425, 200, 75);
    if (inbetween(width/2+250, 425, 200, 75)) {
      Options = true;
      Screen = false;
    }
    if (inbetween(width/2-250, 425, 200, 75)) {
      Physics = true;
      Screen = false;
    }
    fill(0, 0, 255);
    rect(width/2, 425, 200, 75);
    if (inbetween(width/2, 425, 200, 75)) {
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
    if (back(inbetween(50, 50, 50, 50))) {
      Screen = true;
      Credits = false;
    }

    character(width/2+75, height/2-25, "Brandon\nDonohue", Brandon, RaceWhite, "UI Designer");
    character(width/2+225, height/2+25, "AJ\nSavoca", AJ, RaceWhite, "Monkey Boy");
    character(width/2-75, height/2+25, "Irek\nSciezcka", Irek, RaceWhite, "Graphics");
    character(width/2-225, height/2-25, "Clayton\nMcLean", Clayton, RaceBlack, "HeadProgrammer");
  }
  if (Physics) {
    background(255, 125, 0);
    if (back(inbetween(50, 50, 50, 50))) {
      Screen = true;
      Physics = false;
    }
  }
  if (Options) {
    background(255, 125, 0);
    if (back(inbetween(50, 50, 50, 50))) {
      Screen = true;
      Options = false;
    }



    if (Sound) {
      fill(0, 255, 0);
    } 
    else if (!Sound) {
      fill(255, 0, 0);
    }
    rect(250, 300, 200, 200);

    if (inbetween(250, 300, 200, 200)) {
      Sound = !Sound;
    }

    fill(0);
    rect(550, 300, 200, 200);
    text("Reset Data", 550, 175);
    text("Sound", 250, 175);
    if (inbetween(550, 300, 200, 200)) {
      Options = false;
      Warning = true;
    }
  }

  if (Warning) {
    background(0);
    fill(255);
    rect(150, 200, 200, 200);
    rect(width/2, 425, 600, 50);
    textSize(40);
    text("DO YOU REALLY\nWANT TO RESET?\nALL DATA WILL\nBE LOST!", 550, 150);
    fill(0);
    text("YES!", 150, 215);
    text("NO!", width/2, 440);
    if (inbetween(150, 200, 200, 200)) {
      Warning = false;
      Reset = true;
      Screen = true;
    }
    if (inbetween(width/2, 425, 600, 50)) {
      Warning = false;
      Options = true;
    }
  }
}

