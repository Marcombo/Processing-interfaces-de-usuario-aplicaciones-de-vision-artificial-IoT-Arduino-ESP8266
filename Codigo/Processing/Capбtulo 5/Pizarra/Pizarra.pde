void setup() { 
  size(450, 255);
  background(0);
} 
void draw() { 
  if (mousePressed == true) {
    stroke(255);
    line(pmouseX, pmouseY, mouseX, mouseY); 
  }
}