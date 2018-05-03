import processing.net.*;
import java.util.Map;
import java.util.Iterator;

// Used for input fields
//import controlP5.*;

int requestInterval = 40;

Debug debug = new Debug();


LocalPlayer localPlayer;
HashMap<String, Player> players;

Scenes scenes = new Scenes();
Network network;
Client client;
Terrain terrain;
ProjectileManager projectileManager;

MouseEvent mouseEvent = new MouseEvent();

// - Projectiles init
HashMap<String, ProjectileStar> projectilesStar = new HashMap<String, ProjectileStar>();

AppClient appClient = this;

void setup() {
  size(600, 560);
  
  debug.show("scene-changer");
  
  //frameRate(1);
}

void draw() {
  //terrain.draw();
  background(150);
  
  scenes.update();
  debug.update();
  
  // Always at bottom
  Key.update();
}

void keyPressed() {
  Key.press(key);
}

void keyReleased() {
  Key.release(key);
}
