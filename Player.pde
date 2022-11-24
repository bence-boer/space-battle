class Spacecraft extends Entity{
  PImage ship = loadImage("ship.png");
  PImage[] healthBar = new PImage[4];
  int hp;
  int bulletDamage;
  int prevHp;
  int cannonLevel;
  int shootingFrequency;
  
  Spacecraft(float coordinate.x, float coordinate.y){
    super(coordinate.x, coordinate.y);
    for(int i = 0; i < healthBar.length; i++){
      healthBar[i] = loadImage("healthbar0"+(i+1)+".png");
    }
    this.hp = 0;
    this.bulletDamage = 1;
    this.cannonLevel = 1;
    this.shootingFrequency = 8;
  }
  
  void move(float deltaX, float deltaY){
    float newX = coordinate.x + deltaX;
    float newY = coordinate.y + deltaY;
    
    coordinate.x = constrain(newX, unit/2, width-unit/2);
    coordinate.y = constrain(newY, unit, height-unit/2);
  }
  
  void display(){
    image(ship, coordinate.x, coordinate.y, unit, unit);
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
    if(hp > 0) image(healthBar[4 - hp], coordinate.x, coordinate.y + unit * 0.75, unit * 1.5, unit * 1.5);
  }
  
  void testIfHit(){
    for(int i = 0; i < enemies.ships.size(); i++){
      OpponentController.Opponent enemy = enemies.ships.get(i);
      if(collidedWith(enemy)){
        hp--;
        // vibrator.vibrate(vEffect);
        explosions.addExplosion(enemy.coordinate.x, enemy.coordinate.y);
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
  
  boolean collidedWith(OpponentController.Opponent opponent){
    if(opponent.coordinate.x + unit / 2 > coordinate.x - unit / 2 && opponent.coordinate.x - unit / 2 < coordinate.x + unit / 2 &&
       opponent.coordinate.y + unit / 2 > coordinate.y - unit / 2 && opponent.coordinate.y - unit / 2 < coordinate.y + unit / 2){
         return true;
       }
    return false;
  }
  
  void shoot(){
    switch(cannonLevel){
      case 1:
      Bullet b1 = new Bullet(coordinate.x, player.coordinate.y - unit / 4, projectiles.startVelocity.x, projectiles.startVelocity.y, bulletDamage);
      
      projectiles.bullets.add(b1);
      projectiles.playerBullets.add(b1);
      break;
      
      case 2:
      Bullet b2 = new Bullet(coordinate.x - unit / 4, player.coordinate.y - unit / 4, projectiles.startVelocity.x, projectiles.startVelocity.y, bulletDamage);
      Bullet b3 = new Bullet(coordinate.x + unit / 4, player.coordinate.y - unit / 4, projectiles.startVelocity.x, projectiles.startVelocity.y, bulletDamage);
        
      projectiles.bullets.add(b2);
      projectiles.playerBullets.add(b2);
      projectiles.bullets.add(b3);
      projectiles.playerBullets.add(b3);
      break;
        
      case 3:
      PVector vel = projectiles.startVelocity.copy().rotate(PI * 0.05);
      Bullet b4 = new Bullet(coordinate.x + unit / 8, coordinate.y - unit / 4, vel.x, vel.y, bulletDamage);
      Bullet b5 = new Bullet(coordinate.x, coordinate.y - unit / 4, projectiles.startVelocity.x, projectiles.startVelocity.y, bulletDamage);
      vel.rotate(-PI * 0.1);
      Bullet b6 = new Bullet(coordinate.x - unit / 8, coordinate.y - unit / 4, vel.x, vel.y, bulletDamage);
        
      projectiles.bullets.add(b4);
      projectiles.playerBullets.add(b4);
      projectiles.bullets.add(b5);
      projectiles.playerBullets.add(b5);
      projectiles.bullets.add(b6);
      projectiles.playerBullets.add(b6);
      break;
      
      case 4:
      Bullet b7 = new Bullet(coordinate.x - unit / 4, coordinate.y - unit / 4, projectiles.startVelocity.x, projectiles.startVelocity.y, bulletDamage);
      Bullet b8 = new Bullet(coordinate.x + unit / 8, coordinate.y - unit / 4, projectiles.startVelocity.x, projectiles.startVelocity.y, bulletDamage);
      Bullet b9 = new Bullet(coordinate.x - unit / 8, coordinate.y - unit / 4, projectiles.startVelocity.x, projectiles.startVelocity.y, bulletDamage);
      Bullet b10 = new Bullet(coordinate.x + unit / 4, coordinate.y - unit / 4, projectiles.startVelocity.x, projectiles.startVelocity.y, bulletDamage);
        
     
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
