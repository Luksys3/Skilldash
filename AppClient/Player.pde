class Player {
  private int clientid;
  
  private int w = 20;
  private int h = 20;
  
  //Base stats
  private int speed = 10;
  private int health;
  private int rageBar;
  
  //Movement variables
  private int kx, ky;
  private boolean left   = false;
  private boolean right  = false;
  private boolean up     = false;
  private boolean down   = false;
  
  //Stunas
  private boolean disable = false;
  private int disableTime;

  private float angle = 0;

  private PVector pos;
  private PVector prevPos = new PVector(0, 0);
  private PVector vel = new PVector(0, 0);

  Player(int x, int y) {
    pos = new PVector(x, y);
    
    clientid = int(random(100000, 999999));
  }

  void update() {
    if(disable){
      if(millis() >= disableTime){
        disable = true;
      }
    }
    
      rotation();
      
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
    rotate(angle);
    
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
    if(disable)
      return;
      
    // Saves position
    prevPos.set(pos);
    
    if (left && pos.x > 0){
      vel.x = -speed;
      kx = -1;
    }else if (right && pos.x < width){
      vel.x = speed;
      kx = 1;
    }else
      vel.x = 0;
      
    if (up && pos.y > 0){
      vel.y = -speed;
      ky = -1;
    }else if (down && pos.y < height){
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
  
  void takeDamage(int damage){
    health -= damage;
    
    if(health <= 0){
      //dickedOn();
    }
  }
  
  void disable(int time){
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
    
    json.setString("key", "position");
    json.setInt("clientid", clientid);
    json.setInt("x", int(pos.x));
    json.setInt("y", int(pos.y));
    
    client.write(json.toString());
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