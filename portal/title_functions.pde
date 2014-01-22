boolean inbetween(int x, int y, int x1, int y1) {
  if (mouseX > x-x1/2 && mouseX < x+x1/2 && mouseY > y-y1/2 && mouseY < y+y1/2 && mousePressed) {    
    return true;
  } 
  else {
    return false;
  }
}

boolean back(boolean x) {
  fill(0);
  rect(50, 50, 50, 50);
  if (x) {
    return true;
  } 
  else {
    return false;
  }
}

void character(int x1, int y1, String name, color shirt, color race, String job) {
  rectMode(CORNER);

  if (mouseX>x1-25 && mouseX<x1+25 && mouseY>100 && mouseY<150) {
    strokeWeight(5);
    stroke(255, 0, 0); 
    fill(255);
    textSize(40);
    textAlign(CENTER);
    text(name, x1, y1+160);
    textSize(50);
    text(job, width/2, 50);
  } 
  else {
    strokeWeight(5);
    stroke(0); 
    fill(0, 0, 255);
    textSize(40);
    textAlign(CENTER);
    text(name, x1, y1+160);
  }

  fill(shirt); 
  ellipse(x1, y1+40, 80, 150);
  fill(race);
  ellipse(x1, y1, 120, 100);
  strokeWeight(1);
  stroke(0);
  fill(255);
  ellipse(x1-20, y1, 25, 20);
  ellipse(x1+20, y1, 25, 20);
  fill(0);
  ellipse(x1-20, y1, 5, 5);
  ellipse(x1+20, y1, 5, 5);
  rect(x1-25, 100, 50, 50);
}

