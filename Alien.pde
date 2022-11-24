class AlienController{
  private LinkedList <Alien> aliens;
  
  AlienController(){
    aliens = new LinkedList <Alien>();
  }
  
  void addAlien(Coordinates coordinates){
    Velocity velocity = new Velocity(Window.WIDTH / 100, 0);
    aliens.add(new Alien(coordinates, velocity));
  }
  
  void display(){
    Iterator<Alien> iterator = aliens.iterator();
    while(iterator.hasNext()){
      Alien alien = iterator.next();

      alien.display();
      alien.move();
      
      if(alien.isOffWindow()) iterator.remove(i);
    }
  }
}

class Alien extends Entity {
  int phase;
  
  PImage currentSkin;
  PImage alien01 = loadImage("alien01.png");
  PImage alien02 = loadImage("alien02.png");
  PImage alien03 = loadImage("alien03.png");
  PImage alien04 = loadImage("alien04.png");
  
  Alien(Coordinates coordinates, Velocity velocity){
    super(coordinates, velocity);
    this.phase = 1;
    currentSkin = alien01;
  }
  
  @Override
  public void display(){
    switch (phase){
      case 1: case 2:
        currentSkin = alien01;
        break;
      case 3: case 4:
        currentSkin = alien02;
        break;
      case 5: case 6:
        currentSkin = alien03;
        break;
      case 7: case 8:
        currentSkin = alien04;
        break;
      default :
        phase = 1;
        currentSkin = alien01;
        break;	
    }

    image(currentSkin, coordinates.x, coordinates.y, unit * 2, unit * 2);
    phase++;
  }
}