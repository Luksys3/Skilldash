import processing.net.*;
import java.util.Map;

Network network;
Client client;
<<<<<<< HEAD
=======
Bullet Bullet1;
Terrain terrain;
>>>>>>> d52201eb7cdf00e6ba2776dfb4b302995f191da2

LocalPlayer localPlayer;
HashMap<String, Player> players = new HashMap<String, Player>();

void setup() {
  //size(1500, 900);
  size(1300, 650);

  //frameRate(1);

  client = new Client(this, "192.168.1.221", 5204);
  network = new Network(client);

  localPlayer = new LocalPlayer(width / 2, height / 2);
<<<<<<< HEAD
=======
  Bullet1 = new Bullet(mouseX, mouseY, localPlayer.getX(), localPlayer.getY());
  terrain = new Terrain();
>>>>>>> d52201eb7cdf00e6ba2776dfb4b302995f191da2
}

void draw() {
  terrain.draw();
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