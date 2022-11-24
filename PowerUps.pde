class PowerUpController{
  ArrayList<hpBoost> hpBoosts;
  ArrayList<BlastWave> blastWaves;
  ArrayList<Cannon> cannons;
  float startVelocity;
  float maxRadius;
  
  PowerUpController(){
    hpBoosts = new ArrayList<hpBoost>();
    blastWaves = new ArrayList<BlastWave>();
    cannons = new ArrayList<Cannon>();
    startVelocity = enemies.startVelocity;
    maxRadius = height/3;
  }
  
  void dropPowerUp(){
    int which = 0;
    PVector startPos = new PVector(random(unit/2, width-unit/2),-unit/2);
    if(scoreboard.score % 80 == 0 && player.cannonLevel <= 4) which = 2;
    else if(player.hp < 4) which = (int) random(0,2);
    switch(which){
      case 0:
      blastWaves.add(new BlastWave(startPos, new PVector (0, startVelocity)));
      break;
      
      case 1:
      hpBoosts.add(new hpBoost(startPos, new PVector (0, startVelocity)));
      break;
      
      case 2:
      cannons.add(new Cannon(startPos, new PVector (0, startVelocity)));
      break;
      
      default:
      enemies.ships.clear();
      break;
    }
  }
  
  void detonateBlasts(){ 
    for(int i = 0; i < blastWaves.size(); i++){
      if(blastWaves.get(i).detonated && blastWaves.get(i).blastRadius < maxRadius){
        blastWaves.get(i).clearArea();
        blastWaves.get(i).blastRadius += blastWaves.get(i).blastRadius/20;
      } 
      else if(blastWaves.get(i).vel.y <= 0) blastWaves.remove(i);
    }
  }
  
  void move(){
    for(int i = 0; i < blastWaves.size(); i++){
      blastWaves.get(i).pos.add(blastWaves.get(i).vel);
      if(blastWaves.get(i).pos.y > height+unit/2 || blastWaves.get(i).pos.y < -unit/2) blastWaves.remove(i);
      else if(blastWaves.get(i).pos.x > player.coordinate.x-unit/2 && blastWaves.get(i).pos.x < player.coordinate.x+unit/2 && blastWaves.get(i).pos.y > player.coordinate.y-unit/2 && blastWaves.get(i).pos.y < player.coordinate.y+unit/2){
        blastWaves.get(i).vel.y = -startVelocity;
        blastWaves.get(i).detonated = true;
      }
    }
    
    for(int i = 0; i < hpBoosts.size(); i++){
      hpBoosts.get(i).pos.add(hpBoosts.get(i).vel);
      if(hpBoosts.get(i).pos.y > height+unit/2) hpBoosts.remove(i);
      else if(hpBoosts.get(i).pos.x > player.coordinate.x-unit/2 && hpBoosts.get(i).pos.x < player.coordinate.x+unit/2 && hpBoosts.get(i).pos.y > player.coordinate.y-unit/2 && hpBoosts.get(i).pos.y < player.coordinate.y+unit/2){
        hpBoosts.get(i).activate();
        hpBoosts.remove(i);
      }
    }
    
    for(int i = 0; i < cannons.size(); i++){
      cannons.get(i).pos.add(cannons.get(i).vel);
      if(cannons.get(i).pos.y > height+unit/2) cannons.remove(i);
      else if(cannons.get(i).pos.x > player.coordinate.x-unit/2 &&
              cannons.get(i).pos.x < player.coordinate.x+unit/2 &&
              cannons.get(i).pos.y > player.coordinate.y-unit/2 &&
              cannons.get(i).pos.y < player.coordinate.y+unit/2){
        cannons.get(i).addCannon();
        cannons.remove(i);
      }
    }
  }
  
  void display(){
    for(int i = 0; i < hpBoosts.size(); i++){
      hpBoosts.get(i).display();
    }
    
    for(int i = 0; i < blastWaves.size(); i++){
      if(blastWaves.get(i).detonated) blastWaves.get(i).displayBlast();
      blastWaves.get(i).displayBomb();
    }
    
    for(int i = 0; i < cannons.size(); i++){
      cannons.get(i).display();
    }
  }
}

class hpBoost{
  PVector pos;
  PVector vel;
  PImage heal;
  
  hpBoost(PVector pos, PVector vel){
    this.pos = pos;
    this.vel = vel;
    heal = loadImage("heal.png");
  }
  
  void activate(){
    player.hp++;
  }
  
  void display(){
    image(heal, pos.x, pos.y, unit, unit);
  }
}

class BlastWave{
  PVector pos;
  PVector vel;
  float blastRadius;
  boolean detonated;
  PImage bomb;
  
  BlastWave(PVector pos, PVector vel){
    this.pos = pos;
    this.vel = vel;
    blastRadius = unit/2;
    detonated = false;
    bomb = loadImage("bomb.png");
  }
  
  void clearArea(){
    PVector shipPos = new PVector(0,0);
    for(int i = enemies.ships.size()-1; i >= 0; i--){
      shipPos.set(enemies.ships.get(i).coordinate.x, enemies.ships.get(i).coordinate.y);
      if(shipPos.dist(pos) < blastRadius+unit/2){
        enemies.ships.get(i).die();
      }
    }
  }
  
  void displayBomb(){
    image(bomb, pos.x, pos.y, unit, unit);
  }
  
  void displayBlast(){
    pushStyle();
    stroke(0,156,255,200);
    strokeWeight(5);
    fill(80,255,255,20);
    ellipse(pos.x, pos.y, blastRadius, blastRadius);
    popStyle();
  }
}

class Cannon{
  PVector pos;
  PVector vel;
  PImage cannon;
  
  Cannon(PVector pos, PVector vel){
    this.pos = pos;
    this.vel = vel;
    cannon = loadImage("cannon.png");
  }
  
  void display(){
    image(cannon, pos.x, pos.y, unit, unit);
  }
  
  void addCannon(){
    player.cannonLevel++;
  }
}
