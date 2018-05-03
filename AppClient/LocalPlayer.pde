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
    if (
      isDisabled()
      &&
      millis() >= disableTime
    ) unDisable();

    if (isDisabled()) {
      draw();
      return;
    }
    
    movement();
    rotation();
    
    if (Key.isPressed('g'))
      shoot();
    
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
    json.setInt("angle", int(degrees(angle)));

    network.emit("position", json);
  }
  
  void shoot() {
    float mx = mouseX,
          my = mouseY;
    
    JSONObject json;
    json = new JSONObject();
    
    json.setFloat("x1", pos.x);
    json.setFloat("y1", pos.y);
    json.setFloat("x2", mx);
    json.setFloat("y2", my);
    
    network.emit("bullet", json);
  }
}
