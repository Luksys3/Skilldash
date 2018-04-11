class Player {
  protected int clientid;

  protected int w = 20;
  protected int h = 20;

  // Base stats
  protected int speed = 10;
  protected int health;
  protected int rageBar;
  
  // Movement animation variables
  private PVector movementTick = new PVector(0, 0);
  private PVector moveToCoords;

  protected float angle = 0;

  protected PVector pos;

  Player(int x, int y) {
    pos = new PVector(x, y);
    moveToCoords = new PVector(x, y);

    clientid = randomId();
  }

  void update() {
    doMoveAnimation();
    
    draw();
  }

  void draw() {
    fill(55);
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
  
  float getAngle() {
    return angle;
  }
  
  void setClientid(int lClientid) {
    clientid = lClientid;
  }

  void setPos(int nx, int ny) {
    pos.x = nx;
    pos.y = ny;
  }
  
  void addPos(int nx, int ny) {
    setPos(
      (int)pos.x + nx,
      (int)pos.y + ny
    );
  }

  void setAngle(float rad) {
    angle = rad;
  }

  void takeDamage(int damage) {
    health -= damage;

    if (health <= 0) {
      health = 0;
      //dickedOn();
    }
  }
  
  private void moveTo(int nx, int ny) {
    moveToCoords.x = nx;
    moveToCoords.y = ny;
    
    float xDist = abs(pos.x - nx);
    float yDist = abs(pos.y - ny);
    
    float div = frameRate / (1000 / requestInterval);
    
    float xTick = xDist / div;
    float yTick = yDist / div;
    
    if (nx < pos.x)
      xTick = -xTick;
      
    if (ny < pos.y)
      yTick = -yTick;
    
    movementTick.x = xTick;
    movementTick.y = yTick;
  }
  
  private void doMoveAnimation() {
    if (1 > abs(pos.x - moveToCoords.x)) {
      movementTick.x = 0;
      //pos.x = moveToCoords.x;
    }
      
    if (1 > abs(pos.y - moveToCoords.y)) {
      movementTick.y = 0;
      //pos.y = moveToCoords.y;
    }
    
    if (
      1 > abs(pos.x - moveToCoords.x)
      &&
      1 > abs(pos.y - moveToCoords.y)
    ) return;
    
    pos = PVector.add(pos, movementTick);
  }
}