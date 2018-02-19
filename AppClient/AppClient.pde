import processing.net.*; 

Network network;
Client client;
Player Player1;
Bullet Bullet1;

Player localPlayer;

void setup() {
  //size(1500, 900);
  size(600, 600);

  //frameRate(1);

  client = new Client(this, "192.168.1.221", 5204);
  network = new Network(client);

  localPlayer = new LocalPlayer(width / 2, height / 2);
  Bullet1 = new Bullet(mouseX, mouseY, localPlayer.getX(), localPlayer.getY());
}

void draw() {
  background(100);

  localPlayer.update();
  network.update();
  Bullet1.update();
}

void keyPressed() {
  localPlayer.keyPressed();
}

void keyReleased() {
  localPlayer.keyReleased();
}