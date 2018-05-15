class GameScene extends Scene {
    
  void mount() {
    //println("Game scene mounted");
    players = new HashMap<String, Player>();

    localPlayer = new LocalPlayer(width / 2, height / 2);

    client = new Client(appClient, IPADDRESS, int(PORT));
    network = new Network(client);
  
    terrain = new Terrain();
    projectileManager = new ProjectileManager();
  }

  void update() {
    localPlayer.update();
    network.update();

    // Updates all projectiles
    projectileManager.update();

    for (Map.Entry pair : players.entrySet()) {
      Player player = players.get(pair.getKey());
      player.update();
    }
  }
  
  void unmount() {
    client.stop();
  }
}
