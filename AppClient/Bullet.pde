class Bullet {

  private float x;
  private float y;
  private float speed=20;
  private float mx;
  private float my;
  private boolean death=false;
  private float angle;

  Bullet(float x1, float y1, float px1, float py1) {
    x=px1;
    y=py1;
    mx=x1;
    my=y1;

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

    println(angle * 180 / PI);
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
    if (!death) {
      movement();

      println(angle * 180 / PI);

      draw();
    }
  }
  boolean die() {
    return death=true;
  }
}