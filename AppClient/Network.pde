class Network {
  private Client client;

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
    JSONObject json = parseJSONObject(data);
    
    switch (json.getString("key")) {
    case "position":
      updateClientPosition(json);
    }
  }
  
  void updateClientPosition(JSONObject json) {
    
    println(millis() +": "+ json.getInt("clientid") +" x:"+ json.getInt("x") +" y:"+ json.getInt("y"));
  }
}