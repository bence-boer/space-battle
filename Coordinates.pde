public class Coordinates extends PVector{
  Coordinates(float x, float y){
    super(x,y);
  }
  
  @Override
  public Coordinates clone(){
    return new Coordinate(this.x, this.y);
  }
  
  public Coordinates add(Velocity velocity){
    this.x += velocity.x;
    this.y += velocity.y;
    return this;
  }
}
