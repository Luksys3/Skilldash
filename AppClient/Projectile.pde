class Projectile {
  protected String id;
  
  protected boolean dead = false;
  protected float x;
  protected float y;
  
  // Projectile default properties
  protected int damage = 25;
  protected int speed  = 35;
  protected int owner  = 0;
  
  Projectile () {
    id = str(randomId());
  }
  
  void update() {
    
  }
  
  void onCollision(String name) {
    die();
  }
  
  void onDie() {
    
  }

  void die() {
    dead = true;
    onDie();
  }
  
  boolean isDead() {
    return dead;
  }

  String getId() {
    return id;
  }
  
  float getX() {
    return x;
  }
  
  float getY() {
    return y;
  }
  
  int getDamage() {
    return damage;
  }
  
  int getOwner() {
    return owner;
  }
  
  void setOwner(int id) {
    owner = id;
  }
}
