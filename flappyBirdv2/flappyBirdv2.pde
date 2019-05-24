import java.util.*;
import processing.serial.*;

final int displayWidth =900;
final int displayHeight =504;
ArrayList<Sprite> obj = new ArrayList<Sprite>();

void setup()
{
  size(displayWidth, displayHeight);
}
void draw()
{
  /*
  get user input
  for each object:
    update object state
  update game state (if bird crashed or whatever)
  for each object:
    paint on the screen
  update end of turn vars (clock)
  */
  
}
void loop()
{
  keyPressed();
}
void keyPressed()
{
  text("hi",displayWidth/2,displayHeight/2);
}
class Env
{
  public int mode; // 0 for title screen 1 for playing screen 2 for game over
  public int clock;
  Sprite[] bg;
  public ArrayList<Sprite> sprites;
  Bird b;
  
  public Env()
  {
    mode = 0;
    clock = 0;
    bg = new PImage[3];
    bg[0] = new Sprite(0, 0, loadImage("Images/finaltitle.png"));
    bg[1] = new Sprite(0, 0, loadImage("Images/flappy background.png"));
    bg[2] = new Sprite(0, 0, loadImage("Images/gameOver.png"));
    sprites = new ArrayList<Sprite>();
    sprites.add(bg[0]);
    b = new Bird(0, displayHeight/2);
    sprites.add(b);
  }
}
class Pipe extends Sprite
{
  public int vx = -5;
  public int vy = 0;
  public PImage pipe_b = loadImage("Images/finverted_pipe.png");
  public PImage pipe =   loadImage("Images/fpipe.png");
  public int gap = 500;
  public Pipe()
  {
    x = 800;
    y = int(random(-300,-50));
  }
  
  void turn()
  { 
    move(vx,vy);
  }
}

class Bird extends Sprite
{
  public int vx = 0;
  public int vy;
  public int ay = -10;
  public Bird(int xPos, int  yPos)
  {
    x = xPos;
    y = yPos;
    img =  loadImage("bird.png");
    w = img.width;
    h =img.height;
  }
}

class Sprite 
{
  public int x;
  public int y;
  public int w; //len
  public int h; //height for hitbox
  public PImage img; 

  public Sprite(int xpos, int ypos, PImage i)
  {
    x = xpos;
    y = ypos;
    img = i;
    h = i.height;
    w = i.width;
  }
  public Sprite()
  {
    x = 0;
    y = 0;
    img = null;
    w = 0;
    h = 0;
  }
  public void move(int dx, int dy)
  {
    x+=dx;
    y+=dy;
  }
  public void setPos(int newX, int newY)
  {
    x = newX;
    y = newY;
  }

  public boolean equals(PImage other)
  {
    return img.equals(other);
  }

  public boolean collision(Sprite other)
  {
    if (other.x < this.x+this.w && other.x > this.x)
      return true;

    if (other.y < this.y+this.h && other.y> this.y)
      return true;
    return false;
  }
}
