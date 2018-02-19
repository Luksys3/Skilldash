class Player {
  protected int clientid;

  protected int w = 20;
  protected int h = 20;

  //Base stats
  protected int speed = 10;
  protected int health;
  protected int rageBar;

  //Stunas
  protected boolean disable = false;
  protected int disableTime;

  protected int angle = 0;

  protected PVector pos;
  protected PVector prevPos = new PVector(0, 0);
  protected PVector vel = new PVector(0, 0);

  Player(int x, int y) {
    pos = new PVector(x, y);

    clientid = int(random(100000, 999999));
  }

  void update() {
    if (disable) {
      if (millis() >= disableTime) {
        disable = true;
      }
    }

    sendPos();
    draw();
  }

  void draw() {

    fill(255);
    strokeWeight(0);
    stroke(0);

    pushMatrix();
    translate(pos.x, pos.y);
    rotate(radians(angle));

    beginShape();
    vertex(-w, -h);
    vertex(w/2, -h/2);
    vertex(w/2, h/2);
    vertex(-w/2, h/2);
    endShape(CLOSE);

    //rect(-w/2, -h, w, h*2);
    popMatrix();
  }

  int getX() {
    return int(pos.x);
  }

  int getY() {
    return int(pos.y);
  }

  int getClientId() {
    return clientid;
  }
  
  void setClientid(int lClientid) {
    clientid = lClientid;
  }

  void setPos(int nx, int ny) {
    pos.x = nx;
    pos.y = ny;
  }

  void takeDamage(int damage) {
    health -= damage;

    if (health <= 0) {
      //dickedOn();
    }
  }

  void disable(int time) {
    disable = true;
    disableTime = millis() + time;
  }

  void sendPos() {
    if (
      prevPos.x == pos.x
      &&
      prevPos.y == pos.y
      ) return;

    JSONObject json;
    json = new JSONObject();

    json.setInt("clientid", clientid);
    json.setInt("x", int(pos.x));
    json.setInt("y", int(pos.y));

    network.emit("position", json);
  }
}