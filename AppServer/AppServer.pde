import processing.net.*;

Server server;
int val = 0;

void setup() {
  size(200, 200);
  server = new Server(this, 5204);
}

void draw() {
  
}