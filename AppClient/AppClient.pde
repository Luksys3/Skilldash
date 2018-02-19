import processing.net.*; 

Network network;
Client client;
Player Player1;
Bullet Bullet1;

Player self;

void setup() {
  //size(1500, 900);
  size(600, 600);
  
  //frameRate(1);
  
  client = new Client(this, "192.168.1.221", 5204);
  network = new Network(client);
<<<<<<< HEAD
  
  self = new LocalPlayer(width / 2, height / 2);
=======
  Player1 = new Player(width / 2, height / 2);
  Bullet1 = new Bullet(mouseX,mouseY,Player1.getX(),Player1.getY());
  
>>>>>>> 7428c1f0e998bd4c516594c652d79160188c1169
}

void draw() {
  background(100);
<<<<<<< HEAD
  
  self.update();
=======
  Player1.update();
>>>>>>> 7428c1f0e998bd4c516594c652d79160188c1169
  network.update();
  Bullet1.update();
}

void keyPressed() {
  self.keyPressed();
}

void keyReleased() {
  self.keyReleased();
}