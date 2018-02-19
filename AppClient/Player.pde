class Player {
  private int clientid;
  
  private int w = 20;
  private int h = 20;
  
  private int speed = 10;
  
  private int kx, ky;
  
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
    if (left){
      vel.x = -speed;
      kx = -1;
    }else if (right){
      vel.x = speed;
      kx = 1;
    }else
      vel.x = 0;
      
    if (up){
      vel.y = -speed;
      ky = -1;
    }else if (down){
      vel.y = speed;
      ky = 1;
    }else
      vel.y = 0;
      
     if(vel.x != 0 && vel.y != 0){
       
       vel.x = sqrt((pow(vel.x, 2) / 2)) * kx;
       vel.y = sqrt((pow(vel.y, 2) / 2)) * ky;
     }

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