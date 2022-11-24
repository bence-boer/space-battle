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
  
  Bullet(Coordinate coordinate, Velocity velocity, int damage){
    super(coordinate, velocity);
    this.bullet = projectiles.playerBullet.copy();
    this.damage = damage;
  }
  
  void update(){
    move();
    display();
  }
  
  void move(){
    coordinate.add(velocity);
    if(isOut()) projectiles.bullets.remove(this);
  }
  
  void display(){
    image(bullet, coordinate.x, coordinates.y, unit, unit);
  }
  
  boolean isOut(){
    return coordinates.y < -unit || coordinates.y > height + unit;
  }
  
  public Bullet copy(){
    return new Bullet(coordinates, velocity, damage);
  }
}

class EnemyBullet extends Bullet{
  
  EnemyBullet(float coordinate.x, float coordinates.y, float xVelocity, float yVelocity, int damage){
    super(coordinate.x, coordinates.y, xVelocity, yVelocity, damage);
    this.bullet = projectiles.enemyBullet;
  }
  
  boolean hit(Spacecraft p){
    return coordinates.y > p.coordinates.y - unit / 2 && coordinates.y < p.coordinates.y + unit / 2 &&
           coordinate.x > p.coordinate.x - unit / 2 && coordinate.x < p.coordinate.x + unit / 2;     
  }
}
