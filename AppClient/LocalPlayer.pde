class LocalPlayer extends Player {
  //Movement variables
  private int kx, ky;
  private boolean left   = false;
  private boolean right  = false;
  private boolean up     = false;
  private boolean down   = false;

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

    float maxX, minX, maxY, minY;

    float h, v;

    if (x > mx) {
      maxX = x;
      minX = mx;
    } else {
      maxX = mx;
      minX = x;
    }

    if (y > my) {
      maxY = y;
      minY = my;
    } else {
      maxY = my;
      minY = y;
    }

    h = maxX - minX;

    v = maxY - minY;

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

  void keyPressed() {
    updateButtons(key, true);
  }

  void keyReleased() {
    updateButtons(key, false);
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