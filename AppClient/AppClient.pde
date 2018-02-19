import processing.net.*; 

Network network;
Client client;
Player Player1;

Player self;

void setup() {
  //size(1500, 900);
  size(600, 600);
  
  //frameRate(1);
  
  client = new Client(this, "192.168.1.221", 5204);
  network = new Network(client);
  
  self = new LocalPlayer(width / 2, height / 2);
}

void draw() {
  background(100);
  
  self.update();
  network.update();
}

void keyPressed() {
  self.keyPressed();
}

void keyReleased() {
  self.keyReleased();
}