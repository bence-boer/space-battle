public class Entity{
    public Coordinates coordinates;
    public Velocity velocity;
    public float width, height;

    private DisplayOrigin displayOrigin;

    public Entity(Coordinates coordinates){
      this.coordinates = coordinates.copy();
      this.velocity = Velocity.ZERO();
      
      this.width = Window.UNIT;
      this.height = Window.UNIT;
    }
    public Entity(Coordinates coordinates, Velocity velocity){
        this(coordinates);
        this.velocity = velocity.copy();
    }
    
    public void update(){
        coordinates.add(velocity);
    }

    public boolean isOffWindow(){
        return switch (displayOrigin){
            case DisplayOrigin.BOTTOM_LEFT -> 
                (coordinates.x > Window.WIDTH ||
                 coordinates.x + this.width < 0 ||
                 coordinates.y < 0 ||
                 coordinates.y - this.height > Window.HEIGHT);
            case DisplayOrigin.CENTER -> 
                (coordinates.x + this.width / 2 > Window.WIDTH ||
                 coordinates.x - this.width / 2 < 0 ||
                 coordinates.y + this.height / 2 > Window.HEIGHT ||
                 coordinates.y - this.height / 2 < 0);
        }
    }
}

public enum DisplayOrigin{
    BOTTOM_LEFT,
    CENTER
}