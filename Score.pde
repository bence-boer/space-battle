class Scoreboard{
  LinkedList <Integer> scoreList;
  int score;
  int highscore;
  float offset;
  
  Scoreboard(){
    scoreList = new LinkedList<Integer>();
    offset = 0;
  }
  
  void display(){
    textSize(unit/2);
    fill(255);
    text("Score : " + score, unit/4, unit/2);
  }
  
  void mainScreen(){
    background(20);
    
    fill(255);
    text("Tap to play", width/3, height-unit);
    textSize(unit/2);
    if(scoreList.size() != 0) text("SCOREBOARD", width/10, unit);
    else image(player.ship, width/2, height/2, width*0.7, width*0.7);
    textSize(unit/3);
    for(int i = 0; i < scoreList.size(); i++){
      if(i < 9) text("Game #0" + (i+1) + "                            " + scoreList.get(i), width/10, unit*2 + unit/3*i);
      else text("Game #" + (i+1) + "                            " + scoreList.get(i), width/10, unit*2 + unit/3*i);
    }
  }
  
  void scored(){
    score++;
    if(score % 20 == 0) powerUps.dropPowerUp();
    if(score % 10 == 0) aliens.addAlien(new PVector(-unit, height-unit));
    if(score % 100 == 0){
      enemies.spawnSpeed += 3;
      enemies.health+=2;
    }
    else if(score % 25 == 0) enemies.spawnSpeed--;
  }
}