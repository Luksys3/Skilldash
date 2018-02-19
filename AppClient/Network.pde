class Network {
  private Client client;
  private String splitter = "#|#";

  Network(Client cl) {
    client = cl;
  }

  void update() {
    if (!client.active()) {
      print("DISCONNECTED\n");
      return;
    }

    if (client.available() <= 0)
      return;

    String data = client.readString();

    String[] array = split(data, splitter);
    for (int i=0; i<array.length; i++) {
      String str = array[i];
      if (str.indexOf(splitter) != -1)
        str = str.substring(0, str.indexOf(splitter));
      
      if (!str.startsWith("{") || !str.endsWith("}") || str == "")
        return;

      JSONObject json = parseJSONObject(str);
      if (json == null)
        return;
      
      switch (json.getString("type")) {
      case "position":
        updatePlayerPosition(json);
        break;
      }
    }
  }

  void updatePlayerPosition(JSONObject json) {
    //if (json.getInt("clientid") == localPlayer.getClientId())
    //  return;
      
    String clientid = str(json.getInt("clientid"));
    int px = json.getInt("x");
    int py = json.getInt("y");
    
    Player player = players.get(clientid);
    if (player == null) {
      
    } else {
      player.pos(px, py);
    }
    
    println(millis() +": "+ json.getInt("clientid") +" x:"+ json.getInt("x") +" y:"+ json.getInt("y"));
  }

  void emit(String type, JSONObject json) {
    json.setString("type", type);

    client.write(json.toString() + splitter);
  }
}