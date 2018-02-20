class Bullet {

  private int x;
  private int y;
  private int speed=20;
  private int px;
  private int py;
  private boolean death=false;
  private float distance;

  Bullet(int x1, int y1, int px1, int py1) {
    x=px1;
    y=py1;
    px=x1;
    py=y1;
  }
  void movement() {
    int AB = abs(px-x);
    int BC = abs(py-y);

    if (AB<=0) {
      die();
    } else {
      float angle = atan(BC/AB);

      if (x >= px ) {
        angle -= radians(180);
      }

      distance = dist(px, py, x, y);
      if ( distance < speed ) {
        x = px;
        y = py;
        return;
      }

      x += speed * cos(angle);
      y += speed * sin(angle);
    }
  }
  void draw() {
    fill(0);
    noStroke();
    ellipse(x, y, 10, 10);
  }
  void update() {
    if (!death) {
      movement();
      draw();
    }
  }
  boolean die() {
    return death=true;
  }
}