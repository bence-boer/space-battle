class ExplosionController{
  private final LinkedList<Explosion> explosions;
  
  public ExplosionController(){
    explosions = new LinkedList<Explosion>();
  }
  
  public void addExplosion(Coordinate coordinates){
    explosions.add(new Explosion(coordinates));
  }
  
  void damage(){
    
  }
  
  public void display(){
    Iterator<Explosion> iterator = explosions.iterator();
    while(iterator.hasNext()){
      Explosion explosion = iterator.next();
      explosion.display();
      
      if(explosion.hitPlayer()){
        player.hp--;
        iterator.remove();
      }
      else if(explosion.isFinished()){
        iterator.remove();
      }
    }
  }
}

class Explosion extends Entity{
  private int phase = 0;
  private final int finalPhase = 6;
  
  private PImage phase01 = loadImage("blast01.png");
  private PImage phase02 = loadImage("blast02.png");
  private PImage phase03 = loadImage("blast03.png");
  
  public Explosion(float coordinates){
    super(coordinates);
  }
  
  public void display(){
    if(phase <= 2){
      image(phase01, coordinates.x, coordinates.y, unit, unit);
    }
    else if(phase <= 4){
      image(phase02, coordinates.x, coordinates.y, unit, unit);
    }
    else if(phase <= 6){
      image(phase03, coordinates.x, coordinates.y, unit, unit);
    }
    phase++;
  }
  
  public boolean hitPlayer(){
    return coordinates.x > player.coordinates.x - unit / 2 && coordinates.x < player.coordinates.x + unit / 2 &&
           coordinates.y > player.coordinates.y - unit / 2 && coordinates.y < player.coordinates.y + unit / 2;
  }

  public boolean isFinished(){
    return phase >= finalPhase;
  }
}
