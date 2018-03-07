class Bullet {
  private float x;
  private float y;
  private float speed=20;
  private float mx;
  private float my;
  private boolean dead = false;
  private float angle;

  private String id = str(randomId());

  Bullet(float x1, float y1, float px1, float py1) {
    x = x1;
    y = y1;
    mx = px1;
    my = py1;

    setup();
  }

  void setup() {
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

  void movement() {
    x += speed * cos(angle - PI / 2);
    y += speed * sin(angle - PI / 2);
  }

  void draw() {
    fill(0);
    noStroke();
    ellipse(x, y, 10, 10);
  }

  void update() {
    if (
      x < 0 || x > width
      ||
      y < 0 || y > height
    ) {
      die();
      return;
    }
    
    if (isDead()) 
      return;

    movement();

    draw();
  }

  void die() {
    dead = true;
  }

  boolean isDead() {
    return dead;
  }

  String getId() {
    return id;
  }
}