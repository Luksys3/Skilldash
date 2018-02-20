import processing.net.*;
import java.util.Map;

Network network;
Client client;
Bullet Bullet1;

LocalPlayer localPlayer;
HashMap<String, Player> players = new HashMap<String, Player>();

void setup() {
  //size(1500, 900);
  size(600, 600);

  //frameRate(1);

  client = new Client(this, "192.168.1.70", 5204);
  network = new Network(client);

  localPlayer = new LocalPlayer(width / 2, height / 2);
  Bullet1 = new Bullet(mouseX, mouseY, localPlayer.getX(), localPlayer.getY());
}

void draw() {
  background(100);

  localPlayer.update();
  network.update();
  Bullet1.update();

  for (Map.Entry pair : players.entrySet()) {
    Player player = players.get(pair.getKey());
    player.update();
  }
}

void keyPressed() {
  localPlayer.keyPressed();
}

void keyReleased() {
  localPlayer.keyReleased();
}