
// THIS PROGRAM TAKES TIME TO LOAD WHEN IT STARTS! On the computers we used it varied between 11 and 13 seconds to load and display something on screen.

//Eligijus Skersonas - 10/03/2020
//Outlining the main program
//Edited by Eligijus Skersonas - 11/03/2020
//added screen 1 and setup screen 3 for Adam Mulvihill to work on
//Edited by Utkarsh gupta - 2/04/2020, added DateTime Formatter
Screen screen1, screen2, screen3, screen4, currentScreen;
import java.util.Date;
import java.text.SimpleDateFormat;
import java.text.ParseException; 
 import java.time.LocalDateTime; 
 import java.time.format.DateTimeFormatter;
 load lscreen;
PImage Symbol;
PImage message;
PImage version;
PImage names;

ArrayList stocks = new ArrayList<DataPoint>();
ArrayList exchanges = new ArrayList<DataPoint>();
int result = 0;
String currentDate;
NameTicker nameTicker = new NameTicker();
Price price = new Price();
boolean fromGreatestPrice;
DataPoint dataPoint = new DataPoint();
int count;
IndustrySector industrySector = new IndustrySector();
DateExchange dateExchange = new DateExchange();
float x;

void settings()
{
  size(1920,550);
  
}

void setup(){
Symbol=loadImage("n.png");
message=loadImage("stocks.jpg");
version=loadImage("version.jpg");
names=loadImage("names.jpg");

lscreen=new load(Symbol,message,names,version);

 count=0;
 x=850;
  try{
    
    
    dataPoint.read_in_the_file("daily_prices100k.csv");  // EDITED Adam Mulvihill - 20/03/2020 - changed file from daily_prices100k to daily_prices10k as the 100k version could not be found.
    dataPoint.read_in_the_file("stocks.csv");
    println(nameTicker.exchangeTicker.size());
    dateExchange.findUniqueDates();
    currentDate = dateExchange.getUniqueDate(0);
  //  println(dateExchange.uniqueDates.size()); //<>//
    price.initPercentArray();
    price.sortPercent();
    screen1 = new Screen();
    screen2 = new Screen("");
    screen3 = new Screen();
    screen4 = new Screen();
    currentScreen = screen1; //<>//
    fromGreatestPrice = false;
  }
  catch(Exception e)
  {
    println(e);
  }
}

// Edited Ralph Swords - 11/03/2020. Draws Screen 2
// Edited Eligijus Skersonas - 11/03/2020 Draws currentScreen
void draw()
{
   background(50); 
  if(count<300){
  lscreen.draw();
count++;
stroke(225,225,225);
line(850, 440, 1000, 440);
line(850, 441, 1000, 441);
line(850, 442, 1000, 442);
stroke(225,225,0);
line(850, 440, x, 440);
line(850, 441, x, 441);
line(850, 442, x, 442);

x=x+0.5;
} //<>//
  
  else {
  currentScreen.draw();} //<>//
  
}

//Edited Ralph Swords - 11/03/2020. Drags slider. 
//Edited Eligijus Skersonas - 11/03/2020 Drags slider of currentScreen
void mouseDragged()
{
  currentScreen.mouseDragged();
}

// Adam Mulvihill - 13/03/2020
// Allows the user to use the mouse wheel to scroll
void mouseWheel(MouseEvent event)
{
  currentScreen.mouseWheel(event);
}

void mousePressed()
{
  currentScreen.mousePressed();
}

void keyPressed()
{
  currentScreen.keyPressed();
} //<>//
