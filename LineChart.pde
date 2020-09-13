//Utkarsh Gupta 26/3/20 created class -  LineChart class to draw the changes in price over time on screen 2.

// Adam Mulvihill - 30/03/2020 - No code changed. Cleaned up the code a bit (mainly indentation).
////Utkarsh Gupta 9/4/20 .Fixed a bug in x axis which made it to change after back was prssed.Also made a diffrent axis for week button.
class LineChart {
  // Adam Mulvihill - 02/04/2020 - Added constants for the time period button events.
  final int ALL_BUTTON = 1;
  final int YEAR_BUTTON = 2;
  final int SIX_MONTH_B = 3;
  final int THREE_MONTH_B = 4;
  final int MONTH_BUTTON = 5;
  final int WEEK_BUTTON = 6;
  // Adam Mulvihill - 02/04/2020 - Constants representing each time period in milliseconds.
  final long YEAR = (long) 365*24*60*60*1000;
  final long MONTH = (long) 31*24*60*60*1000;
  final long WEEK = (long) 7*24*60*60*1000;
  int axis;
PFont hoverFont;
  ArrayList<Float> prices = new ArrayList<Float>();  // Adam Mulvihill - 29/03/2020 - changed from an Integer arrayList to a Float arrayList.
  ArrayList<Date> date = new ArrayList<Date>();  // Adam Mulvihill - 29/03/2020 - changed from an Integer arrayList to a Date arrayList.
  float maxYScalePos;
  float maxXScalePos;
  PShape rectangle;//Shape to draw the chart on.
  float maxY;// maximum value of prices
  long maxX; // Adam Mulvihill - 02/04/2020 - Changed from a float to a long to avoid problems since the getTime function of Date returns a time in milliseconds.
  PFont font;
  PFont font1;
  //float maxPrice;  // Adam Mulvihill - 29/03/2020 - removed as the variable was only used once in the code, and represented the same thing as maxY.

  long minX;  // Adam Mulvihill - 02/04/2020 - added this variable to store the earliest date for the graph under the current time period given for the graph.
  ArrayList<Widget> widgets;  // Adam Mulvihill - 02/04/2020 - Added an array list of widgets that allows the user to select a time period for the graph
  int firstDateIndex;


  LineChart() {
    axis=0;
    size(1920, 550);
    smooth(); // for smoothing the Chart.
    font = loadFont("Calibri-18.vlw");
    maxYScalePos=65;
    hoverFont = loadFont("Calibri-Bold-18.vlw"); 
    // Adam Mulvihill - 02/04/2020 - Added widgets to allow a time period to be defined for the line chart.
    widgets = new ArrayList<Widget>();
    widgets.add(new Widget(1300, 510, 90, 30, "All time", color(50), color(250, 181, 52), font, ALL_BUTTON));  //all time
    widgets.add(new Widget(1300+(1*90), 510, 90, 30, "1 year", color(50), color(250, 181, 52), font, YEAR_BUTTON));  //year
    widgets.add(new Widget(1300+(2*90), 510, 90, 30, "6 months", color(50), color(250, 181, 52), font, SIX_MONTH_B));  //6 months
    widgets.add(new Widget(1300+(3*90), 510, 90, 30, "3 months", color(50), color(250, 181, 52), font, THREE_MONTH_B));  //3 months
    widgets.add(new Widget(1300+(4*90), 510, 90, 30, "1 month", color(50), color(250, 181, 52), font, MONTH_BUTTON));  //month
    widgets.add(new Widget(1300+(5*90), 510, 90, 30, "1 week", color(50), color(250, 181, 52), font, WEEK_BUTTON));  //week
    maxX=330;
    maxY=220;
  }

  void draw() {  // Adam Mulvihill - 29/03/2020 - Changed the draw method to use the data from the stocks. The dates' x positions are measured relative to the oldest date rather than their actual value.
    if (date.size() > 0)  // Adam Mulvihill - 06/04/2020 - Added a condition such that the chart will only draw if there is data. only one of the arrays needs to be checked.
    {
      background(50);
      rectangle = createShape(RECT, 0, 0, 400, 400);
      rectangle.setFill(255);
      shape(rectangle, 1360, 50);//Fixing a rectangle of size 400, 400.
      SetYaxis();
      SetXaxis();

      // Adam Mulvihill - 02/04/2020 - Changed the loop such that it will only start from the first date within the time period.
      if (maxX-date.get(firstDateIndex).getTime() != 0)  // Adam Mulvihill - 06/04/2020 - Added a condition in case of a division by 0
      {
        float y;
        float x;
        for (int i=firstDateIndex; i<prices.size(); i++) {
         if(i<prices.size()-1){
          y=((prices.get(i+1))/maxY)*400;//getting the next price and resizing it to fit on a 400 x 400 chart.
          x=((date.get(i+1).getTime()-date.get(firstDateIndex).getTime())/((float)maxX-date.get(firstDateIndex).getTime()))*400;//getting the next date and resizing it to fit on a 400 x 400 chart.
         }else{
          y=((prices.get(i))/maxY)*400;//getting the next price and resizing it to fit on a 400 x 400 chart.
          x=((date.get(i).getTime()-date.get(firstDateIndex).getTime())/((float)maxX-date.get(firstDateIndex).getTime()))*400;//getting the next date and resizing it to fit on a 400 x 400 chart.
         }
          float y1=(prices.get(i)/maxY)*400;
          float x1=((date.get(i).getTime()-date.get(firstDateIndex).getTime())/((float)maxX-date.get(firstDateIndex).getTime()))*400;
          if (x>0&&y>0) {
            line(x1+1360, 450-y1, x+1360, 450-y);// drawing the line chart from current date to next date.
            float price=prices.get(i);
          if(((date.size()-firstDateIndex)/10)==0){
         println(date.get(i));
          printDate(date.get(i),((int)x1+1360));}
             mouseOver(((int)(x1+1360)),((int)( 450-y1 )),(price),i);
            fill(225, 100, 0);
          }
          textFont(hoverFont);
          text("Price of stocks over time", 1470, 30);
        }
      } 
      else
      {
        println("Division by 0. Press another button.");
      }
      for (int i = 0; i < widgets.size(); i++)//Drawing the time choosing Widgets below the graph.
      {
        widgets.get(i).draw();
      }
    }
  }

  // Adam Mulvihill - 29/03/2020 - Changed the method to get the data from the stocks. Gets the prices and dates for the current ticker. 
  void setValues() throws Exception
  {
    for (int i = 0; i < currentScreen.stockIndexes.size(); i++)  // Add prices
    {
      prices.add(Float.parseFloat((String)price.adjustedClose.get((Integer)currentScreen.stockIndexes.get(i))));//Changing String to float for the prices.
    }
    // Idea bellow came from Ralph Sword's code in DateExchange.mostRecentDate().
    String tempDate;
    SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
    for (int i = 0; i < currentScreen.stockIndexes.size(); i++)  // Add prices
    {
      tempDate = (String)dateExchange.date.get((Integer)currentScreen.stockIndexes.get(i));
      date.add(dateFormat.parse(tempDate));
    }
  }

  void SetXaxis() {
    for (int i = 0; i < 10; i++) {
      text(maxY - (maxY/10)*i, 1280, maxYScalePos + 39*i);
    }//Setting the prices on the y axis with equal spacing.
    //  text(0, 735, maxYScalePos + 39*10);


   /* if (((date.size()-firstDateIndex)/10)==0) {
      for (int i = 1156; i >= 760; i -= 56) {
        text("|", i+600, 463); //setting the markers for the x axis.
      }
    }*/
    if (((date.size()-firstDateIndex)/10)>0) {
      for (int i = 1150; i >= 760; i -= 39) {
        text("|", i+600, 463); //setting the markers for the x axis.
      }
    }
  }

  void SetYaxis() {//Edited by Utkarsh Gupta 02/04/20, Formatted the date to YYYY format, converted date object to String and displayed the output;
    maxXScalePos=1394;
   
    axis=(date.size()-firstDateIndex)/10;//diving the dates into a group of 10 to sho them on the axis;  // TODO: pressing the week button can cause this line to return a number less than 1, which stores 0 since it is an int. program never exits the following for loop.
    int loopcount=11;//variable to account for even numbers on the x axis in which case one date is out of axis.
    int spacing=39;
    float position=9;// position for spacing of the output dates.
    if (axis==0) {//if one week is selected
      axis=1;     //decrese dates by one
      position=9; //change axis variables to fit 7 values
      maxXScalePos=1500;
      spacing=28;
    }
    for (float i = date.size()-1; i >= firstDateIndex; i=i-axis) { //variable to account for even numbers on the x axis in which case one date is out of axis.
      loopcount--;
      if (loopcount==0) {
        i=firstDateIndex;
      }
      int p= (int)i;//changing i float to int for using it with date formatter.
      //  println(date.get(p));
      SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MMM-dd HH:mm:ss");//FORMATTING THE DATE to yyyy-MMM-dd HH:mm:ss format.
      String s = formatter.format(date.get(p));//changing date object to a String Variable
      if (((date.size()-firstDateIndex)/10)>0) {//printing year and month for month buttons.
        DateTimeFormatter oldPattern = DateTimeFormatter.ofPattern("yyyy-MMM-dd HH:mm:ss");//Now taking the String output and further foatting it to fitt to our graph.
        DateTimeFormatter newPattern = DateTimeFormatter.ofPattern("yyyy"); 
        DateTimeFormatter newPattern1 = DateTimeFormatter.ofPattern("MMM"); 
        LocalDateTime datetime = LocalDateTime.parse(s, oldPattern); 
        String output = datetime.format(newPattern);//String variable for year
        String output1 = datetime.format(newPattern1);//String variable for month
        text((output), maxXScalePos +spacing*position, 480);//printing the year onto the x axis and then the month beow it.
        text((output1), maxXScalePos +spacing*position, 500);
      } 
   /*   else if (((date.size()-firstDateIndex)/10)>0) {//printing dates and month for week button.
        DateTimeFormatter oldPattern = DateTimeFormatter.ofPattern("yyyy-MMM-dd HH:mm:ss");//Now taking the String output and further foatting it to fitt to our graph.
        DateTimeFormatter newPattern = DateTimeFormatter.ofPattern("MMM"); 
        DateTimeFormatter newPattern1 = DateTimeFormatter.ofPattern("dd"); 
        LocalDateTime datetime = LocalDateTime.parse(s, oldPattern); 
        String output = datetime.format(newPattern);//String variable for year
        String output1 = datetime.format(newPattern1);//String variable for month
        
        
        text((output), maxXScalePos +spacing*position, 480);//printing the year onto the x axis and then the month or date beow it.
       
        text((output1), maxXScalePos +spacing*position, 500);
        
    
    }*/
      position--;
     /* if (((date.size()-firstDateIndex)/10)==0) {
        position--;
      }*/
    }     
    for (int i = 447; i >= 50; i -= 39) {
      text("_", 1352, i);//printing markers for y axis.
    }
  }
  
  // Method to search the line chart's instance copy of the price data and find the greatest value. Returns the greatest value as a float.
  float setMaxY() {// Utkarsh Gupta 26/03/20 made method to select the highest price.
    float maxPrice = 0;
    for (int i=0; i<prices.size(); i++) {
      float p= prices.get(i);  // Adam Mulvihill - 02/04/2020 - Changed this such that it searched its own local copy of prices. makes it easier to adapt to a selected time period.
      if (p>maxPrice) //if price is greater than current price
      {
        maxPrice=p;//price=max price
      }
    }
    return maxPrice;
  }

  // Method to search the line chart's instance copy of the price data and find the greatest value. Returns the greatest value as a float. This method takes an index to start searching from, skipping over all lower indexes.
  float setMaxY(int ind) {  // Adam Mulvihill - 02/04/2020 - variation of Utkarsh's above method that allows a starting index to be specified.
    if (ind < prices.size())
    {
      float maxPrice = 0;
      for (int i=ind; i<prices.size(); i++) {
        float p= prices.get(i);
        if (p>maxPrice) {
          maxPrice=p;
        }
      }
      return maxPrice;
    } else
    {
      throw new IllegalArgumentException();
    }
  }

  // Method to search the line chart's instance copy of the date data and find the most recent date. Returns the date represented as a long in milliseconds since January 1st, 1970, 00:00:00 GMT (Information on this way of storing dates found at https://docs.oracle.com/javase/8/docs/api/java/util/Date.html).
  // Adam Mulvihill - 29/03/2020 - Changed the method to get the most recent date relative to the oldest date (that is mostRecent - oldest).
  // Adam Mulvihill - 02/04/2020 - Changed it such as to use the actual time returned from getTime().
  long setMaxX() {
    long mostRecentDate = 0;
    long tempDate = 0;
    for (int i=0; i<date.size(); i++) {
      tempDate = date.get(i).getTime();
      if (tempDate > mostRecentDate) mostRecentDate = tempDate;
    }
    return mostRecentDate;
  }

  // Adam Mulvihill - 02/04/2020 - Added a method to handle input involving the buttons for the time period.
  // Adam Mulvihill - 06/04/2020 - Changed the method such that the data is only refreshed and the for loops run when a button is pressed. Added many printlns to help with debugging. Week button is commented out temporarily as it produces a bug causing the program to crash when pressed. See TODO comment in SetYaxis
  void mousePressed()
  {
    for (int i = 0; i < widgets.size(); i++)
    {
      int event = widgets.get(i).getEvent(mouseX, mouseY);
      switch(event)
      {
      case ALL_BUTTON:
        minX = date.get(0).getTime();
        for (int i2 = date.size()-1; i2 >= 0; i2--)  // This for loop is in each case. It goes through the date arraylist from its end to index 0, and sets the firstIndex to be used for drawing the chart to the date closest to the limit given in minX (aka if the date is smaller than minX, it should not be included.)
        {
          if (date.get(i2).getTime() >= minX) firstDateIndex = i2;
        }
        if (firstDateIndex < prices.size() && firstDateIndex >= 0)
        {
          maxY = setMaxY(firstDateIndex);
        } else
        {
          maxY = setMaxY();
        }

        break;
      case YEAR_BUTTON:
        minX = maxX - YEAR;
        for (int i2 = date.size()-1; i2 >= 0; i2--)
        {
          if (date.get(i2).getTime() >= minX) firstDateIndex = i2;
        }
        if (firstDateIndex < prices.size() && firstDateIndex >= 0)
        {
          maxY = setMaxY(firstDateIndex);
        } else
        {
          maxY = setMaxY();
        }

        break;
      case SIX_MONTH_B:
        minX = maxX - (long) 6*MONTH;
        for (int i2 = date.size()-1; i2 >= 0; i2--)
        {
          if (date.get(i2).getTime() >= minX) firstDateIndex = i2;
        }
        if (firstDateIndex < prices.size() && firstDateIndex >= 0)
        {
          maxY = setMaxY(firstDateIndex);
        } else
        {
          maxY = setMaxY();
        }

        break;
      case THREE_MONTH_B:
        minX = maxX - (long) 3*MONTH;
        for (int i2 = date.size()-1; i2 >= 0; i2--)
        {
          if (date.get(i2).getTime() >= minX) firstDateIndex = i2;
        }
        if (firstDateIndex < prices.size() && firstDateIndex >= 0)
        {
          maxY = setMaxY(firstDateIndex);
        } else
        {
          maxY = setMaxY();
        }

        break;
      case MONTH_BUTTON:
        minX = maxX - MONTH;
        for (int i2 = date.size()-1; i2 >= 0; i2--)
        {
          if (date.get(i2).getTime() >= minX) firstDateIndex = i2;
        }
        if (firstDateIndex < prices.size() && firstDateIndex >= 0)
        {
          maxY = setMaxY(firstDateIndex);
        } else
        {
          maxY = setMaxY();
        }

        break;



      case WEEK_BUTTON:
        minX = maxX - WEEK;
        for (int i2 = date.size()-1; i2 >= 0; i2--)
        {
          if (date.get(i2).getTime() >= minX) firstDateIndex = i2;
        }
        if (firstDateIndex < prices.size() && firstDateIndex >= 0)
        {
          maxY = setMaxY(firstDateIndex);
        } else
        {
          maxY = setMaxY();
        }
        break;
      default:
      }
    }
  }

  // Adam Mulvihill - 02/04/2020 - sets the line chart to its default state of displaying data of the past 3 months.
  // Adam Mulvihill - 06/04/2020 - Added a condition for setting maxY, that deals with an IllegalArgumentException that was being produced when entering exchanges with no stocks.
  void setToDefault()
  {
    maxX = setMaxX();
    minX = maxX - (long) 3*MONTH;
    for (int i = date.size()-1; i >= 0; i--)
    {
      if (date.get(i).getTime() > minX) firstDateIndex = i;
    }
    if (firstDateIndex < prices.size() && firstDateIndex >= 0)
    {
      maxY = setMaxY(firstDateIndex);
    } else
    {
      maxY = setMaxY();
    }
  }
void mouseOver(int x,int y, float x1, int p){
if(x==mouseX&&mouseX>=1360&&mouseX<1729&&mouseY<=450&&mouseY>=50 ){
textFont(hoverFont); 
 
  text(x1, x+10,y+10);
println(mouseX);
SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MMM-dd HH:mm:ss");//FORMATTING THE DATE to yyyy-MMM-dd HH:mm:ss format.
     String s = formatter.format(date.get(p));//changing date object to a String Variable
      //printing year and month for month buttons.
        DateTimeFormatter oldPattern = DateTimeFormatter.ofPattern("yyyy-MMM-dd HH:mm:ss");//Now taking the String output and further foatting it to fitt to our graph.
        DateTimeFormatter newPattern = DateTimeFormatter.ofPattern("yyyy-MMM-dd"); 
        LocalDateTime datetime = LocalDateTime.parse(s, oldPattern); 
        String output = datetime.format(newPattern);//String variable for year
       textFont(hoverFont); 
        text((output),x+80, y+10);//printing the year onto the x axis and then the month beow it.
}
else if((x==mouseX||(mouseX>x-5&&mouseX<=x))&&mouseX>1729&&mouseX<1760&&mouseY<=450&&mouseY>=50 ){
textFont(hoverFont); 
 
  text(x1, x-30,y+10);

SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MMM-dd HH:mm:ss");//FORMATTING THE DATE to yyyy-MMM-dd HH:mm:ss format.
     String s = formatter.format(date.get(p));//changing date object to a String Variable
      //printing year and month for month buttons.
        DateTimeFormatter oldPattern = DateTimeFormatter.ofPattern("yyyy-MMM-dd HH:mm:ss");//Now taking the String output and further foatting it to fitt to our graph.
        DateTimeFormatter newPattern = DateTimeFormatter.ofPattern("yyyy-MMM-dd"); 
        LocalDateTime datetime = LocalDateTime.parse(s, oldPattern); 
        String output = datetime.format(newPattern);//String variable for year
       textFont(hoverFont); 
        text((output),x+40, y+10);//printing the year onto the x axis and then the month beow it.
}
}

/*
 DateTimeFormatter oldPattern = DateTimeFormatter.ofPattern("yyyy-MMM-dd HH:mm:ss");//Now taking the String output and further foatting it to fitt to our graph.
        DateTimeFormatter newPattern = DateTimeFormatter.ofPattern("MMM"); 
        DateTimeFormatter newPattern1 = DateTimeFormatter.ofPattern("dd"); 
        LocalDateTime datetime = LocalDateTime.parse(s, oldPattern); 
        String output = datetime.format(newPattern);//String variable for year
        String output1 = datetime.format(newPattern1);//String variable for month
        text((output), maxXScalePos +spacing*position, 480);//printing the year onto the x axis and then the month or date beow it.
        text((output1), maxXScalePos +spacing*position, 500);
*/

void printDate(Date date,int x){
SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MMM-dd HH:mm:ss");//FORMATTING THE DATE to yyyy-MMM-dd HH:mm:ss format.
     String s = formatter.format(date);//changing date object to a String Variable
      //printing year and month for month buttons.
        DateTimeFormatter oldPattern = DateTimeFormatter.ofPattern("yyyy-MMM-dd HH:mm:ss");//Now taking the String output and further foatting it to fitt to our graph.
        DateTimeFormatter newPattern = DateTimeFormatter.ofPattern("MMM"); 
        DateTimeFormatter newPattern1 = DateTimeFormatter.ofPattern("dd"); 
        LocalDateTime datetime = LocalDateTime.parse(s, oldPattern); 
        String output = datetime.format(newPattern);//String variable for year
        String output1 = datetime.format(newPattern1);//String variable for month
        
        fill(225, 100, 0);
        text("|", x, 463);
       textFont(font);
        fill(225, 100, 0);
        text((output),x, 480);
       textFont(font);
         fill(225, 100, 0);
        text((output1),x,500);
}
}
