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

  protected float angle = 0;

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
    
    rotation();
      
    sendPos();
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
  
  void rotation(){
    
    if(disable)
      return;
    
    float x = pos.x, y = pos.y;
    float mx = mouseX, my = mouseY;
    
    float maxX, minX, maxY, minY;
    
    float h, v;
    
    if(x > mx){
      maxX = x;
      minX = mx;
    }else{
      maxX = mx;
      minX = x;
    }
    
    if(y > my){
      maxY = y;
      minY = my;
    }else{
      maxY = my;
      minY = y;
    }
    
    h = maxX - minX;
    
    v = maxY - minY;
    
    if(mx > x && my < y){
      angle = PI/2 - atan(v / h);
    }else if(mx > x && my > y){
      angle = PI - atan(h/v); 
    }else if(mx < x && my > y){
      angle = 3 * PI / 2 - atan(v/h);
    }else if(mx < x && my < y){
      angle = 2 * PI - atan(h / v);
    }
    
  }
}