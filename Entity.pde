class Entity{
    float xCoordinate, yCoordinate;
    float xVelocity, yVelocity;
    float width, height;

    public Entity(float xCoordinate, float yCoordinate, float width, float height){
        this.xCoordinate = xCoordinate;
        this.yCoordinate = yCoordinate;
        this.width = width;
        this.height = height;
    }
    
    public void update(){
        xCoordinate += xVelocity;
        yCoordinate += yVelocity;
    }

    public void keepOnField(){
        xCoordinate = constrain(xCoordinate, 0, width);
    }
}