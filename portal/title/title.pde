void setup() {
  size(800, 500);
}
boolean Options = false;
boolean Credits = false;
boolean Physics = false;
boolean Screen = true;
void draw() {
if(Screen){
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
  if (inbetween(width/2-250, 425, 200, 75)) {
    Options = true;
    Screen = false;
  }
  if (inbetween(width/2+250, 425, 200, 75)) {
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
if(Credits){
 background(0,0,255); 
 if(back(inbetween(50,50,50,50))){
   Screen = true;
   Credits = false; 
  }
}
if(Physics){
 background(255,125,0);
 if(back(inbetween(50,50,50,50))){
   Screen = true;
   Physics = false; 
  }
}
if(Options){
  background(255,125,0);
  if(back(inbetween(50,50,50,50))){
   Screen = true;
   Options = false; 
  }
}
}


