class GameScene extends Scene {

  void mount() {
    println("Game scene mounted");
  }

  void update() {
    //println("GameScene");
    localPlayer.update();
    network.update();

    // Updates all projectiles
    projectileManager.update();

    for (Map.Entry pair : players.entrySet()) {
      Player player = players.get(pair.getKey());
      player.update();
    }
  }
}
