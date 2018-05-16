class GameScene extends Scene {
    
  void mount() {
    //println("Game scene mounted");
    players = new HashMap<String, Player>();

    localPlayer = new LocalPlayer(width / 2, height / 2);

    client = new Client(appClient, IPADDRESS, int(PORT));
    network = new Network(client);
  
    terrain = new Terrain();
    projectiles = new Projectiles();
  }

  void update() {
    localPlayer.update();
    network.update();

    // Updates all projectiles
    projectiles.update();

    // Update players
    for (Map.Entry pair : players.entrySet()) {
      players.get(pair.getKey()).update();
    }
  }
  
  void unmount() {
    client.stop();
  }
}
