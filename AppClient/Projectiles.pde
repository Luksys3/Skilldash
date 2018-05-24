class Projectiles {
  HashMap<String, Projectile> activeProjectiles = new HashMap<String, Projectile>();

  void update() {
    Iterator<Map.Entry<String, Projectile>> it = activeProjectiles.entrySet().iterator();
    while (it.hasNext())
    {
      Map.Entry<String, Projectile> item = it.next();

      Projectile bl = item.getValue();

      if (bl.isDead()) {
        it.remove();
        continue;
      }

      bl.update();
    }
  }
  
  void create(JSONObject json) {
    String type = json.getString("pr_type");
    Projectile proj = null;
    
    switch (type) {
    case "basic":
      proj = new ProjectileBasic(
        json.getInt("x1"), 
        json.getInt("y1"), 
        json.getInt("x2"), 
        json.getInt("y2")
      );
      break;
    case "star":
      proj = new ProjectileStar(
        json.getInt("x1"), 
        json.getInt("y1"), 
        json.getInt("x2"), 
        json.getInt("y2")
      );
      break;
    }

    if (proj == null)
      return;
    
    if (!json.isNull("owner"))
      proj.setOwner(json.getInt("owner"));
    
    activeProjectiles.put(proj.getId(), proj);
  }
  
  HashMap<String, Projectile> collided(int objectId, String name, float x, float y, int distance) {
    HashMap<String, Projectile> collidedProjectiles = new HashMap<String, Projectile>();
    
    Iterator<Map.Entry<String, Projectile>> it = activeProjectiles.entrySet().iterator();
    while (it.hasNext())
    {
      Map.Entry<String, Projectile> item = it.next();

      Projectile bl = item.getValue();
      
      if (bl.getOwner() == objectId)
        continue;
      
      if (dist(x, y, bl.getX(), bl.getY()) > distance)
        continue;
      
      // Call projectile method onCollision();
      bl.onCollision(name);
      
      // Add projectile to collided list
      collidedProjectiles.put(item.getKey(), bl);
    }
    
    return collidedProjectiles;
  }
}
