class LocalPlayer extends Player {
  // Movement variables
  private int kx, ky;

  // Stunas
  private boolean disabled = false;
  private int disableTime;

  // Movement
  private PVector vel = new PVector(0, 0);

  LocalPlayer(int x, int y) {
    super(x, y);
  }

  void update() {
    if (health <= 0)
      die();
    
    if (!isDead()) {
      // Check collision with bullets
      checkCollisions();
    }
    
    if (
      isDisabled()
      &&
      millis() >= disableTime
      &&
      disableTime != 0
    ) unDisable();

    if (!isDisabled()) {
      movement();
      rotation();
      
      if (Key.isPressed('.'))
        shoot("basic");
      
      if (Key.isPressed('/'))
        shoot("star");
    }
    
    draw();
  }

  void movement() {
    if (Key.isDown('a') && pos.x > 0) {
      vel.x = -speed;
      kx = -1;
    } else if (Key.isDown('d') && pos.x < width) {
      vel.x = speed;
      kx = 1;
    } else
      vel.x = 0;

    if (Key.isDown('w') && pos.y > 0) {
      vel.y = -speed;
      ky = -1;
    } else if (Key.isDown('s') && pos.y < height) {
      vel.y = speed;
      ky = 1;
    } else
      vel.y = 0;

    if (vel.x != 0 && vel.y != 0) {

      vel.x = sqrt((pow(vel.x, 2) / 2)) * kx;
      vel.y = sqrt((pow(vel.y, 2) / 2)) * ky;
    }

    pos.add(vel);
  }

  void disable(int time) {
    disabled = true;
    
    if (time == 0)
      disableTime = 0;
    else
      disableTime = millis() + time;
  }
  
  void unDisable() {
    disabled = false;
  }
  
  boolean isDisabled() {
    return disabled;
  }

  void rotation() {
    float x = pos.x, y = pos.y;
    float mx = mouseX, my = mouseY;

    float h, v;

    h = abs(x - mx);

    v = abs(y - my);

    if (mx > x && my < y) {
      angle = HALF_PI - atan(v / h);
    } else if (mx > x && my > y) {
      angle = PI - atan(h / v);
    } else if (mx < x && my > y) {
      angle = 3 * HALF_PI - atan(v / h);
    } else if (mx < x && my < y) {
      angle = TWO_PI - atan(h / v);
    }
  }

  void sendPos() {
    JSONObject json;
    json = new JSONObject();

    json.setInt("clientid", clientid);
    json.setInt("x", int(pos.x));
    json.setInt("y", int(pos.y));
    json.setInt("health", health);
    json.setInt("angle", int(degrees(angle)));

    network.emit("position", json);
  }
  
  void shoot(String type) {
    JSONObject json = new JSONObject();
    
    json.setFloat("owner", getClientId());
    json.setFloat("x1", pos.x);
    json.setFloat("y1", pos.y);
    json.setFloat("x2", mouseX);
    json.setFloat("y2", mouseY);
    json.setString("pr_type", type);
    
    network.emit("bullet", json);
  }
  
  void checkCollisions() {
    HashMap<String, Projectile> collidedProjectiles = projectiles.collided(
      getClientId(),
      "player",
      getX(),
      getY(),
      hitBoxRange
    );
    
    Iterator<Map.Entry<String, Projectile>> it = collidedProjectiles.entrySet().iterator();
    while (it.hasNext())
    {
      Map.Entry<String, Projectile> item = it.next();
      
      Projectile pr = item.getValue();
      
      // Take damage from projectile
      takeDamage(pr.getDamage());
    }
  }
  
  void takeDamage(int damage) {
    health -= damage;
    
    if (health < 0)
      health = 0;
  }
  
  void die() {
    dead = true;
    disable(0);
  }
}
