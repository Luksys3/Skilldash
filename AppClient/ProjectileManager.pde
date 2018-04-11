class ProjectileManager {
  HashMap<String, Bullet> bullets = new HashMap<String, Bullet>();

  ProjectileManager() {
  }

  void update() {
    Iterator<Map.Entry<String, Bullet>> it = bullets.entrySet().iterator();
    while (it.hasNext())
    {
      Map.Entry<String, Bullet> item = it.next();

      Bullet bl = item.getValue();

      if (bl.isDead()) {
        it.remove();
        continue;
      }

      bl.update();
    }

    //for (Map.Entry pair : bullets.entrySet()) {
    //  Bullet bl = bullets.get(pair.getKey());

    //  if (bl.isDead()) {
    //    bullets.remove(bl.getId());
    //    continue;
    //  }

    //  bl.update();
    //}
  }

  void create(JSONObject json) {
    Bullet bl = new Bullet(
      json.getInt("x1"), 
      json.getInt("y1"), 
      json.getInt("x2"), 
      json.getInt("y2")
    );

    bullets.put(bl.getId(), bl);
    //println("New projectile: "+ json.toString());
  }
}