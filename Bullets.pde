class BulletController{
  LinkedList<Bullet> bullets;
  LinkedList<Bullet> playerBullets;
  LinkedList<EnemyBullet> enemyBullets;
  PVector startVelocity;
  
  PImage playerBullet;
  PImage enemyBullet;
  
  BulletController(){
    bullets = new LinkedList<Bullet>();
    playerBullets = new LinkedList<Bullet>();
    enemyBullets = new LinkedList<EnemyBullet>();
    startVelocity = new PVector(0, -height/40);
    
    playerBullet = loadImage("bullet.png");
    enemyBullet = loadImage("v02bullet.png");
  }
  
  void update(){
    for(int i = bullets.size()-1; i >= 0; i--){
      bullets.get(i).update();
    }
  }
}


class Bullet extends Entity{
  PImage bullet;
  int damage;
  
  Bullet(float xCoordinate, float yCoordinate, float xVelocity, float yVelocity, int damage){
    super(xCoordinate, yCoordinate, unit, unit);
    this.bullet = projectiles.playerBullet;
    this.xCoordinate = xCoordinate;
    this.yCoordinate = yCoordinate;
    this.xVelocity = xVelocity;
    this.yVelocity = yVelocity;
    this.damage = damage;
  }
  
  void update(){
    move();
    display();
  }
  
  void move(){
    xCoordinate += xVelocity;
    yCoordinate += yVelocity;
    if(isOut()) projectiles.bullets.remove(this);
  }
  
  void display(){
    image(bullet, xCoordinate, yCoordinate, unit, unit);
  }
  
  boolean isOut(){
    return yCoordinate < -unit || yCoordinate > height + unit;
  }
}

class EnemyBullet extends Bullet{
  
  EnemyBullet(float xCoordinate, float yCoordinate, float xVelocity, float yVelocity, int damage){
    super(xCoordinate, yCoordinate, xVelocity, yVelocity, damage);
    this.bullet = projectiles.enemyBullet;
  }
  
  boolean hit(Spacecraft p){
    return yCoordinate > p.yCoordinate - unit / 2 && yCoordinate < p.yCoordinate + unit / 2 &&
           xCoordinate > p.xCoordinate - unit / 2 && xCoordinate < p.xCoordinate + unit / 2;     
  }
}
