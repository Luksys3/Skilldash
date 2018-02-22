class Terrain {
  void draw() {
    background(48, 167, 30);
    fill(255, 0, 0);

    //Center area/Item spawn area

    rectMode(CENTER);
    rect(width/2, height/2, 200, 100);
    noStroke();
    fill(255, 0, 0, 20);
    rect(width/2, height/2, 220, 120);

    //Black holes/Riples

    fill(0);
    ellipse(300, 600, 200, 80);
    ellipse(1000, 50, 200, 80);
    noStroke();
    fill(0, 0, 0, 20);
    ellipse(300, 600, 300, 100);
    ellipse(1000, 50, 300, 100);
  }
}