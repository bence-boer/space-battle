import java.util.LinkedList;

Spacecraft player;
Scoreboard scoreboard = new Scoreboard();
BulletController projectiles;
OpponentController enemies;
PowerUpController powerUps;
ExplosionController explosions;
AlienController aliens;
LinkedList <PVector> stars;
float bgPos;
float unit;
boolean mp;
PImage bg;

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
  //bg = loadImage("background0"+((int)random(4)+1)+".png");
  bg = loadImage("background04.png");
  
  player = new Spacecraft(width/2, height-unit);
  projectiles = new BulletController();
  enemies = new OpponentController();
  powerUps = new PowerUpController();
  explosions = new ExplosionController();
  aliens = new AlienController();
  
  for(int i = 0; i < 50; i++){
    stars.add(new PVector(random(0, width), random(0, height)));
  }
  bgPos = scoreboard.pos;
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
  bgPos += height/130;
  if(bgPos > height*2.5) bgPos = -height/2;
  image(bg, width/2, bgPos + height/2, width, height*3);
  if(bgPos > height) image(bg, width/2, bgPos - height*2.5, width, height*3);
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
