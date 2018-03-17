import processing.net.*;
import java.util.Map;
import java.util.Iterator;

int requestInterval = 40;

Network network;
Client client;
Terrain terrain;
ProjectileManager projectileManager;

LocalPlayer localPlayer;
//GustBum gustBum;
HashMap<String, Player> players = new HashMap<String, Player>();

// - Projectiles init
HashMap<String, ProjectileStar> projectilesStar = new HashMap<String, ProjectileStar>();

void setup() {
  size(600, 650);

  client = new Client(this, "localhost", 5204);
  network = new Network(client);

  localPlayer = new LocalPlayer(width / 2, height / 2);
  //gustBum = new GustBum(width / 2, height / 2);
  terrain = new Terrain();
  projectileManager = new ProjectileManager();
}

void draw() {
  //terrain.draw();
  background(150);
  localPlayer.update();
  //gustBum.update();
  network.update();
  
  // Updates all projectiles
  projectileManager.update();

  for (Map.Entry pair : players.entrySet()) {
    Player player = players.get(pair.getKey());
    player.update();
  }
}

void keyPressed() {
  localPlayer.keyPressed();
  //gustBum.keyPressed();
}

void keyReleased() {
  localPlayer.keyReleased();
  //gustBum.keyReleased();
}