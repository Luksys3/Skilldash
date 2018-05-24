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
    network.update();

    // Updates all projectiles
    projectiles.update();

    // Update local player
    localPlayer.update();

    // Update players    
    for (Map.Entry pair : players.entrySet()) {
      players.get(pair.getKey()).update();
    }
    
    
    if (frameCount % 60 == 0) {
      JSONObject json = new JSONObject();
      json.setFloat("x1", width / 4);
      json.setFloat("y1", height / 4);
      json.setFloat("x2", mouseX);
      json.setFloat("y2", mouseY);
      json.setString("pr_type", "basic");
      projectiles.create(json);
    }
  }
  
  void unmount() {
    client.stop();
  }
}
