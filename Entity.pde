class Entity{
    float xCoordinate, yCoordinate;
    float xVelocity, yVelocity;
    float width, height;

    public Entity(float xCoordinate, float yCoordinate){
      this.xCoordinate = xCoordinate;
      this.yCoordinate = yCoordinate;
    }
    public Entity(float xCoordinate, float yCoordinate, float xVelocity, float yVelocity){
        this(xCoordinate, yCoordinate);
        this.xVelocity = xVelocity;
        this.yVelocity = yVelocity;
        this.width = Window.UNIT;
        this.height = Window.UNIT;
    }
    
    public void update(){
        xCoordinate += xVelocity;
        yCoordinate += yVelocity;
    }
}
