class AlienController{
  ArrayList <Alien> aliens;
  
  AlienController(){
    aliens = new ArrayList<Alien>();
  }
  
  void addAlien(PVector coordinates){
  aliens.add(new Alien(coordinates));
  }
  
  void display(){
    for(int i = 0; i < aliens.size(); i++){
      aliens.get(i).display();
      aliens.get(i).pos.x += width/100;
      if(aliens.get(i).pos.x > width+unit) aliens.remove(i);
    }
  }
}

class Alien{
  PVector pos;
  int phase;
  
  PImage alien01 = loadImage("alien01.png");
  PImage alien02 = loadImage("alien02.png");
  PImage alien03 = loadImage("alien03.png");
  PImage alien04 = loadImage("alien04.png");
  
  Alien(PVector pos){
    this.pos = pos;
    phase = 1;
  }
  
  void display(){
    if(phase == 1 || phase == 2){
      image(alien01, pos.x, pos.y, unit*2, unit*2);
    }
    else if(phase == 3 || phase == 4){
      image(alien02, pos.x, pos.y, unit*2, unit*2);
    }
    else if(phase == 5 || phase == 6){
      image(alien03, pos.x, pos.y, unit*2, unit*2);
    }
    else if(phase == 7 || phase == 8){
      image(alien04, pos.x, pos.y, unit*2, unit*2);
      if(phase == 8) phase = 0;
    }
    phase++;
  }
}