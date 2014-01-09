boolean inbetween(int x, int y, int x1, int y1) {
  if (mouseX > x-x1 && mouseX < x+x1 && mouseY > y-y1 && mouseY < y+y1 && mousePressed) {
    println("It worked");
    return true;
  } 
  else {
    println("try again");
    return false;
  }
}

boolean back(boolean x){
  fill(0);
  rect(50,50,50,50);
  if(x){
    println("LOL");
   return true;
  } else {
   return false; 
  }
}

