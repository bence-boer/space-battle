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


class Bullet{
  PImage bullet;
  float vx, vy;
  int damage;
  
  Bullet(PVector pos, PVector vel, int damage){
    this.bullet = projectiles.playerBullet;
    this.xCoordinate = pos.xCoordinate;
    this.y = pos.y;
    this.vx = vel.x;
    this.vy = vel.y;
    this.damage = damage;
  }
  
  void update(){
    move();
    display();
  }
  
  void move(){
    x += vx;
    y += vy;
    if(isOut()) projectiles.bullets.remove(this);
  }
  
  void display(){
    image(bullet, x, y, unit, unit);
  }
  
  boolean isOut(){
    return y < -unit || y > height+unit;
  }
}

class EnemyBullet extends Bullet{
  
  EnemyBullet(PVector pos, PVector vel, int damage){
    super(pos, vel, damage);
    bullet = projectiles.enemyBullet;
  }
  
  boolean hit(Spacecraft p){
    return y > p.y - unit/2 && y < p.y + unit/2 && x > p.x - unit/2 && x < p.x + unit/2;     
  }
}