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
    int choice = (int)random(1,10);
    float xPosition = random(unit/2,width-unit/2);
    float yPosition = -unit;
    Opponent opponent;
    
    if(choice > 7){
      opponent = new Shooter(xPosition, yPosition, 0.0, startVelocity, health-1);
    }
    else{
      opponent = new Opponent(xPosition, yPosition, player.xCoordinate - xPosition, player.yCoordinate + unit, health);
    }
    ships.add(opponent);
  }

  class Opponent extends Entity{
    int hp;
  
    Opponent(float xCoordinate, float yCoordinate, float xVelocity, float yVelocity, int hp){
      super(xCoordinate, yCoordinate, xVelocity, yVelocity);
      this.hp = hp;
    }
  
    void update(){
      move();
      if(isShot(projectiles.playerBullets) && hp <= 0) die();
      else display();
    }
  
    void move(){
      xCoordinate += xVelocity;
      yCoordinate += yVelocity;
      yVelocity += 0.2;
      if(this.isOut()) enemies.ships.remove(this);
    }
  
    void display(){
      imageMode(CENTER);
      pushMatrix();
      translate(xCoordinate, yCoordinate);
      rotate(atan(xVelocity/yVelocity) - HALF_PI);
      displayHealth();
      image(ship, 0, 0, unit, unit);
      popMatrix();
    }
  
    void displayHealth(){
      float w = hp*unit*0.24;
      float h = unit*0.18;
      if(hp < healthBar.length) image(healthBar[hp-1], 0, -unit * 0.75, w, h);
    }
  
    boolean isOut(){
      return yCoordinate > height + width / 14;
    }
  
    boolean isShot(LinkedList<Bullet> b){
      boolean shot = false;
      for(int i = 0; i < b.size(); i++){
        if(b.get(i).xCoordinate >= xCoordinate - unit/2 && b.get(i).xCoordinate <= xCoordinate + unit/2 &&
           b.get(i).yCoordinate >= yCoordinate - unit/2 && b.get(i).yCoordinate <= yCoordinate + unit/2){
          
          hp -= b.get(i).damage;
          projectiles.bullets.remove(projectiles.playerBullets.get(i));
          projectiles.playerBullets.remove(i);
          shot = true;
        }
      }
      return shot;
    }
  
    boolean collidedWith(Spacecraft spacecraft){
      return false;
    }
  
    void die(){
      explosions.addExplosion(xCoordinate, yCoordinate);
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
  
    Shooter(float xCoordinate, float yCoordinate, float xVelocity, float yVelocity, int hp){
      super(xCoordinate, yCoordinate, xVelocity, yVelocity, hp);
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
      if(yCoordinate > destination){
        yCoordinate = destination;
        xVelocity = 0;
        yVelocity = 0;
      }
      else{
        xCoordinate += xVelocity;
        yCoordinate += yVelocity;
      }
    }
  
    void shoot(){
      if((frameCount + delay) % shootingFrequency == 0){
        EnemyBullet bullet = new EnemyBullet(xCoordinate, yCoordinate, 0, bulletSpeed, 1);
        projectiles.bullets.add(bullet);
        projectiles.enemyBullets.add(bullet);
      }
    }
  
    void display(){
      imageMode(CENTER);
      displayHealth();
      image(ship02, xCoordinate, yCoordinate, unit, unit);
    }
    
    void displayHealth(){
      float width = hp * unit * 0.24;
      float height = unit * 0.18;
      if(hp < healthBar.length) image(healthBar[hp-1], xCoordinate, yCoordinate - unit * 0.75, width, height);
    }
  }
}
