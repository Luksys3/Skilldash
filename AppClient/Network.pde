class Network {
  private Client client;

  Network(Client cl) {
    client = cl;
  }
  
  void update() {
    print("Availabel: "+ client.available());
    //if (client.available() > 0) {
    //  print("Available\n");
    //} else {
    //  print("Unavailable\n");
    //}
  }
}