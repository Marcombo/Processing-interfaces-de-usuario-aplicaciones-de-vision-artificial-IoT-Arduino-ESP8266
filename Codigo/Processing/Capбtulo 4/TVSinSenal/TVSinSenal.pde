void setup(){
  size(300, 300);
  strokeWeight(2);
}

void draw(){
  for(int x=0; x<width; x+=2){
    for (int y=0; y<height; y+=2){
      if(random(100) < 50) stroke(0);
      else stroke(255);
      point(x, y);
    }
  }
}