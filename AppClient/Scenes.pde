class Scenes {
  private String defaultScene = "title";
  private String scene = defaultScene;
  private HashMap<String, Scene> scenes = new HashMap<String, Scene>();
  
  Scenes() {
    // Add scenes
    scenes.put("title", new TitleScene());
    scenes.put("game", new GameScene());
  }
  
  boolean is(String name) {
    return scene == name;
  }
  
  void update() {
    if (scenes.containsKey(scene)) {
      // Update current scene
      scenes.get(scene).update();
    }
      
    text("Scene: "+ scene, 10, 20);
  }
  
  void change(String name) {
    // Call old scene unmount method
    Scene oldScene = getScene(scene);
    if (oldScene != null)
      oldScene.unmount();
    
    // Call new scene mount method
    Scene newScene = getScene(name);
    if (newScene != null)
      newScene.mount();
    
    // Set scene
    scene = name;
  }
  
  Scene getScene(String name) {
    if (!scenes.containsKey(name))
      return null;
      
    return scenes.get(name);
  }
}
