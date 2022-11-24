class OpponentController{
  PImage healthBar[] = new PImage[8];
  PImage ship = loadImage("enemy1.png");
  PImage ship02 = loadImage("enemy02.png");
  Velocity startVelocity;
  int spawnSpeed;
  int health;
  ArrayList<Opponent> ships;
  
  OpponentController(){
    for(int i = 0; i < healthBar.length; i++){
      healthBar[i] = loadImage("enemy_health_bar_0"+(i+1)+".png");
    }
    startVelocity = new Velocity(0, height/100);
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
      opponent = new Opponent(xPosition, yPosition, player.coordinates.x - xPosition, player.coordinates.y + unit, health);
    }
    ships.add(opponent);
  }

  class Opponent extends Entity{
    int hp;
  
    Opponent(Coordinate coordinates, Velocity velocity, int hp){
      super(coordinates, velocity);
      this.hp = hp;
    }
  
    void update(){
      move();
      if(isShot(projectiles.playerBullets) && hp <= 0) die();
      else display();
    }
  
    void move(){
      coordinates.add(velocity);
      velocity.accelerate(0, 0.2);
      if(this.isOut()) enemies.ships.remove(this);
    }
  
    void display(){
      imageMode(CENTER);
      pushMatrix();
      translate(coordinates.x, coordinates.y);
      rotate(atan(velocity.x / velocity.y) - HALF_PI);
      displayHealth();
      image(ship, 0, 0, unit, unit);
      popMatrix();
    }
  
    void displayHealth(){
      float width = hp * unit * 0.24;
      float height = unit * 0.18;
      if(hp < healthBar.length) image(healthBar[hp-1], 0, -unit * 0.75, width, height);
    }
  
    boolean isOut(){
      return coordinates.y > height + width / 14;
    }
  
    boolean isShot(LinkedList<Bullet> bullets){
      boolean shot = false;
      for(int i = 0; i < b.size(); i++){
        if(bullets.get(i).coordinates.x >= coordinates.x - unit/2 && bullets.get(i).coordinates.x <= coordinates.x + unit/2 &&
           bullets.get(i).coordinates.y >= coordinates.y - unit/2 && bullets.get(i).coordinates.y <= coordinates.y + unit/2){
          
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
      explosions.addExplosion(coordinates);
      scoreboard.scored();
      enemies.startVelocity.accelerate(height/5000);
      enemies.ships.remove(this);
    }
  }


  class Shooter extends Opponent{
    int shootingFrequency;
    float bulletSpeed;
    int delay;
    float destination;
    boolean isMoving;
  
    Shooter(float coordinates.x, float coordinates.y, float xVelocity, float yVelocity, int hp){
      super(coordinates.x, coordinates.y, xVelocity, yVelocity, hp);
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
      if(coordinates.y > destination){
        coordinates.y = destination;
        xVelocity = 0;
        yVelocity = 0;
      }
      else{
        coordinates.x += xVelocity;
        coordinates.y += yVelocity;
      }
    }
  
    void shoot(){
      if((frameCount + delay) % shootingFrequency == 0){
        EnemyBullet bullet = new EnemyBullet(coordinates.x, coordinates.y, 0, bulletSpeed, 1);
        projectiles.bullets.add(bullet);
        projectiles.enemyBullets.add(bullet);
      }
    }
  
    void display(){
      imageMode(CENTER);
      displayHealth();
      image(ship02, coordinates.x, coordinates.y, unit, unit);
    }
    
    void displayHealth(){
      float width = hp * unit * 0.24;
      float height = unit * 0.18;
      if(hp < healthBar.length) image(healthBar[hp-1], coordinates.x, coordinates.y - unit * 0.75, width, height);
    }
  }
}
