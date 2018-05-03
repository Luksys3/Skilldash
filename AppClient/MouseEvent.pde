class MouseEvent {
  
  boolean downIn(int x1, int y1, int x2, int y2) {
    if (mousePressed == false)
      return false;
    
    if (
      mouseX < x1
      ||
      mouseX > x2
      ||
      mouseY < y1
      ||
      mouseY > y2
    ) return false;
      
    
    return true;
  }
}
