import java.util.*;
import processing.serial.*;

final int displayWidth =900;
final int displayHeight =504;
Env env;
boolean start;
boolean jump;
void setup()
{
  size(displayWidth, displayHeight);
  env = new Env();
  start = false;
  jump = false;
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
  jump = false;
  start = false;
  for (Sprite s : env.sprites)
  {
     image(s.img,s.x,s.y);
  }
  env.update();
}
void loop()
{
  if (env.bg[0] == env.sprites.get(0) && keyPressed)
    start = true;
}

void mouseClicked()
{
  start = true;
}
void keyPressed()
{
  jump = true;
}
class Env
{
  public int mode; // 0 for title screen 1 for playing screen 2 for game over
  public int clock;
  Sprite[] bg;
  public ArrayList<Sprite> sprites;
  public Bird b;
  boolean done;
  public Env()
  {
    mode = 0;
    clock = 0;
    bg = new Sprite[3];
    bg[0] = new Sprite(0, 0, loadImage("Images/finaltitle.png"));
    bg[1] = new Sprite(0, 0, loadImage("Images/flappy background.png"));
    bg[2] = new Sprite(0, 0, loadImage("Images/gameOver.png"));
    sprites = new ArrayList<Sprite>();
    sprites.add(bg[0]); // first array slot will be game mode ex: title screen
    b = new Bird(0, displayHeight/2);
    sprites.add(b);
  }
  public void genPipe()
  {
    if (clock % 75 == 0)
      sprites.add(new Pipe());
  }
  public void remPipe()
  {
    Iterator<Sprite> looper = sprites.iterator();
    while (looper.hasNext())
    {
      Sprite cur = looper.next();
      if (cur.x < 0)
        looper.remove();
    }
  }
  public void update()
  {
    for (Sprite s : sprites)
    {
      s.turn();
    }
    if (start && sprites.get(0) == bg[0])
      sprites.set(0, bg[1]);
    if (!start && sprites.get(0) == bg[2])
      sprites.set(0, bg[0]);
    if (done)
      sprites.set(0, bg[2]);
    genPipe();
    remPipe();
    clock++;
  }
}
class Pipe extends Sprite
{
  public int vx = -5;
  public int vy = 0;
  public PImage pipe_b = loadImage("Images/inverted_pipe.png");
  public PImage pipe =   loadImage("Images/pipe.png");
  public int gap = 500;
  public Pipe()
  {
    x = 800;
    y = int(random(-300, -50));
  }

  void turn()
  { 
    move(vx, vy);
  }
}

class Bird extends Sprite
{
  public int vx = 0;
  public int vy = 0;
  public int ay = -2;
  public Bird(int xPos, int  yPos)
  {
    x = xPos;
    y = yPos;
    img =  loadImage("Images/bird.png");
    w = img.width;
    h =img.height;
  }
  void turn()
  {
    move(vx, vy);
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
  void turn()
  {
    move(0, 0);
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
