class ExplosionController{
  LinkedList<Explosion> explosions;
  
  ExplosionController(){
    explosions = new LinkedList<Explosion>();
  }
  
  void addExplosion(PVector coordinates){
    explosions.add(new Explosion(coordinates));
  }
  
  void damage(){
    
  }
  
  void display(){
    for(int i = explosions.size()-1; i >= 0; i--){
      explosions.get(i).display();
      if(explosions.get(i).hitPlayer()){
        player.hp--;
        explosions.remove(i);
      }
      else if(explosions.get(i).phase == 6) explosions.remove(i);
    }
  }
}

class Explosion{
  float x, y;
  int phase;
  
  PImage phase01 = loadImage("blast01.png");
  PImage phase02 = loadImage("blast02.png");
  PImage phase03 = loadImage("blast03.png");
  
  Explosion(PVector pos){
    x = pos.x;
    y = pos.y;
    phase = 1;
  }
  
  void display(){
    if(phase <= 2){
      image(phase01, x, y, unit, unit);
    }
    else if(phase <= 4){
      image(phase02, x, y, unit, unit);
    }
    else if(phase <= 6){
      image(phase03, x, y, unit, unit);
    }
    
    phase++;
  }
  
  boolean hitPlayer(){
    return x > player.x-unit/2 && x < player.x+unit/2 && y > player.y-unit/2 && y < player.y+unit/2;
  }
}