// Ralph Swords - 11/03/2020 created class
// Draws a screen that shows all the data. Screen uses a slider that allows you to scroll through the data
//Edited Eligijus Skersonas 11/03/2020 added code to make widgets for screen 1 and screen 3
// EDITED Adam Mulvihill - 17/03/2020 - ?
class Screen
{
  ScrollBar slider, slider2, slider3, slider4;
  SearchBar searchBar;
  ArrayList widgets = new ArrayList<DataWidget>();
  ArrayList dateWidgets = new ArrayList<Widget>();
  ArrayList stockIndexes = new ArrayList<Integer>();
  ArrayList tickerIndexes = new ArrayList<Integer>();  // Adam Mulvihill - 25/03/2020 - Stores the indexes to be accessed when displaying widgets on screen 1.
  ArrayList savedTickerIndexes = new ArrayList<Integer>();  // Adam Mulvihill - 09/04/2020 - Made to save the indexes from a dropbox query before the searchbar is used. Allows the searchbar to be used to search the dropbox results as well.
  String text1, text2, text3, text4, text5;
  color widgetColour;
  int event, dateEvent;
  int widgetWidth, widgetHeight;
  int widgetWidth2;
  int x, y;
  PFont textFont;
  color textColour;
  color sliderColour1 = color(75);
  color sliderColour2 = color(100);
  BarChart barChart;
  LineChart linechart;
  DropBox sectorDropBox, industryDropBox;
  Widget backButton;
  int currentDataPos;  // EDITED Adam Mulvihill - 20/03/2020 - Used when initialising and changing the widgets displayed in screen. Keeps track of where in the displayed data the program is.
  int link;
  int dateArrayCount;
  int dropBoxElemCount;
  Widget differenceScreen;
  
  Screen()
  {
    slider = new ScrollBar(1895, 50, 25, 500, 10, (String)null, sliderColour1, sliderColour1, sliderColour2, (PFont)null, 1, true);
    
    textFont = loadFont("Calibri-18.vlw");
    textColour = color(250, 181, 32);
    widgetColour = color(50);
    widgetWidth = 1885; // 12/03/2020 Ralph and Eligijus fixed a bug by changing widgetWidth (bug: clicking scrollbar caused currentScreen to change)
    widgetHeight = 50;
    widgetWidth2 = widgetWidth - 900;
    slider2 = new ScrollBar(widgetWidth2 + 10, 50, 25, 500, 10, (String)null, sliderColour1, sliderColour1, sliderColour2, (PFont)null, 1, true);
    slider3 = new ScrollBar(995, 35, 25, 270, 10, (String)null, sliderColour1, sliderColour1, sliderColour2, (PFont)null, 1, true);
    slider4 = new ScrollBar(1815, 35, 25, 270, 10, (String)null, sliderColour1, sliderColour1, sliderColour2, (PFont)null, 1, true);
    x = 10;
    y = 55;
    event = 1;
    dateEvent = 20;
    currentDataPos = 0;
    dateArrayCount = 0;
    dropBoxElemCount = 0;
    barChart = new BarChart(760, 50, 400, 400, textColour, result, stockIndexes);
    linechart= new LineChart();//edited bu Utkarsh Gupta 26/03/20 . Calls LineChart class.
    for(int index = 0; index < nameTicker.exchangeTicker.size(); index++)
    {
      tickerIndexes.add(index);
    }
    initializeArrayList(widgets, currentDataPos); 
    initialiseDateWidgets(dateWidgets, dateArrayCount);
    searchBar = new SearchBar(10, 30, 300, 25, "Search tickers (Press 'Enter' to search)", color(20), color(100), color(255), textFont, 2);
    backButton = new Widget(1865, 5, 50, 30, "Back", widgetColour, color(225,100,0), textFont, 3); // Edited Ralph Swords 19/03/2020 - creates back button
    differenceScreen = new Widget(1600, 5, 300, 30, "Sort by Percentage Change and Date", widgetColour, color(225,100,0), textFont, 4);
    sectorDropBox = new DropBox(800, 5, 65, 30, "Sector", widgetColour, color(225,100,0), textFont, 5);                                                        // Edited Eligijus Skersonas 26/03/2020 adds a dropBox for sector
    industryDropBox = new DropBox(1250, 5, 85, 30, "Industry", widgetColour, color(225,100,0), textFont, 6);                                                   // Added Eligijus Skersonas 01/04/2020 adds a dropBox for indsutry
  }
  
  //EDITED Eligijus Skersonas 20/03/2020 added a parameterised constructor so that for screen2 the user can select a query (i.e stocks associated with an exchange)
  Screen(String dont)
  {
    slider = new ScrollBar(1895, 50, 25, 500, 10, (String)null, sliderColour1, sliderColour1, sliderColour2, (PFont)null, 1, true);
    textFont = loadFont("Calibri-18.vlw");
    textColour = color(250, 181, 32);
    widgetColour = color(50);
    widgetWidth = 1885; // 12/03/2020 Ralph and Eligijus fixed a bug by changing widgetWidth (bug: clicking scrollbar caused currentScreen to change)
    widgetHeight = 50;
    x = 10;
    y = 55;
    event = 1;
    barChart = new BarChart(760, 50, 400, 400, textColour, result, stockIndexes);
    linechart= new LineChart();//edited bu Utkarsh Gupta 26/03/20 . Calls LineChart class.
    searchBar = new SearchBar(10, 30, 300, 25, "Search tickers", color(20), color(100), color(255), textFont, 2);
    backButton = new Widget(1865, 5, 50, 30, "Back", widgetColour, color(225,100,0), textFont, 3);                        // Edited Ralph Swords 19/03/2020 - creates back button
  }
  
  // draws the screen
  // Edited Ralph Swords 19/03/2020 - now draws back button
  // Edited Ralph Swords 23/03/2020 - added screen 4
  // Edited Ralph Swords 30/03/2020 - draws the unique dates onto the greatest change in price screen
  void draw() //<>// //<>// //<>//
  {
    textFont(textFont);                                                // draws the header row
    fill(textColour);
    if(currentScreen == screen1){
      fill(225,100,0);
      text("Ticker", 20, 25);
      text("Exchange", 120, 25);
      text("Name", 320,25);
      industryDropBox.draw();
      sectorDropBox.draw();
      differenceScreen.draw();
      fill(textColour);
      searchBar.draw();  // Adam Mulvihill - 25/03/2020 - Changed such that searchbar only appears on screen 1
    }
    else if(currentScreen == screen2){
      linechart.draw();
      fill(225,100,0);
      text("Ticker", 20, 25);
      text("Open price", 265, 25);
      text("Adjusted closing price", 510,25);
      text("Date", 755, 25);
      fill(textColour);
  }
    else if(currentScreen == screen3){ //draw screen3
      barChart.stockIndexes = stockIndexes; // 22/03/2020 added by Eligijus Skersonas so that barChart object knows the stockIndexes
      //Edited 09/04/2020 added all the information of the current stock on the screen and a bar for high and low on the barchart
      fill(255, 100, 0);
      text((String) nameTicker.ticker.get((Integer) stockIndexes.get(result)), 50, 25);
      fill(textColour);
      text("Date: " + (String) dateExchange.date.get((Integer) stockIndexes.get(result)), 20, 75);
      text("Highest Price: " + (String) price.high.get((Integer) stockIndexes.get(result)), 20, 125);
      text("Lowest Price: " + (String) price.low.get((Integer) stockIndexes.get(result)), 20, 175);
      text("Open Price: " + (String) price.openPrice.get((Integer) stockIndexes.get(result)), 20, 225);
      text("Closing: " + (String) price.closePrice.get((Integer) stockIndexes.get(result)), 20, 275);
      text("Adjusted Closing Price: " + (String) price.adjustedClose.get((Integer) stockIndexes.get(result)), 20, 325);
      text("Volume: " + (String) price.volume.get((Integer) stockIndexes.get(result)), 20, 375);
      barChart.draw();
    
  }
    else if(currentScreen == screen4){
      fill(225,100,0);
      text("Ticker", 20, 25);
      text("Open price", 265, 25);
      text("Closing price", 510,25);
      text("Percent Change", 755, 25);
      text("Current Date: " + currentDate, 1000, 25);
      fill(textColour);
      slider2.draw();
    }
    // change
    if(currentScreen != screen3 && currentScreen != screen4){
      for(int index = 0; index < ON_SCREEN_DATA_POINT_COUNT && index < widgets.size(); index++)    // draws the all the widgets on the screen
      {
        if(!widgets.isEmpty()){
            DataWidget drawWidget =(DataWidget) widgets.get(index);
            drawWidget.draw();
        }
        else text("no stocks", 400, 200);
        
       }
     }
     else if(currentScreen == screen4)
     {
      for(int index = 0; index < ON_SCREEN_DATA_POINT_COUNT && index < widgets.size(); index++)    // draws the all the widgets on the screen  // Adam Mulvihill - 25/03/2020 - Edited condition such that the program wont crash when scrolling to the bottom
      {
        if(!widgets.isEmpty()){
            DataWidget drawWidget =(DataWidget) widgets.get(index);
            drawWidget.draw();
        }
        else text("no stocks", 400, 200);
     }
     for(int index = 0; index < ON_SCREEN_DATA_POINT_COUNT && index < dateWidgets.size(); index++)
     {
       Widget drawWidget = (Widget) dateWidgets.get(index);
       drawWidget.draw();
     }
    }
    if(currentScreen != screen1)
    {
      backButton.draw();
    }
    if(currentScreen != screen3)  // Adam Mulvihill - 25/03/2020 - moved such that the slider appears on all screens but screen 3
    {
      slider.draw();
    }
    if(currentScreen == screen1 && sectorDropBox.inUse == true) {
      sectorDropBox.showOptions();
      slider3.draw();
    }
    else if(currentScreen == screen1 && industryDropBox.inUse == true){
      industryDropBox.showOptions();
      slider4.draw();
    }
  }  //<>// //<>//
  
  // Method for making the array of Data Widgets to be displayed on screen.
  // EDITED Eligijus Skersonas 20/03/2020 -  Added to the method the stockIndexes arraylist for screen2 so that correct stocks are shown
  // EDITED Adam Mulvihill - 20/03/2020 - Changed this method such that for screen 2, it will go through the indexes in stockIndexes and access those directly, such that it only displays the appropriate stocks.
  // Also added arrayList.clear() to keep the arrayList to a specific and small size.
  // Edited Ralph Swords 23/03/2020 - added screen 4
  // Edited Adam Mulvihill 25/03/2020 - changed such that exchanges are displayed using the indexes in tickerIndexes, added to implement the searchbar
  // Edited Ralph Swords 29/03/2020 - creates smaller widgets for screen 4
  void initializeArrayList(ArrayList arrayList, int arrayCount)
  {
    arrayList.clear();
    if(currentScreen == screen1)
    {
      for(int index = 0; index < ON_SCREEN_DATA_POINT_COUNT && arrayCount < tickerIndexes.size(); index++)
      {
        if(!tickerIndexes.isEmpty())
        {
          DataWidget newWidget;
          text1 = (String) nameTicker.getExchangeTicker((Integer) tickerIndexes.get(arrayCount));
          text2 = (String) dateExchange.getExchange((Integer) tickerIndexes.get(arrayCount));
          text3 = (String) nameTicker.getName((Integer) tickerIndexes.get(arrayCount));
          text4 = (String) industrySector.getSector((Integer) tickerIndexes.get(arrayCount));
          text5 = (String) industrySector.getIndustry((Integer) tickerIndexes.get(arrayCount));
          newWidget = new DataWidget(x, y, widgetWidth, widgetHeight, text1, text2, text3, text4, text5, widgetColour, textColour, textFont, event, (Integer) tickerIndexes.get(arrayCount));
          arrayList.add(newWidget);
          arrayCount++;
          y += 50;
        }
      }
    }
    else if(currentScreen == screen2)
    {
      if(!stockIndexes.isEmpty())
      {
        for(int index = 0; index < ON_SCREEN_DATA_POINT_COUNT && arrayCount < stockIndexes.size(); index++)
        {
          DataWidget newWidget;
          text1 = (String) nameTicker.getTicker((Integer) stockIndexes.get(arrayCount));
          text2 = (String) price.getOpenPrice((Integer) stockIndexes.get(arrayCount));
          text3 = (String) price.getAdjustedClose((Integer) stockIndexes.get(arrayCount));
          text4 = (String) dateExchange.getDate((Integer) stockIndexes.get(arrayCount));
          newWidget = new DataWidget(x, y, widgetWidth-900, widgetHeight, text1, text2, text3, text4, widgetColour, textColour, textFont, event,arrayCount);  // Adam Mulvihill - 02/04/2020 - Made the width of widgets smaller on screen2. Change moved to here from data widget such that mouseOverWidget's return value is appropriate for the widgets size.
          arrayList.add(newWidget);
          arrayCount++;
          y += 50;
        }
      }
    }
    else if(currentScreen == screen4)
    {
      for(int index = 0; index < ON_SCREEN_DATA_POINT_COUNT && arrayCount < price.percentageChange.size(); index++)  // Change
      {
        DataWidget newWidget;
        int arrayIndex = price.getPercentPosition(arrayCount);
        int percentIndex = price.getPercentChangePosition(arrayCount);
        text1 = (String) nameTicker.getTicker(arrayIndex);
        text2 = (String) price.getOpenPrice(arrayIndex);
        text3 = (String) price.getClosePrice(arrayIndex);
        text4 = (price.getPercentageChange(percentIndex)+"");
        newWidget = new DataWidget(x, y, widgetWidth2, widgetHeight, text1, text2, text3, text4, widgetColour, textColour, textFont, event,arrayIndex);
        arrayList.add(newWidget);
        arrayCount++;
        y += 50;
      }
    }
    y = 55;  // Adam Mulvihill - 25/03/2020 - changed from y = 50 to y = 55. fixed a minor bug where all datawidgets would move up 5 pixels when they are initialised the second time.
  }
  // Ralph Swords - initialise an array list that contains the approapriate date widgets to be displayed on the greatest change in price screen
  void initialiseDateWidgets(ArrayList arrayList, int arrayCount)
  {
    arrayList.clear();
    for(int index = 0; index < ON_SCREEN_DATA_POINT_COUNT && arrayCount < dateExchange.uniqueDates.size(); index++)
    {
      
     
      Widget newWidget;
      text1 = dateExchange.getUniqueDate(arrayCount);
      newWidget = new Widget(1025, y, 885, widgetHeight, text1, widgetColour, textColour, textFont, dateEvent);
      arrayList.add(newWidget);
      arrayCount++;
      y+=50;
      dateEvent++;
    }
    y = 55;
    dateEvent = 20;
  }
  
  
  // this method moves the slider if dragged, finds the appropriate index, and changes the array list to have the correct widgets
  // Edited Ralph Swords - 12/03/2020. Changed it so the slider only works when the mouse is over the scroll bar
  // Edited Utkarsh Gupta - 12/03/2020. added arrayCount as a parameter to link the different screens.
  // Edited Ralph Swords 17/03/2020 - Made adjustments so it would work with new data classes.
  // Edited Ralph Swords 19/03/2020 - fixed bug where you could only scroll to first thousand exchanges.
  // Edited Ralph Swords 23/03/2020 - added screen 4
  // Edited Ralph Swords 29/03/2020 - added second scroll for screen 4
  void mouseDragged()
  {
    if(mouseX >= 1895 && mouseX <= 1920)
    {
      slider.move(mouseX, mouseY);
      int listSize = 0;
      if(currentScreen == screen2)
      {
        listSize = stockIndexes.size();    // EDITED - Adam Mulvihill - 20/03/2020 - Changed the Array used such that the scrollbar wouldnt go past the end of the list when used
      }
      else if(currentScreen == screen4)
      {
      listSize = dateExchange.uniqueDates.size();
      }
      else
      {
        listSize = tickerIndexes.size();  // Adam Mulvihill - 25/03/2020 - Changed such that the listSize passed is tickerIndexes on screen 1. fixed a bug with scrolling past the end of the list
      }
      if(currentScreen != screen4)
      {
        currentDataPos = slider.getDataPos(listSize);
        currentScreen.initializeArrayList(currentScreen.widgets, currentDataPos); 
      }
      else if(currentScreen == screen4)
      {
        dateArrayCount = slider.getDataPos(listSize);
        println(dateArrayCount);
        initialiseDateWidgets(dateWidgets, dateArrayCount);
      }
    }                                                                              // Edited Ralph Swords - fixed bug where program crashed when you scrolled to the end of the screen 
    if( mouseX >= 995 && mouseX <= 1020 && currentScreen == screen4)
    {
      slider2.move(mouseX, mouseY);
      int listSize = price.percentageChange.size();
      currentDataPos = slider2.getDataPos(listSize);
      currentScreen.initializeArrayList(currentScreen.widgets, currentDataPos);
    }
    if(sectorDropBox != null && sectorDropBox.inUse)  // Adam Mulvihill - 02/04/2020 - Added not null conditions to prevent null pointer exceptions on screen 2.
    {
        if(mouseX >= 985 && mouseX <= 1020){
          slider3.move(mouseX, mouseY);
          int listSize = dataPoint.sectorNames.size();
          currentDataPos = slider3.getDataPos(listSize);
          sectorDropBox.initialiseList(800, 5, widgetColour, textFont, currentDataPos);
        }
    }
    else if(industryDropBox != null && industryDropBox.inUse)
    {
        if(mouseX >= 1815 && mouseX <= 1850){
          slider4.move(mouseX, mouseY);
          int listSize = dataPoint.industryNames.size();
          currentDataPos = slider4.getDataPos(listSize);
          industryDropBox.initialiseList(1250, 5, widgetColour, textFont, currentDataPos);
        }
    }
    
  }
  
  // Method takes the Ticker on the button pressed on the exchanges screen, and finds all entries in the entire data set with that ticker. Initialises the array of indexes to access when showing information on that company's stocks.
  // EDITED Adam Mulvihill - 20/03/2020 - Added stockIndexes.clear() to this method such that when accessing a new exchange, only that exchanges stocks are displayed.
  // Method created by Eligijus Skersonas.
  void setStocksToDisplay(){
    stockIndexes.clear();
    String exTicker = (String) nameTicker.exchangeTicker.get(result);
    String stock;
    for(int i = 0; i < nameTicker.ticker.size(); i++){
      stock = (String) nameTicker.ticker.get(i);
      if(stock.equalsIgnoreCase(exTicker)){
        stockIndexes.add(i);
      }
    }
  }
  
  // Adam Mulvihill - 17/03/2020 - Added a method to allow input to the searchBar
  void keyPressed()
  {
    if(searchBar.isInUse() && currentScreen == screen1)  // Adam Mulvihill - 25/03/2020 - changed the condition such that the searchbar will only be accessable from screen 1
    {
      // Google searched "enter key in ASCII". found answer from top result without opening the site: https://www.includehelp.com/code-snippets/how-to-identify-enter-key-is-pressed-in-c-programming-language.aspx
      if(key == 10)  // Enter key
      {
        if(sectorDropBox.hasChecked() || industryDropBox.hasChecked())  // Adam Mulvihill - 09/04/2020 - Added a case to deal with the case where specific sectors or industries have been selected.
        {
          tickerIndexes = searchBar.searchForStrings(nameTicker.exchangeTicker, savedTickerIndexes);
          slider.setRelativePos(0, tickerIndexes.size());
          initializeArrayList(widgets, 0);
        }
        else
        {
          tickerIndexes = searchBar.searchForStrings(nameTicker.exchangeTicker);  // Adam Mulvihill - 25/03/2020 - Edited such that the searchBar can be used to search for tickers. all tickers matching or beginning with the input will appear.
          slider.setRelativePos(0, tickerIndexes.size());
          initializeArrayList(widgets, 0);
        }
      }
      else searchBar.updateSearchString();
    }
  }
  
  // Adam Mulvihill - 17/03/2020 - Added a method to tell whether the search bar is in use or not
  // Edited Ralph Swords 19/03/2020 - adds interactivity to back button
  // Edited Ralph Swords 19/03/2020 - fixed bug where program crashes when back button pressed on screen3
  // Edited Ralph Swords 23/03/2020 - added back button to screen 4
  // Edited Ralph Swords 31/03/2020 - now able to select a date on the greatest change in price screen
  // Edited Ralph Swords 01/04/2020 - if you got to screen 3 from screen 4, pressing the back button on screen screen 3 will bring you to screen 4, and if you got to screen 3 from screen 2, pressing the back button on screen 3 will bring you to screen 2
  void mousePressed()
  {
    if(searchBar.getEvent(mouseX, mouseY) == searchBar.getEvent() && currentScreen == screen1)  // Checks if the mouse position matches up by checking if the event returned from the mouses position is the same as the searchBar's event.  // Adam Mulvihill - 25/03/2020 - changed the condition such that the searchbar will only be accessable from screen 1
      searchBar.setInUseTo(true);
    else
      searchBar.setInUseTo(false);
      
    if(currentScreen == screen1){
      if(sectorDropBox.getEvent(mouseX, mouseY) == sectorDropBox.getEvent()) {     // Edited Eligjus Skersonas 26/03/2020 used Adams Idea of using a boolean inUse for on an screen widget to implement a dropBox
        sectorDropBox.changeInUse();
        if(sectorDropBox.inUse){
          industryDropBox.setInUseTo(false);
          industryDropBox.uncheck();
        }
      }
      else if(industryDropBox.getEvent(mouseX, mouseY) == industryDropBox.getEvent()){
        industryDropBox.changeInUse();
        if(industryDropBox.inUse){
          sectorDropBox.setInUseTo(false);
          sectorDropBox.uncheck();
        }
      }
      else if(sectorDropBox.inUse == true){
          for(int i = 0; i < sectorDropBox.currentlist.size(); i++){
            sectorDropBox.currentlist.get(i).mousePressed(mouseX, mouseY);
            sectorDropBox.list.get(sectorDropBox.currentlist.get(i).currentDataPos).mousePressed(mouseX, mouseY);
          }
          if(!industryDropBox.hasChecked() && (sectorDropBox.hasChecked() || !sectorDropBox.hasChecked())){
            tickerIndexes = sectorDropBox.searchSectors();        //added Eligijus Skersonas 01/04/2020 only display the checked boxes if non checked display all
            savedTickerIndexes = tickerIndexes;  // Adam Mulvihill - 09/04/2020 - saves the original results from the dropbox to use with the searchbar.
            if(searchBar.getCurrentInput() != "")  // Adam Mulvihill - 09/04/2020 - checks to see if the searchbar was used before, and reapplies the query if it was
            {
              tickerIndexes = searchBar.searchForStrings(nameTicker.exchangeTicker, savedTickerIndexes);
            }
            slider.setRelativePos(0, tickerIndexes.size());
            initializeArrayList(widgets, 0);
          }
      }
      else if(industryDropBox.inUse == true){
          for(int i = 0; i < industryDropBox.currentlist.size(); i++){
            industryDropBox.currentlist.get(i).mousePressed(mouseX, mouseY);
            industryDropBox.list.get(industryDropBox.currentlist.get(i).currentDataPos).mousePressed(mouseX, mouseY);
          }
          
          if(!sectorDropBox.hasChecked() && (industryDropBox.hasChecked() || !industryDropBox.hasChecked())){
            tickerIndexes = industryDropBox.searchSectors();        //added Eligijus Skersonas 01/04/2020 only display the checked boxes if non checked display all
            savedTickerIndexes = tickerIndexes;  // Adam Mulvihill - 09/04/2020 - saves the original results from the dropbox to use with the searchbar.
            if(searchBar.getCurrentInput() != "")  // Adam Mulvihill - 09/04/2020 - checks to see if the searchbar was used before, and reapplies the query if it was
            {
              tickerIndexes = searchBar.searchForStrings(nameTicker.exchangeTicker, savedTickerIndexes);
            }
            slider.setRelativePos(0, tickerIndexes.size());
            initializeArrayList(widgets, 0);
          }
      }
    }
    
    if(backButton.getEvent(mouseX, mouseY) == backButton.getEvent())
    {
      if(currentScreen == screen2 || currentScreen == screen4)
      {
        currentScreen = screen1;
        fromGreatestPrice = false;
      }
      else if(currentScreen == screen3 && !fromGreatestPrice)
      {
        currentScreen = screen2;
        link = 0;
      }
      else if(currentScreen == screen3 && fromGreatestPrice)
      {
        currentScreen = screen4;
      }
    }
    else if(currentScreen == screen1 && differenceScreen.getEvent(mouseX, mouseY) == differenceScreen.getEvent())
    {
      if(!industryDropBox.inUse && !sectorDropBox.inUse){
        currentScreen = screen4;
        fromGreatestPrice = true;
      }
    }
    if(currentScreen == screen4)
    {
      for(int index = 0; index < dateWidgets.size(); index++)
      {
        Widget checkWidget =(Widget) dateWidgets.get(index);
        if(checkWidget.getEvent(mouseX, mouseY) == checkWidget.getEvent())
        {
          currentDate = checkWidget.widgetText;
          price.initPercentArray();
          price.sortPercent();
          initializeArrayList(widgets, 0);
        }
      }
    }
    // Adam Mulvihill - 06/04/2020 - Called the mousePressed method of linechart to allow buttons to be used for it.
    if(currentScreen == screen2)
    {
      linechart.mousePressed();
    }
  }
  
  // Adam Mulvihill - 12/03/2020
  // Added a method to allow the mouse wheel to be used for the scroll bar for vertical movement.
  // Information on the method was found at: https://processing.org/reference/mouseWheel_.html
  // Edited Ralph Swords 17/03/2020 - Made adjustments so it would work with new data classes.
  // Edited Ralph Swords 19/03/2020- fixed bug where you could only scroll to first thousand exchanges
  // EDITED Adam Mulvihill - 20/03/2020 - changed the method called to a new method. fixed a problem where with large arrays, the bar would scroll to quickly and skip over large chunks of the list.
  // Edited Ralph Swords 23/03/2020 - added screen 4
  // Edited Ralph Swords 29/03/2020 - added second scroll for screen 4
  void mouseWheel(MouseEvent event)
  {
    float wheelDisplacement = event.getCount(); // Gets how much the scroll wheel was turned. turning towards the user is positive, away is negative
    int listSize = 0;
    int listSize2 = 0;
    if(currentScreen == screen1){
      listSize = tickerIndexes.size();
      listSize2 = (industryDropBox.inUse)? dataPoint.industryNames.size():
                  (sectorDropBox.inUse)?  dataPoint.sectorNames.size(): 0;
    }
    else if(currentScreen == screen2)
    {
      listSize = stockIndexes.size();
    }
    else if(currentScreen == screen4 )
    {
      listSize = price.percentageChange.size();
      listSize2 = dateExchange.uniqueDates.size();
    }
    else
    {
      listSize = tickerIndexes.size();  // Adam Mulvihill - 25/03/2020 - Changed such that the listSize passed is tickerIndexes on screen 1. fixed a bug with scrolling past the end of the list
    }
    
    // Adam Mulvihill - 10/04/2020 - Changed all the scroll method calls to pass the number of on-screen data points to the method. Fixed an issue with scrolling past the bottom of the lists when using the mouse wheel.
    if(currentScreen == screen1)  // Adam Mulvihill - 02/04/2020 - removed screen 2. error not being able to scroll due to a null pointer.
    {
      if(sectorDropBox.inUse && mouseX >= 730 && mouseX <= 1030 && mouseY >= 35 && mouseY <= 305)        //Edited ELigijus Skersonas 02/04/2020 added  mouseScrolling for the dropboxes
        currentDataPos = slider3.scroll((int)wheelDisplacement, currentDataPos, listSize2, ON_SCREEN_DATA_POINT_COUNT);
      else if(industryDropBox.inUse && mouseX >= 1180 && mouseX <= 1840 && mouseY >= 35 && mouseY <= 305)
        currentDataPos = slider4.scroll((int)wheelDisplacement, currentDataPos, listSize2, ON_SCREEN_DATA_POINT_COUNT);
      else
        currentDataPos = slider.scroll((int)wheelDisplacement, currentDataPos, listSize, ON_SCREEN_DATA_POINT_COUNT);
    }
    else if(currentScreen == screen2)  // Adam Mulvihill - 10/04/2020 - Made it such that the mouse wheel can be used to scroll on screen 2 aswell.
    {
      currentDataPos = slider.scroll((int)wheelDisplacement, currentDataPos, listSize, ON_SCREEN_DATA_POINT_COUNT);
    }
    else if(currentScreen == screen4 && mouseX > 985)
    {
     
      dateArrayCount = slider.scroll((int)wheelDisplacement, dateArrayCount, listSize2, ON_SCREEN_DATA_POINT_COUNT);
      
    }
    else
    {
      if(slider2 != null)
      {
        currentDataPos = slider2.scroll((int)wheelDisplacement, currentDataPos, listSize, ON_SCREEN_DATA_POINT_COUNT);
      }
    }
    
    if(currentScreen == screen1 || currentScreen == screen2 || (currentScreen == screen4 && mouseX >= 0 && mouseX <= 985))
    {
      if(currentScreen == screen1 && sectorDropBox.inUse && mouseX >= 730 && mouseX <= 1030 && mouseY >= 35 && mouseY <= 305)
        sectorDropBox.initialiseList(800, 5, widgetColour, textFont, currentDataPos);
      else if(currentScreen == screen1 && industryDropBox.inUse && mouseX >= 1180 && mouseX <= 1840 && mouseY >= 35 && mouseY <= 305)
        industryDropBox.initialiseList(1250, 5, widgetColour, textFont, currentDataPos);
      else
        currentScreen.initializeArrayList(currentScreen.widgets, currentDataPos);
    }
    else if(currentScreen == screen4 && mouseX > 985)
    { 
      currentScreen.initialiseDateWidgets(currentScreen.dateWidgets, dateArrayCount);
    }
  }
}
