class ProjectileStar extends Projectile{
   
  protected float x, y, mx, my;
  protected float speed = 5;
  
  ProjectileStar(float px, float py, float mousex, float mousey){
   x = px;
   y = py;
   mx = mousex;
   my = mousey;
  }
  
  void update(){
    draw();
  }
  
  void draw(){
    ellipse(x, y, 25, 25);
  }
}