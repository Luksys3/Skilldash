class Player {
  protected int clientid;

  protected int w = 20;
  protected int h = 20;

  // Base stats
  protected int speed = 10;
  protected int health;
  protected int rageBar;

  protected float angle = 0;

  protected PVector pos;

  Player(int x, int y) {
    pos = new PVector(x, y);

    clientid = int(random(100000, 999999));
  }

  void update() {
    draw();
  }

  void draw() {
    fill(255);
    strokeWeight(0);
    stroke(0);

    pushMatrix();
    translate(pos.x, pos.y);
    rotate(angle);
    
    beginShape();
    vertex(0, -h);
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

  void setAngle(int degree) {
    angle = radians(degree);
  }

  void takeDamage(int damage) {
    health -= damage;

    if (health <= 0) {
      health = 0;
      //dickedOn();
    }
  }
}