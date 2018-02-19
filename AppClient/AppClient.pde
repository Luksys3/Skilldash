
Player Player1;

void setup() {
  size(1500, 900);
  
  Player1 = new Player(0, 0);
}

void draw() {
  background(100);
  
  Player1.update();
}

void keyPressed() {
  Player1.keyPressed();
}

void keyReleased() {
  Player1.keyReleased();
}