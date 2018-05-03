import processing.net.*;
import java.util.Map;

Display display = new Display();

Server server;
int val = 0;

final String splitter = "#|#";
final int interval = 100; // ms


int lastSent = millis() - interval;

HashMap<String, String> players = new HashMap<String, String>();
HashMap<String, String> playerClientid = new HashMap<String, String>();

void setup() {
  size(200, 140);
  //frameRate(5);
  server = new Server(this, 5204, "localhost");
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

  String dataToSend = "";
  for (Map.Entry pair : players.entrySet()) {
    dataToSend += pair.getValue();
  }

  if (dataToSend != "")
    server.write(dataToSend);
}

void disconnectEvent(Client client) {
  String clientid = getClientid(client.ip());
  println("Player disconnected: "+ clientid);
  removePlayer(clientid);

  // TODO: Send to clients that this client disconnected
  //server.write("{\"clientid\": "+ clientid +", \"type\": \"disconnect\"}");
  //println(millis() + " - Player disconnected: "+ client.ip());
}
