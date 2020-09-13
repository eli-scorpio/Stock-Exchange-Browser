// Ralph Swords - 11/03/2020 created class

// Based on the widget class by Adam Mulvihill. This allows you to have 4 text strings on a widget instead of one.

//11/03/2020 Edited Eligijus Skersonas to accomodate 4/5 text strings depending on the currentScreen (screen1/screen2) 
//12/3/20 Edited Utkarsh Gupta to add linking Index to DataWidget to identify the Widget being clicked.
class DataWidget extends Widget
{

  String text2, text3, text4, text5;
  int linkingIndex;
  DataWidget(int px, int py, int pwidth, int pheight, String ptext1, String ptext2, String ptext3, String ptext4, 
    color pwidgetColour, color ptextColour, PFont pfont, int pevent, int arrayCount)
  {
    super(px, py, pwidth, pheight, ptext1, pwidgetColour, ptextColour, pfont, pevent);
    text2 = ptext2;
    text3 = ptext3;
    text4 = ptext4;
    linkingIndex=arrayCount;
  }

  //11/03/2020 Eligijus Skersonas - added a constructor with 5 text parameters
  DataWidget(int px, int py, int pwidth, int pheight, String ptext1, String ptext2, String ptext3, String ptext4, String ptext5, 
    color pwidgetColour, color ptextColour, PFont pfont, int pevent, int arrayCount)
  {
    super(px, py, pwidth, pheight, ptext1, pwidgetColour, ptextColour, pfont, pevent);
    text2 = ptext2;
    text3 = ptext3;
    text4 = ptext4;
    text5 = ptext5;
    linkingIndex=arrayCount;
  }
  void draw()
  {
    fill(super.widgetColour);
    if (mouseOverWidget(mouseX, mouseY)) stroke(255);

    else stroke(0);
    //  returnLinkedIndex(mouseX, mouseY);
    mousePressed(mouseX, mouseY);


    if (currentScreen == screen1) {                                                        //draw text for screen1
      rect(super.xpos, super.ypos, super.widgetWidth, super.widgetHeight);
      fill(super.textColour);
      textFont(super.widgetFont);
      text(super.widgetText, super.xpos + 10, super.ypos + super.widgetHeight - 10);
      text(text2, super.xpos + 110, super.ypos + super.widgetHeight - 10);
      text(text3, super.xpos + 240, super.ypos + super.widgetHeight - 10);
      text(text4, super.xpos + 800, super.ypos + super.widgetHeight - 10);
      text(text5, super.xpos + 1210, super.ypos + super.widgetHeight - 10);
    } else {                                                                            //draw text for screen3 and screen2
      if (currentScreen == screen4)
      {
        rect(super.xpos, super.ypos, super.widgetWidth, super.widgetHeight);            //edited by Utkarsh Gupta 26/03/20 to decrease the width of widget on screen 2 to make way for LineChart.
      } else
      {
        rect(super.xpos, super.ypos, super.widgetWidth, super.widgetHeight);  // Adam Mulvihill - 02/04/2020 - Moved the widget width decrease to initializeArrayList in Screen class. This fixed a bug where the widgets could be pressed even when clicking anywhere around the line chart.
      }
      fill(super.textColour);
      textFont(super.widgetFont);
      text(super.widgetText, super.xpos + 10, super.ypos + super.widgetHeight - 10);
      text(text2, super.xpos + 260, super.ypos + super.widgetHeight - 10);
      text(text3, super.xpos + 500, super.ypos + super.widgetHeight - 10);
      text(text4, super.xpos + 740, super.ypos + super.widgetHeight - 10);
    }
  }
  int getEvent()
  {
    return super.event;
  }
  int getEvent(int mX, int mY)
  {
    if (mX > super.xpos && mX < super.xpos+super.widgetWidth
      && mY > super.ypos && mY < super.ypos+super.widgetHeight)
    {
      return super.event;
    }
    return EVENT_NULL;
  }
  boolean mouseOverWidget(int mX, int mY)
  {                                     
    if (mX > super.xpos && mX < super.xpos+super.widgetWidth
      && mY > super.ypos && mY < super.ypos+super.widgetHeight)
    {

      return true;
    }
    return false;
  }
  //Edited by Ralph Swords 16/03/2020 - fixed bug where if you click anywhere on the screen the screen changed.
  //Edited Ralph Swords 01/04/2020 - added interactivity to data widgets on greatest change in price screen, where is you click on a stock, it brings you to the screen that shows the bar chart onto the stock
  void mousePressed(int mX, int mY)// code by Utkarsh Gupta  12/3/20  ------ Edited by Eligijus and Ralph 12/03/2020
  {                                     // linked screen 1 to screen 2----------linked screen 2 to 3
    if (mX > super.xpos && mX < super.xpos+super.widgetWidth
      && mY > super.ypos && mY < super.ypos+super.widgetHeight)
    {
      if ((currentScreen==screen1 && mousePressed) && currentScreen.sectorDropBox.inUse != true && currentScreen.industryDropBox.inUse != true) { 
        result = linkingIndex;
        currentScreen = screen2;
        currentScreen.setStocksToDisplay();                             // EDITED Adam Mulvihill - 20/03/2020 - Changed the way this method is called such that it is only called once when an exchange is clicked.
        currentScreen.initializeArrayList(currentScreen.widgets, 0);    // Initializes the new screen.

        currentScreen.linechart.prices.clear();    // Adam Mulvihill - 29/03/2020 - Changed where these methods are called to here, such that the values and maxX and maxY are set only once when an exchange is clicked.
        currentScreen.linechart.date.clear();
        try
        {
          currentScreen.linechart.setValues();
        }
        catch(Exception e)
        {
          println(e);
        }
        currentScreen.linechart.setToDefault();  // Adam Mulvihill - 02/04/2020 - Brought setMaxX and setMaxY into setToDefault.
      } else if (currentScreen == screen2 && mousePressed /*&& currentScreen.dropBox.inUse != true*/) {  // Adam Mulvihill - 29/03/2020 - Temporarily removed the dropBox condition to fix a nullpointer exception.

        currentScreen = screen3;
        currentScreen.stockIndexes = screen2.stockIndexes;
        currentScreen.barChart.resetChart();  // Adam Mulvihill - 22/03/2020 - resets the values on the bar chart. fixed a problem where it would only display the data from the stock first pressed.
        result = linkingIndex;        //added by Eligijus Skersonas 17/03/2020
      } else if (currentScreen == screen4 && mousePressed) {  // Adam Mulvihill - 29/03/2020 - Temporarily removed the dropBox condition to fix a nullpointer exception.

        currentScreen = screen3;
        getScreen4StockIndexes();
        currentScreen.barChart.resetChart();  // Adam Mulvihill - 22/03/2020 - resets the values on the bar chart. fixed a problem where it would only display the data from the stock first pressed.
        result = linkingIndex;        //added by Eligijus Skersonas 17/03/2020
      }
      mousePressed = false;
    }
  }
  void getScreen4StockIndexes()
  {
    currentScreen.stockIndexes.clear();                          //Edited Ralph Swords 01/04/2020 - fixed bug where if you got to the bar chart from screen 2, and then go to the bar chart from screen 4, the wrong bar chart would show
    for (int index = 0; index < nameTicker.ticker.size(); index++)
    {
      currentScreen.stockIndexes.add(index);
    }
  }
}
