class Debug {
  private StringList displayedElements = new StringList();
  
  Debug() {
    show("scene-changer");
  }
  
  void show(String elKey) {
    displayedElements.append(elKey);
  }
  
  void update() {
    for (String elKey : displayedElements) {
      switch (elKey) {
      case "scene-changer":
        showSceneChanger();
        break;
      }
    }
  }
  
  void showSceneChanger() {
    StringList keys = scenes.getSceneList();
    
    int x = width - 50;
    int y = 20;
    
    for (String sceneKey : keys) {
      textSize(14);
      text(
        sceneKey,
        x,
        y 
      );
      
      if (mouseEvent.downIn(x, y - 10, x + (width - x), y + 5)) {
        pr("Scene changed to \""+ sceneKey +"\"");
        scenes.change(sceneKey);
      }
      
      y += 20;
    }
  }
  
  void pr(String message) {
    println("&Debug: "+ message);
  }
}
