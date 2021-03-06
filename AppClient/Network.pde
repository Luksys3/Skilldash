class Network {
  private Client client;
  private String splitter = "#|#";

  private int lastSent = millis() - requestInterval;

  Network(Client cl) {
    client = cl;
  }

  void update() {
    if (!client.active()) {
      // Disconnected
      return;
    }

    int cMillis = millis();
    if (cMillis - lastSent >= requestInterval) {
      lastSent = cMillis;
      sendData();
    }

    checkForNewData();
  }

  void checkForNewData() {
    if (client.available() <= 0)
      return;

    String data = client.readString();

    String[] array = split(data, splitter);
    for (int i=0; i<array.length; i++) {
      String str = array[i];

      if (str.indexOf(splitter) != -1)
        str = str.substring(0, str.indexOf(splitter));

      if (!isJSONValid(str, "}"))
        continue;

      JSONObject json = parseJSONObject(str);
      if (json == null)
        return;


      switch (json.getString("type")) {
      case "position":
        updatePlayerPosition(json);
        break;
      case "bullet":
        projectiles.create(json);
        break;
      case "disconnect":
        players.remove( str(json.getInt("clientid")) );
        break;
      }
    }
  }

  void sendData() {
    JSONObject json;
    json = new JSONObject();

    json.setInt("clientid", localPlayer.getClientId());
    json.setInt("x", localPlayer.getX());
    json.setInt("y", localPlayer.getY());
    json.setFloat("angle", localPlayer.getAngle());
    json.setInt("health", localPlayer.getHealth());

    network.emit("position", json);
  }

  void updatePlayerPosition(JSONObject json) {
    if (json.getInt("clientid") == localPlayer.getClientId())
      return;

    String clientid = str(json.getInt("clientid"));
    int px = json.getInt("x");
    int py = json.getInt("y");

    Player player = players.get(clientid);
    if (player == null) {
      player = new Player(px, py);
      player.setClientid(json.getInt("clientid"));
      players.put(clientid, player);
    } else {
      player.moveTo(px, py);
    }

    player.setHealth(json.getInt("health"));
    player.setAngle(json.getFloat("angle"));
  }

  void emit(String type, JSONObject json) {
    json.setString("type", type);

    client.write(json.toString() + splitter);
  }
}
