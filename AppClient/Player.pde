class Player {
  protected int clientid;

  protected int w = 20;
  protected int h = 20;
  protected int maxHealth = 100;
  
  protected int hitBoxRange = 30;

  // Base stats
  protected int speed = 10;
  protected int health = maxHealth;
  protected int rageBar;
  
  // Movement animation variables
  private PVector movementTick = new PVector(0, 0);
  private PVector moveToCoords;

  protected float angle = 0;
  protected boolean dead = false;

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
    pushStyle();
    
    fill(55);
    
    if (isDead())
      fill(255, 0, 0);
    
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
    
    // Health bar
    if (health < maxHealth)
      drawHealthBar();
    
    // Draw hit box
    drawHitBox();
    
    popStyle();
  }
  
  int getX() {
    return int(pos.x);
  }

  int getY() {
    return int(pos.y);
  }
  
  int getWidth() {
    return w;
  }

  int getHeight() {
    return h;
  }

  int getClientId() {
    return clientid;
  }
  
  float getAngle() {
    return angle;
  }
  
  int getHealth() {
    return health;
  }
  
  boolean isDead() {
    return dead;
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
  
  void setHealth(int newHealth) {
    health = newHealth;
  }
  
  protected void drawHealthBar() {
    int w = 20;
    int h = 4;
    
    int x = getX() - 10;
    int y = getY() - h - 20;
    
    int healthWidth = round(map(health, 0, maxHealth, 0, w));
    
    // Background
    fill(255, 0, 0);
    rect(x, y, w, h);
    
    // Top layer
    fill(0, 255, 0);
    rect(x, y, healthWidth, h);
  }
  
  protected void drawHitBox() {
    strokeWeight(0);
    fill(255, 0, 0, 50);
    ellipse(getX(), getY(), hitBoxRange, hitBoxRange);
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
