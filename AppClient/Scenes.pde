class Scenes {
  private String defaultScene = "title";
  private String scene;
  
  private StringList sceneList = new StringList();
  private HashMap<String, Scene> scenesArray = new HashMap<String, Scene>();
  
  Scenes() {
    // Add scenes
    scenesArray.put("title",     new TitleScene());
    scenesArray.put("game",      new GameScene());
    scenesArray.put("join-game", new JoinGameScene());
    scenesArray.put("exit",      new ExitScene());
    
    updateSceneList();
    
    // Change to default scene
    change(defaultScene);
  }
  
  boolean is(String name) {
    return scene == name;
  }
  
  void update() {
    if (scenesArray.containsKey(scene)) {
      // Update current scene
      scenesArray.get(scene).update();
    }
      
    textSize(12);
    text("Scene: "+ scene, 10, 20);
  }
  
  void change(String name) {
    println("Changing to scene: "+ name);
    
    // Call old scene unmount method
    Scene oldScene = getScene(scene);
    if (oldScene != null)
      oldScene.unmount();
    
    // Call new scene mount method
    Scene newScene = getScene(name);
    if (newScene != null) {
      if (!newScene.isInitDone()) {
        newScene.init();
        newScene.setInitDone();
      }
      
      newScene.mount();
    }
    
    // Set scene
    scene = name;
  }
  
  Scene getScene(String name) {
    if (!scenesArray.containsKey(name))
      return null;
      
    return scenesArray.get(name);
    //return null;
  }
  
  StringList getSceneList() {
    return sceneList;
  }
  
  void updateSceneList() {
    for (Map.Entry pair : scenesArray.entrySet()) {
      sceneList.append((String)pair.getKey());
    }
  }
}
