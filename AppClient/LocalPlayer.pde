class LocalPlayer extends Player {
  //Movement variables
  private int kx, ky;
  private boolean left   = false;
  private boolean right  = false;
  private boolean up     = false;
  private boolean down   = false;
  
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

    sendPos();
    draw();
  }
  
  void movement() {
    // Saves position
    prevPos.set(pos);

    if (left) {
      vel.x = -speed;
      kx = -1;
    } else if (right) {
      vel.x = speed;
      kx = 1;
    } else
      vel.x = 0;

    if (up) {
      vel.y = -speed;
      ky = -1;
    } else if (down) {
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