class ExplosionController{
  LinkedList<Explosion> explosions;
  
  ExplosionController(){
    explosions = new LinkedList<Explosion>();
  }
  
  void addExplosion(float xCoordinate, float yCoordinate){
    explosions.add(new Explosion(xCoordinate, yCoordinate));
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

class Explosion extends Entity{
  int phase;
  
  PImage phase01 = loadImage("blast01.png");
  PImage phase02 = loadImage("blast02.png");
  PImage phase03 = loadImage("blast03.png");
  
  Explosion(float xCoordinate, float yCoordinate){
    super(xCoordinate, yCoordinate);
    phase = 1;
  }
  
  void display(){
    if(phase <= 2){
      image(phase01, xCoordinate, yCoordinate, unit, unit);
    }
    else if(phase <= 4){
      image(phase02, xCoordinate, yCoordinate, unit, unit);
    }
    else if(phase <= 6){
      image(phase03, xCoordinate, yCoordinate, unit, unit);
    }
    
    phase++;
  }
  
  boolean hitPlayer(){
    return xCoordinate > player.xCoordinate - unit / 2 && xCoordinate < player.xCoordinate + unit / 2 &&
           yCoordinate > player.yCoordinate - unit / 2 && yCoordinate < player.yCoordinate + unit / 2;
  }
}
