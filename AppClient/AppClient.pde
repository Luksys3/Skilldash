import processing.net.*;
import java.util.Map;
import java.util.Iterator;

int requestInterval = 40;

Scenes scenes = new Scenes();
Network network;
Client client;
Terrain terrain;
ProjectileManager projectileManager;

MouseEvent mouseEvent = new MouseEvent();

LocalPlayer localPlayer;
HashMap<String, Player> players = new HashMap<String, Player>();

// - Projectiles init
HashMap<String, ProjectileStar> projectilesStar = new HashMap<String, ProjectileStar>();

void setup() {
  size(600, 560);
  
  //frameRate(1);

  client = new Client(this, "localhost", 5204);
  network = new Network(client);

  localPlayer = new LocalPlayer(width / 2, height / 2);
  terrain = new Terrain();
  projectileManager = new ProjectileManager();
}

void draw() {
  //terrain.draw();
  background(150);
  
  scenes.update();
  
  // Always at bottom
  Key.update();
}

void keyPressed() {
  Key.press(key);
}

void keyReleased() {
  Key.release(key);
}
