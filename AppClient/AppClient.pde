import processing.net.*; 

Network network;
Client client;
Player Player1;

void setup() {
  //size(1500, 900);
  size(600, 600);
  
  //frameRate(1);
  
  client = new Client(this, "192.168.1.221", 5204);
  network = new Network(client);
  
  Player1 = new Player(width / 2, height / 2);
}

void draw() {
  background(100);
  
  Player1.update();
  network.update();
}

void keyPressed() {
  Player1.keyPressed();
}

void keyReleased() {
  Player1.keyReleased();
}