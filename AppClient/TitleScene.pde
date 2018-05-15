class TitleScene extends Scene {
  int menuItemYPos;
  
  void update() {
    //println("TitleScene");
    menuItemYPos = 170;
    createMenuItem("Join game", "join-game");
    createMenuItem("Quit", "exit");
  }
  
  void createMenuItem(String title, String scene) {
    int widthPx = 200;
    int heightPx = 50;
    int borderWidth = 3;
    int fontSize = 22;
    int space = 50;
    
    int xPos = int(width / 2 - widthPx / 2 - borderWidth);
    
    stroke(0);
    strokeWeight(borderWidth);
    fill(200);
    rect(
      xPos,
      menuItemYPos,
      widthPx,
      heightPx
    );
    
    textAlign(CENTER, CENTER);
    textSize(fontSize);
    fill(0);
    text(
      title,
      width / 2,
      menuItemYPos + heightPx / 2 - 3
    );
    textAlign(LEFT, BOTTOM);
    strokeWeight(0);
    
    if (mouseEvent.downIn(xPos, menuItemYPos, xPos + widthPx, menuItemYPos + heightPx))
      scenes.change(scene);
    
    menuItemYPos += space + heightPx;
  }
}
