import processing.net.*;
import java.util.Map;

Display display = new Display();

Server server;
int val = 0;

final String splitter = "#|#";
final int interval = 200; // ms


int lastSent = millis() - interval;

HashMap<String, String> players = new HashMap<String, String>();
HashMap<String, String> playerClientid = new HashMap<String, String>();

void setup() {
  size(200, 140);
  frameRate(5);
  server = new Server(this, 5204, "192.168.0.109");
}

void draw() {
  background(150);
  display.refresh();
  display.show("Online: "+ players.size());
  display.show("Connected: ");
  for (Map.Entry pair : players.entrySet()) {
    display.show("    "+ pair.getKey());
  }
  
  
  
  // Get next available client
  Client client = server.available();

  if (client != null) {
    String data = client.readString();
    if (data != null && isJSONValid(data, splitter)) {
      JSONObject json = parseJSONObject(data);

      switch (json.getString("type")) {
      case "position":
        players.put( str(json.getInt("clientid")), data );
        playerClientid.put( client.ip(), str(json.getInt("clientid")) );

        //println(millis() +" - Data received");
        break;
      case "bullet":
        println("Bullet received");
        server.write(data);
        break;
      }
    }
  }

  int cMillis = millis();
  if (cMillis - lastSent >= interval) {
    lastSent = cMillis;

    String dataToSend = "";
    for (Map.Entry pair : players.entrySet()) {
      dataToSend += pair.getValue();
    }

    if (dataToSend != "") {
      server.write(dataToSend);
      //println(millis() +" - Data sent");
    }
  }
}

void disconnectEvent(Client client) {
  String clientid = getClientid(client.ip());
  removePlayer(clientid);
  
  server.write("{\"clientid\": "+ clientid +", \"type\": \"disconnect\"}");
  print(millis() + " - Player disconnected: "+ client.ip());
}