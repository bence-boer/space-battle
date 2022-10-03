class OpponentController{
  PImage healthBar[] = new PImage[8];
  PImage ship = loadImage("enemy1.png");
  PImage ship02 = loadImage("enemy02.png");
  float startVelocity;
  int spawnSpeed;
  int health;
  ArrayList<Opponent> ships;
  
  OpponentController(){
    for(int i = 0; i < healthBar.length; i++){
      healthBar[i] = loadImage("enemy_health_bar_0"+(i+1)+".png");
    }
    startVelocity = height/100;
    spawnSpeed = 15;
    health = 2;
    ships = new ArrayList<Opponent>();
  }
  
  void update(){
    for(int i = ships.size()-1; i >= 0; i--){
      ships.get(i).update();
    }
  }
  
  void shipWave(){
    float rnd = random(unit/2,width-unit/2);
    int choice = (int)random(1,10);
    PVector pos = new PVector(rnd, -unit);
    if(choice > 7){
      ships.add(new Shooter(pos, new PVector(0, startVelocity).setMag(startVelocity), health-1));
    }
    else ships.add(new Opponent(pos, new PVector(player.x, player.y).sub(new PVector(rnd, -unit)).setMag(startVelocity), health));
  }

  class Opponent{
    PVector pos;
    PVector vel;
    int hp;
  
    Opponent(PVector pos, PVector vel, int hp){
      this.pos = pos;
      this.vel = vel;
      this.hp = hp;
    }
  
    void update(){
      move();
      if(isShot(projectiles.playerBullets) && hp <= 0) die();
      else display();
    }
  
    void move(){
      pos.add(vel);
      vel.add(new PVector(0,0.2));
      if(this.isOut()) enemies.ships.remove(this);
    }
  
    void display(){
      imageMode(CENTER);
      pushMatrix();
      translate(pos.x, pos.y);
      rotate(vel.heading() - HALF_PI);
      displayHealth();
      image(ship, 0, 0, unit, unit);
      popMatrix();
    }
  
    void displayHealth(){
      float w = hp*unit*0.24;
      float h = unit*0.18;
      if(hp < healthBar.length) image(healthBar[hp-1], 0, -unit*0.75, w, h);
    }
  
    boolean isOut(){
      return pos.y > height+width/14;
    }
  
    boolean isShot(ArrayList<Bullet> b){
      boolean shot = false;
      for(int i = 0; i < b.size(); i++){
        if(b.get(i).x >= pos.x - unit/2 && b.get(i).x <= pos.x + unit/2 &&
           b.get(i).y >= pos.y - unit/2 && b.get(i).y <= pos.y + unit/2){
          
          hp -= b.get(i).damage;
          projectiles.bullets.remove(projectiles.playerBullets.get(i));
          projectiles.playerBullets.remove(i);
          shot = true;
        }
      }
      return shot;
    }
  
    boolean collidedWith(Spacecraft p){
      return false;
    }
  
    void die(){
      explosions.addExplosion(pos);
      scoreboard.scored();
      enemies.startVelocity += height/5000;
      enemies.ships.remove(this);
    }
  }


  class Shooter extends Opponent{
    int shootingFrequency;
    float bulletSpeed;
    int delay;
    float destination;
    boolean isMoving;
  
    Shooter(PVector pos, PVector vel, int hp){
      super(pos, vel, hp);
      shootingFrequency = 30;
      bulletSpeed = height/80;
      delay = frameCount % shootingFrequency;
      destination = random(unit*2, unit*5);
      isMoving = true;
    }
  
    void update(){
      if(isMoving) move();
      shoot();
      if(isShot(projectiles.playerBullets) && hp <= 0) die();
      else display();
    }
  
    void move(){
      if(pos.y > destination){
        pos.y = destination;
        vel.set(new PVector(0,0));
      }
      else pos.add(vel);
    }
  
    void shoot(){
      if((frameCount + delay) % shootingFrequency == 0){
        EnemyBullet bullet = new EnemyBullet(pos, new PVector(0, bulletSpeed), 1);
        projectiles.bullets.add(bullet);
        projectiles.enemyBullets.add(bullet);
      }
    }
  
    void display(){
      imageMode(CENTER);
      displayHealth();
      image(ship02, pos.x, pos.y, unit, unit);
    }
    
    void displayHealth(){
      float w = hp * unit * 0.24;
      float h = unit * 0.18;
      if(hp < healthBar.length) image(healthBar[hp-1], pos.x, pos.y - unit * 0.75, w, h);
    }
  }
}
