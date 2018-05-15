class JoinGameScene extends Scene {
  private int inputWidth  = 200;
  private int inputHeight = 30;
  
  private Group inputsGroup;
  
  void init() {
    // Create inputs group
    inputsGroup = cp5.addGroup("join-game")
        .setPosition(0, 0)
        .setBackgroundHeight(600);
    
    // Add inputs
    cp5.addTextfield("server-ip-address")
       .setGroup("join-game")
       .setPosition((width - inputWidth) / 2, 100)
       .setSize(inputWidth, inputHeight)
       .setFocus(true)
       .setFont(createFont("arial", 20))
       .setColor(color(200))
       .setText(IPADDRESS);
    
    cp5.addTextfield("server-port")
       .setGroup("join-game")
       .setPosition((width - inputWidth) / 2, 160)
       .setSize(inputWidth, inputHeight)
       .setFont(createFont("arial", 20))
       .setColor(color(200))
       .setText(PORT);
       
    
    cp5.addButton("connect")
       .setGroup("join-game")
       .setValue(0)
       .setPosition((width - inputWidth) / 2, 220)
       .setSize(inputWidth, inputHeight)
       .addCallback(new CallbackListener() {
          public void controlEvent(CallbackEvent event) {
            if (event.getAction() != ControlP5.ACTION_RELEASED)
              return;
            
            scenes.change("game");
          }
       });
  }
  
  void mount() {
    println("Join game scene mounted");
    
    inputsGroup.show();
  }
  
  void unmount() {
    IPADDRESS = cp5.get(Textfield.class, "server-ip-address").getText();
    PORT      = cp5.get(Textfield.class, "server-port").getText();
    
    // Hide inputs
    inputsGroup.hide();
  }
}
