class Spacecraft extends Entity{
  PImage ship = loadImage("ship.png");
  PImage[] healthBar = new PImage[4];
  int hp;
  int bulletDamage;
  int prevHp;
  int cannonLevel;
  int shootingFrequency;
  
  Spacecraft(float xCoordinate, float yCoordinate){
    super(xCoordinate, yCoordinate);
    for(int i = 0; i < healthBar.length; i++){
      healthBar[i] = loadImage("healthbar0"+(i+1)+".png");
    }
    this.hp = 0;
    this.bulletDamage = 1;
    this.cannonLevel = 1;
    this.shootingFrequency = 8;
  }
  
  void move(float deltaX, float deltaY){
    float newX = xCoordinate + deltaX;
    float newY = yCoordinate + deltaY;
    
    xCoordinate = constrain(newX, unit/2, width-unit/2);
    yCoordinate = constrain(newY, unit, height-unit/2);
  }
  
  void display(){
    image(ship, xCoordinate, yCoordinate, unit, unit);
  }
  
  void upgrade(){
    projectiles.playerBullet = loadImage("bullet02.png");
    bulletDamage++;
  }
  
  boolean isAlive(){
    if(player.hp > 0){
      prevHp = hp;
      return true;
    }
    if(prevHp != hp){
      if(scoreboard.score > scoreboard.highscore) scoreboard.highscore = scoreboard.score;
      scoreboard.scoreList.add(scoreboard.score);
      setup();
    }
    return false;
  }
  
  void displayHealth(){
    if(hp > 0) image(healthBar[4 - hp], xCoordinate, yCoordinate + unit * 0.75, unit * 1.5, unit * 1.5);
  }
  
  void testIfHit(){
    for(int i = 0; i < enemies.ships.size(); i++){
      OpponentController.Opponent enemy = enemies.ships.get(i);
      if(collidedWith(enemy)){
        hp--;
        // vibrator.vibrate(vEffect);
        explosions.addExplosion(enemy.xCoordinate, enemy.yCoordinate);
        enemies.ships.remove(enemy);
      }
    }
    
    for(int i = 0; i < projectiles.enemyBullets.size(); i++){
      if(projectiles.enemyBullets.get(i).hit(this)){
        hp--;
        // vibrator.vibrate(vEffect);
        projectiles.enemyBullets.remove(i);
      }
    }
  }
  
  boolean collidedWith(OpponentController.Opponent o){
    if(o.xCoordinate + unit / 2 > xCoordinate - unit / 2 && o.xCoordinate - unit / 2 < xCoordinate + unit / 2 &&
       o.yCoordinate + unit / 2 > yCoordinate - unit / 2 && o.yCoordinate - unit / 2 < yCoordinate + unit / 2){
         return true;
       }
    return false;
  }
  
  void shoot(){
    switch(cannonLevel){
      case 1:
      Bullet b1 = new Bullet(xCoordinate, player.yCoordinate - unit / 4, projectiles.startVelocity.x, projectiles.startVelocity.y, bulletDamage);
      
      projectiles.bullets.add(b1);
      projectiles.playerBullets.add(b1);
      break;
      
      case 2:
      Bullet b2 = new Bullet(new PVector(xCoordinate - unit / 4, player.yCoordinate - unit / 4), projectiles.startVelocity, bulletDamage);
      Bullet b3 = new Bullet(new PVector(xCoordinate + unit / 4, player.yCoordinate - unit / 4), projectiles.startVelocity, bulletDamage);
        
      projectiles.bullets.add(b2);
      projectiles.playerBullets.add(b2);
      projectiles.bullets.add(b3);
      projectiles.playerBullets.add(b3);
      break;
        
      case 3:
      Bullet b4 = new Bullet(new PVector(xCoordinate + unit / 8, yCoordinate - unit / 4), projectiles.startVelocity.copy().rotate(PI * 0.05), bulletDamage);
      Bullet b5 = new Bullet(new PVector(xCoordinate, yCoordinate - unit / 4), projectiles.startVelocity, bulletDamage);
      Bullet b6 = new Bullet(new PVector(xCoordinate - unit / 8, yCoordinate - unit / 4), projectiles.startVelocity.copy().rotate(-PI * 0.05), bulletDamage);
        
      projectiles.bullets.add(b4);
      projectiles.playerBullets.add(b4);
      projectiles.bullets.add(b5);
      projectiles.playerBullets.add(b5);
      projectiles.bullets.add(b6);
      projectiles.playerBullets.add(b6);
      break;
      
      case 4:
      Bullet b7 = new Bullet(new PVector(xCoordinate - unit / 4, yCoordinate - unit / 4), projectiles.startVelocity, bulletDamage);
      Bullet b8 = new Bullet(new PVector(xCoordinate + unit / 8, yCoordinate - unit / 4), projectiles.startVelocity, bulletDamage);
      Bullet b9 = new Bullet(new PVector(xCoordinate - unit / 8, yCoordinate - unit / 4), projectiles.startVelocity, bulletDamage);
      Bullet b10 = new Bullet(new PVector(xCoordinate + unit / 4, yCoordinate - unit / 4), projectiles.startVelocity, bulletDamage);
        
     
      projectiles.bullets.add(b7);
      projectiles.playerBullets.add(b7);
      projectiles.bullets.add(b8);
      projectiles.playerBullets.add(b8);
      projectiles.bullets.add(b9);
      projectiles.playerBullets.add(b9);
      projectiles.bullets.add(b10);
      projectiles.playerBullets.add(b10);
      break;
      
      default:
      cannonLevel = 2;
      upgrade();
      break;
    }
  }
}
