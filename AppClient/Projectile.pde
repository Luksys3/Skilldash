class Projectile {
  protected String id;
  
  protected boolean dead = false;
  protected float x;
  protected float y;
  
  // Projectile default properties
  protected int damage = 5;
  protected int speed  = 35;
  
  Projectile () {
    id = str(randomId());
  }
  
  void update() {
    
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
}
