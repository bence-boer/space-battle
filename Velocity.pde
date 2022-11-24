public static class Velocity extends PVector{  
  Velocity(float x, float y){
    super(x,y);
  }

  public void accelerate(float scalar){
    PVector acceleration = this.copy().normalize().mult(scalar);
    this.accelerate(acceleration.x, acceleration.y);
  }

  public void accelerate(float x, float y){
    this.x += x;
    this.y += y;
  }
  
  @Override
  public Velocity clone(){
    return new Velocity(this.x, this.y);
  }
  
  public static Velocity ZERO(){
    return new Velocity(0, 0);
  }
}
