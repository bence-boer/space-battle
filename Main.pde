import java.util.LinkedList;

Spacecraft player;
Scoreboard scoreboard = new Scoreboard();
BulletController projectiles;
OpponentController enemies;
PowerUpController powerUps;
ExplosionController explosions;
AlienController aliens;
LinkedList <PVector> stars;
float backgroundOffset;
float unit;
boolean mp;
PImage backgroundImage;

void setup(){
  // fullScreen(P2D);
  size(1000, 2000, P2D);
  ((PGraphicsOpenGL)g).textureSampling(2);
  orientation(PORTRAIT);
  imageMode(CENTER);
  rectMode(CORNERS);
  ellipseMode(RADIUS);
  frameRate(30);
  noStroke();
  fill(0);
  textSize(70);
  textAlign(LEFT, CENTER);
  // vibratorSetup();
    
  frameCount = 0;
  unit = width/6;
  scoreboard.score = 0;
  stars = new LinkedList<PVector>();
  mp = false;
  //backgroundImage = loadImage("background0"+((int)random(4)+1)+".png");
  backgroundImage = loadImage("background04.png");
  
  player = new Spacecraft(width/2, height-unit);
  projectiles = new BulletController();
  enemies = new OpponentController();
  powerUps = new PowerUpController();
  explosions = new ExplosionController();
  aliens = new AlienController();
  
  for(int i = 0; i < 50; i++){
    stars.add(new PVector(random(0, width), random(0, height)));
  }
  backgroundOffset = scoreboard.pos;
}

void draw(){
  if(player.isAlive()){
    background(0);
    if(frameCount % player.shootingFrequency == 0) player.shoot();
    if(frameCount % enemies.spawnSpeed == 0) enemies.shipWave();
    
    spaceBackground();
    
    projectiles.update();
    player.testIfHit();
    
    powerUps.move();
    powerUps.detonateBlasts();
    powerUps.display();
    
    enemies.update();
    
    explosions.display();
    aliens.display();
    
    player.display();
    player.displayHealth();
    
    topBar();
    scoreboard.display();
  }
  else scoreboard.mainScreen(); 
}

void spaceBackground(){
  backgroundOffset += height/130;
  if(backgroundOffset > height*2.5) backgroundOffset = -height/2;
  image(backgroundImage, width/2, backgroundOffset + height/2, width, height*3);
  if(backgroundOffset > height) image(backgroundImage, width/2, backgroundOffset - height*2.5, width, height*3);
  background(0,150);
  
  if(frameCount % 2 == 0){
    stars.add(new PVector(random(0, width), 0));
  }
  fill(255);
  for(PVector star: stars){
        ellipse(star.x, star.y, random(0,5), random(0,5));
  }
  while(stars.getLast().y > height){
    stars.removeLast();
  }
  /*
  for(int i = 0; i < stars.size(); i++){
    ellipse(stars.get(i).x, stars.get(i).y, random(0,5), random(0,5));
    stars.get(i).y += height/130;
    if(stars.get(i).y > height){
      stars.remove(i);
    }
  }
  */
}

void topBar(){
  pushStyle();
  fill(20);
  rect(0,0,width,unit);
  strokeWeight(8);
  stroke(150);
  line(0, unit, width, unit);
  popStyle();
}

void mousePressed(){
  if(player.hp <= 0) mp = true;
}

void mouseDragged(){
  if(player.isAlive()) player.move(mouseX-pmouseX, mouseY-pmouseY);
}

void mouseReleased(){
  if(player.hp <= 0 && mp) player.hp = 4;
}

void touchStarted(){
  /*if(touches.length == 2){
    //player.upgrade();
    scoreboard.score += 10;
  }*/
}

public enum Input{
  LEFT, RIGHT, UP, DOWN, SHOOT;

  public boolean isPressed(){
    switch(this){
      case LEFT:
        return key == 'a' || key == 'A' || key == CODED && keyCode == LEFT;
      case RIGHT:
        return key == 'd' || key == 'D' || key == CODED && keyCode == RIGHT;
      case UP:
        return key == 'w' || key == 'W' || key == CODED && keyCode == UP;
      case DOWN:
        return key == 's' || key == 'S' || key == CODED && keyCode == DOWN;
      case SHOOT:
        return key == ' ' || key == ' ' || key == CODED && keyCode == SHIFT;
      default:
        return false;
    }
  }

  public boolean isReleased(){
    switch(this){
      case LEFT:
        return key != 'a' && key != 'A' && key != CODED && keyCode != LEFT;
      case RIGHT:
        return key != 'd' && key != 'D' && key != CODED && keyCode != RIGHT;
      case UP:
        return key != 'w' && key != 'W' && key != CODED && keyCode != UP;
      case DOWN:
        return key != 's' && key != 'S' && key != CODED && keyCode != DOWN;
      case SHOOT:
        return key != ' ' && key != ' ' && key != CODED && keyCode != SHIFT;
      default:
        return false;
    }
  }
}

public class Window{
  public static final float WIDTH;
  public static final float HEIGHT;
  public static final float UNIT;
  public static final float CENTER_X;
  public static final float CENTER_Y;

  public Window(float width, float height){
    WIDTH = width;
    HEIGHT = height;
    UNIT = width/6;
    CENTER_X = width/2;
    CENTER_Y = height/2;
  }
}