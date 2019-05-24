import java.util.*;
import processing.serial.*;
final int displayWidth =900;
final int displayHeight =504;
PImage bg;
PImage birb;
PImage pipe;
PImage pipeB;
PImage gameOver;
int pipeH;// -300 to -50
int gap = 500;
int clock = 0;
int dx = -5;
int dy = -10;
int mode =1; //0 for loading, 1 for game, 2 for game over
Sprite bird;
ArrayList<Sprite> images = new ArrayList<Sprite>();
Serial myPort;

boolean stop = false;
boolean jump = false;
void setup()
{
  size(displayWidth, displayHeight);

  bg =  loadImage("flappy background.png"); //load images
  birb =  loadImage("bird.png");
  pipe = loadImage("pipe.png");
  pipeB = loadImage("inverted_pipe.png");
  gameOver = loadImage("gameOver.png");
  bird = new Sprite(0, displayHeight/2, birb);
  images.add(bird);

  //String portName = Serial.list()[2];
  //myPort = new Serial(this, portName, 9600);
  //myPort.bufferUntil('\n');
}

void draw()
{
  if (mode == 1) {
    image(bg, 0, 0); //background
    addPipes();
    Iterator<Sprite> looper = images.iterator();
    while (looper.hasNext())
    {
      Sprite c = looper.next();
      if (!c.equals(bird))
      {
        if (c.x() < 0)
          looper.remove();
        else
        {
          c.move(dx, 0);
        }
      } else
      {
        if (jump)
        {
          c.move(0, dy);
        } else if (c.y() == displayHeight)
          mode = 2;
        else
          c.move(0, 2);
      }
      image(c.img(), c.x(), c.y());
    }
    clock++;
  }
  if (mode == 2)
  {
    image(gameOver, 0, 0);
  }
}
public void addPipes()
{
  if (clock %75 == 0) 
  {
    pipeH = int(random(-300, -50));
    images.add(new Sprite(800, pipeH, pipe));
    images.add(new Sprite(800, pipeH+gap, pipeB));
  }
}
void keyPressed()
{
  c.move(0,dy);
}
void serialEvent(Serial myPort)
{
  String myString = myPort.readStringUntil('\n');
  if (myString != null) {
    myString = myString.trim();
    int sensors[] = int(split(myString, ','));
    //println(myString.charAt(myString.length()-2));
    println(sensors);
    // add a linefeed at the end:
    println();
    // make sure you've got all three values:
    if (sensors.length > 1) {   
      if (sensors[0] == 0)
      {
        jump = true;
      }
      if (sensors[1] == 0)
      {
        stop = true;
      }
    }
  }
}
void loop()
{
  //serialEvent(myPort);
  jump = false;
  keyPressed();
}

class Sprite 
{
  private int x;
  private int y;
  private int l; //len
  private int h; //height for hitbox
  private PImage img; 

  public Sprite(int xpos, int ypos, PImage i)
  {
    x = xpos;
    y = ypos;
    img = i;
  }

  public int x()
  {
    return x;
  }
  public int l()
  {  
    return l;
  }
  public int h()
  {  
    return h;
  }
  public int y()
  {
    return y;
  }
  public PImage img()
  {
    return img;
  }

  public void move(int dx, int dy)
  {
    x+=dx;
    y+=dy;
  }

  public boolean equals(PImage other)
  {
    return img.equals(other);
  }
  /*
  public boolean collision(Sprite other)
   {
   if (other.x() < this.x+this.l)
   return true;
   if (this.y < other.y()+other.h())
   return true;
   if(other.y() < )
   return false;
   }*/
}
