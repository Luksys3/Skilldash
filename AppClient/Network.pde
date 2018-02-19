class Network {
  private Client client;

  Network(Client cl) {
    client = cl;
  }
  
  void update() {
    if (client.available() > 0) {
      int data = client.read();
      print("Available: "+ data +"\n");
    } else {
      print("Unavailable\n");
    }
  }
}