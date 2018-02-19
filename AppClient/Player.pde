class Player {
  private int clientid;
  
  private int w = 20;
  private int h = 20;
  
  private int speed = 10;

  private boolean left   = false;
  private boolean right  = false;
  private boolean up     = false;
  private boolean down   = false;

  private int angle = 0;

  PVector pos;
  PVector vel = new PVector(0, 0);

  Player(int x, int y) {
    pos = new PVector(x, y);
    
    clientid = int(random(100000, 999999));
  }

  void update() {
    movement();
    
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

  void movement() {
    if (left)
      vel.x = -speed;
    else if (right)
      vel.x = speed;
    else
      vel.x = 0;
      
    if (up)
      vel.y = -speed;
    else if (down)
      vel.y = speed;
    else
      vel.y = 0;

    pos.add(vel);
  }

  void keyPressed() {
    updateButtons(key, true);
  }

  void keyReleased() {
    updateButtons(key, false);
  }

  boolean updateButtons(char k, boolean pressed) {
    switch (k) {
    case 'w':
      return up = pressed;
    case 's':
      return down = pressed;
    case 'd':
      return right = pressed;
    case 'a':
      return left = pressed;
    default:
      return pressed;
    }
  }
  
  void sendPos() {
    JSONObject json;
    json = new JSONObject();
    json.setInt("clientid", clientid);
    
    
    //network.emit("pos", json);
    
  }
}