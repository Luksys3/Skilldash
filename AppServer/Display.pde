class Display {
  private int[] textOffset = {10, 20};
  
  void refresh() {
    textOffset[1] = 20;
  }
  
  void show(String txt) {
    text(txt, textOffset[0], textOffset[1]);
    textOffset[1] += 15;
  }
}