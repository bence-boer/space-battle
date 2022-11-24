public enum Input{
  LEFT_KEY, RIGHT_KEY, UP_KEY, DOWN_KEY, SHOOT;

  public boolean isPressed(int key, int keyCode){
    switch(this){
      case LEFT_KEY:
        return key == 'a' || key == 'A' || key == CODED && keyCode == LEFT;
      case RIGHT_KEY:
        return key == 'd' || key == 'D' || key == CODED && keyCode == RIGHT;
      case UP_KEY:
        return key == 'w' || key == 'W' || key == CODED && keyCode == UP;
      case DOWN_KEY:
        return key == 's' || key == 'S' || key == CODED && keyCode == DOWN;
      case SHOOT:
        return key == ' ' || key == ' ' || key == CODED && keyCode == SHIFT;
      default:
        return false;
    }
  }

  public boolean isReleased(int key, int keyCode){
    switch(this){
      case LEFT_KEY:
        return key != 'a' && key != 'A' && key != CODED && keyCode != LEFT;
      case RIGHT_KEY:
        return key != 'd' && key != 'D' && key != CODED && keyCode != RIGHT;
      case UP_KEY:
        return key != 'w' && key != 'W' && key != CODED && keyCode != UP;
      case DOWN_KEY:
        return key != 's' && key != 'S' && key != CODED && keyCode != DOWN;
      case SHOOT:
        return key != ' ' && key != ' ' && key != CODED && keyCode != SHIFT;
      default:
        return false;
    }
  }
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
