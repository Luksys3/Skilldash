class LocalPlayer extends Player {
  //Movement variables
  private int kx, ky;
  private boolean left   = false;
  private boolean right  = false;
  private boolean up     = false;
  private boolean down   = false;
  
  private boolean keyUpG = true;

  //Stunas
  private boolean disable = false;
  private int disableTime;

  // Movement
  private PVector prevPos = new PVector(0, 0);
  private PVector vel = new PVector(0, 0);

  LocalPlayer(int x, int y) {
    super(x, y);
  }

  void update() {
    if (disable) {
      if (millis() >= disableTime) {
        disable = true;
      }
    }

    if (!disable)
      movement();
    
    rotation();

    draw();
  }

  void movement() {
    if (disable)
      return;

    // Saves position
    prevPos.set(pos);

    if (left && pos.x > 0) {
      vel.x = -speed;
      kx = -1;
    } else if (right && pos.x < width) {
      vel.x = speed;
      kx = 1;
    } else
      vel.x = 0;

    if (up && pos.y > 0) {
      vel.y = -speed;
      ky = -1;
    } else if (down && pos.y < height) {
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
    disable = true;
    disableTime = millis() + time;
  }

  void rotation() {
    if (disable)
      return;

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
    if (
      prevPos.x == pos.x
      &&
      prevPos.y == pos.y
      ) return;

    JSONObject json;
    json = new JSONObject();

    json.setInt("clientid", clientid);
    json.setInt("x", int(pos.x));
    json.setInt("y", int(pos.y));
    json.setInt("angle", int(degrees(angle)));

    network.emit("position", json);
  }
  
  void shoot(){
    float mx = mouseX, my = mouseY;
    
    JSONObject json;
    json = new JSONObject();
    
    json.setFloat("x1", pos.x);
    json.setFloat("y1", pos.y);
    json.setFloat("x2", mx);
    json.setFloat("y2", my);
    
    network.emit("bullet", json);
    println("Bullet sent");
  }

  void keyPressed() {
    updateButtons(key, true);
    
    if (
      keyUpG == true
      &&
      key == 'g'
    ) {
      keyUpG = false;
      shoot();
    }
  }

  void keyReleased() {
    updateButtons(key, false);
    
    if (key == 'g') {
      keyUpG = true;
    }
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
}