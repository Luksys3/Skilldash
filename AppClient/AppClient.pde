import processing.net.*;
import java.util.Map;

Network network;
Client client;
Terrain terrain;

LocalPlayer localPlayer;
HashMap<String, Player> players = new HashMap<String, Player>();

void setup() {
  size(600, 650);

  //frameRate(1);

  client = new Client(this, "192.168.0.109", 5204);
  network = new Network(client);

  localPlayer = new LocalPlayer(width / 2, height / 2);
  terrain = new Terrain();
}

void draw() {
  //terrain.draw();
  background(150);
  localPlayer.update();
  network.update();

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