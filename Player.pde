class Spacecraft{
  PImage ship = loadImage("ship.png");
  PImage[] healthBar = new PImage[4];
  float x, y;
  int hp;
  int bulletDamage;
  int prevHp;
  int cannonLevel;
  int shootingFrequency;
  
  Spacecraft(float x, float y){
    for(int i = 0; i < healthBar.length; i++){
      healthBar[i] = loadImage("healthbar0"+(i+1)+".png");
    }
    this.x = x;
    this.y = y;
    hp = 0;
    bulletDamage = 1;
    cannonLevel = 1;
    shootingFrequency = 8;
  }
  
  void move(float deltaX, float deltaY){
    float newX = x + deltaX;
    float newY = y + deltaY;
    
    x = constrain(newX, unit/2, width-unit/2);
    y = constrain(newY, unit, height-unit/2);
  }
  
  void display(){
    image(ship, x, y, unit, unit);
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
    if(hp > 0) image(healthBar[4-hp], x, y+unit*0.75, unit*1.5, unit*1.5);
  }
  
  void testIfHit(){
    for(int i = 0; i < enemies.ships.size(); i++){
      if(collidedWith(enemies.ships.get(i))){
        hp--;
        // vibrator.vibrate(vEffect);
        explosions.addExplosion(enemies.ships.get(i).pos);
        enemies.ships.remove(i);
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
    if(o.pos.x + unit/2 > x - unit/2 && o.pos.x - unit/2 < x + unit/2 &&
       o.pos.y + unit/2 > y - unit/2 && o.pos.y - unit/2 < y + unit/2){
         return true;
       }
    return false;
  }
  
  void shoot(){
    switch(cannonLevel){
      case 1:
      Bullet b1 = new Bullet(new PVector(x, player.y-unit/4), projectiles.startVel, bulletDamage);
      
      projectiles.bullets.add(b1);
      projectiles.playerBullets.add(b1);
      break;
      
      case 2:
      Bullet b2 = new Bullet(new PVector(x-unit/4, player.y-unit/4), projectiles.startVel, bulletDamage);
      Bullet b3 = new Bullet(new PVector(x+unit/4, player.y-unit/4), projectiles.startVel, bulletDamage);
        
      projectiles.bullets.add(b2);
      projectiles.playerBullets.add(b2);
      projectiles.bullets.add(b3);
      projectiles.playerBullets.add(b3);
      break;
        
      case 3:
      Bullet b4 = new Bullet(new PVector(x+unit/8, y-unit/4), projectiles.startVel.copy().rotate(PI*0.05), bulletDamage);
      Bullet b5 = new Bullet(new PVector(x, y-unit/4), projectiles.startVel, bulletDamage);
      Bullet b6 = new Bullet(new PVector(x-unit/8, y-unit/4), projectiles.startVel.copy().rotate(-PI*0.05), bulletDamage);
        
      projectiles.bullets.add(b4);
      projectiles.playerBullets.add(b4);
      projectiles.bullets.add(b5);
      projectiles.playerBullets.add(b5);
      projectiles.bullets.add(b6);
      projectiles.playerBullets.add(b6);
      break;
      
      case 4:
      Bullet b7 = new Bullet(new PVector(x-unit/4, y-unit/4), projectiles.startVel, bulletDamage);
      Bullet b8 = new Bullet(new PVector(x+unit/8, y-unit/4), projectiles.startVel, bulletDamage);
      Bullet b9 = new Bullet(new PVector(x-unit/8, y-unit/4), projectiles.startVel, bulletDamage);
      Bullet b10 = new Bullet(new PVector(x+unit/4, y-unit/4), projectiles.startVel, bulletDamage);
        
     
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
