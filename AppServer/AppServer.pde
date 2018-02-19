import processing.net.*;

Server server;
int val = 0;

void setup() {
  size(200, 200);
  server = new Server(this, 5204, "192.168.1.221");
}

void draw() {
  // Get next available client
  Client client = server.available();
  
  if (client !=null) {
    String whatClientSaid = client.readString();
    if (whatClientSaid != null) {
      println(millis() +": "+ client.ip());
      server.write(whatClientSaid);
    } 
  } 
}