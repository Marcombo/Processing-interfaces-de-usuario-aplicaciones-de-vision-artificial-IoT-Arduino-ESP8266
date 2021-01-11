int x1, x2, y1, y2; 

void setup(){
  size(300, 300);
}

void draw(){
  x1 = x2;
  y1 = y2;
  x2 = int(random(width));
  y2 = int(random(height));
  line(x1, y1, x2, y2);
}