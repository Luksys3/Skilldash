class Terrain {
  void draw() {
    background(48, 167, 30);
    fill(255, 0, 0);

    //Center area/OP Item spawn area

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
    
    //Med area
    
    fill(252,18,137);
    noStroke();
    ellipse(width/2,40,80,80);
    ellipse(width/2,610,80,80);
  }
}