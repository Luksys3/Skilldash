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
    
    activeProjectiles.put(proj.getId(), proj);
  }
}
