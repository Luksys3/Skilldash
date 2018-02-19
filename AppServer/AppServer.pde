import processing.net.*;

Server server;
int val = 0;

void setup() {
  size(200, 200);
  server = new Server(this, 5204, "192.168.1.221");
}

void draw() {
  
  // Get the next available client
  Client thisClient = server.available();
  // If the client is not null, and says something, display what it said
  if (thisClient !=null) {
    String whatClientSaid = thisClient.readString();
    if (whatClientSaid != null) {
      println(thisClient.ip() + "\n" + whatClientSaid);
    } 
  } 
}