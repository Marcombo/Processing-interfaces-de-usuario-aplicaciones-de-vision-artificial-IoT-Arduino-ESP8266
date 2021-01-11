void setup(){
  size(300, 300);
}

void draw(){
    int x = int(random(width));
    int y = int(random(height));
    strokeWeight(20);
    point(x, y);
}