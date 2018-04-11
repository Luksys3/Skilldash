static class Key {
  static HashMap<Character, Boolean> down = new HashMap<Character, Boolean>();
  //static HashMap<Character, Boolean> pressed = new HashMap<Character, Boolean>();
  static HashMap<Character, Boolean> released = new HashMap<Character, Boolean>();
  
  static void update() {
    //pressed = new HashMap<Character, Boolean>();
    released = new HashMap<Character, Boolean>();
  }
  
  static void press(char k) {
    down.put(k, true);
    
    //if (!pressed.containsKey(k)) {
    //  pressed.put(k, true);
    //  println("Not Contain");
    //} else if (pressed.get(k) == true) {
    //  println("Set to false");
    //  pressed.put(k, false);
    //}
    
    //println("Press: "+ k);
  }
  
  static void release(char k) {
    down.put(k, false);
    released.put(k, true);
    
    //pressed.remove(k);
    
    //println("Release: "+ k);
  }
  
  static boolean isDown(char k) {
    if (!down.containsKey(k))
      return false;
      
    return down.get(k);
  }
  
  //static boolean onPress(char k) {
  //  if (!pressed.containsKey(k))
  //    return false;
      
  //  return pressed.get(k);
  //}
  
  static boolean isPressed(char k) {
    if (!released.containsKey(k))
      return false;
      
    return true;
  }
}