class Player {
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


  private int angle = 0;

  PVector pos;
  PVector vel = new PVector(0, 0);

  Player(int x, int y) {
    pos = new PVector(x, y);
  }

  void update() {
    
    if(disable){
      if(millis() >= disableTime){
        disable = true;
      }
    }
    
    if(!disable)
      movement();

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
  
  void takeDamage(damage){
    healh -= damage;
    
    if(health <= 0){
      dickedOn();
    }
  }
  
  void disable(time){
    disable = true;
    disableTime = millis() + time;
  }
  
}