
// Adam Mulvihill - 10/03/2020 created class

/*
 Basic widget Class - Simple button that returns its event upon interaction and nothing more.
 Button has a black border which turns white when the users mouse is over the widget.
 
 This class was taken from my attempt at Lab Exercise 6
*/

// Adam Mulvihill change made 10/03/2020 : Constant moved to the constants tab.

class Widget
{
  private int xpos;
  private int ypos;
  private int widgetWidth;      // widgetWidth and widgetHeight in this case indicate the area that can be
  private int widgetHeight;     // interacted with and will return an event upon being interacted with.
  private String widgetText;
  private int event;
  private color widgetColour;
  private color textColour;
  private PFont widgetFont;
  
  // Widget constructor - takes in the x and y position of the widget, its width and height,
  // the text to be displayed for that widget, the colour of the widget and text, the text font, and the widgets event.
  Widget(int px, int py, int pwidth, int pheight, String ptext,
    color pwidgetColour, color ptextColour, PFont pfont, int pevent)
  {
    xpos = px;
    ypos = py;
    widgetWidth = pwidth;
    widgetHeight = pheight;
    widgetText = ptext;
    widgetColour = pwidgetColour;
    textColour = ptextColour;
    widgetFont = pfont;
    event = pevent;
  }
  
  // Adam Mulvihill - 17/03/2020 - New constructor for making a simple interactable rectangle with no text.
  Widget(int px, int py, int pwidth, int pheight, color pcolour, int pevent)
  {
    xpos = px;
    ypos = py;
    widgetWidth = pwidth;
    widgetHeight = pheight;
    widgetText = null;
    widgetColour = pcolour;
    textColour = color(0);
    widgetFont = null;
    event = pevent;
  }
  
  // Draws the widget to the screen, with the widget's text inside the widget.
  void draw()
  {
    fill(widgetColour);
    if(mouseOverWidget(mouseX, mouseY)) stroke(255);
    else stroke(0);
    rect(xpos, ypos, widgetWidth, widgetHeight);
    if(widgetText != null && widgetFont != null)  // EDITED Adam Mulvihill - 17/03/2020 - changed to accomodate the new constructor which doesnt use text.
    {
      fill(textColour);
      textFont(widgetFont);
      text(widgetText, xpos + 10, ypos + widgetHeight - 10);
    }
  }
  
  // Returns the widget's event
  int getEvent()
  {
    return event;
  }
  
  // Returns the constant EVENT_NULL or the widgets event based on whether the given x and y
  // coordinates are within the widget. Meant to be used with the mouse's coordinates.
  int getEvent(int mX, int mY)
  {
    if(mX > xpos && mX < xpos+widgetWidth
      && mY > ypos && mY < ypos+widgetHeight)
    {
      return event;
    }
    return EVENT_NULL;
  }
  
  // Method that returns whether the given x and y coordinates are within the widget, without
  // returning any events. Meant to be used with the mouse's coordinates.
  boolean mouseOverWidget(int mX, int mY)
  {
    if(mX > xpos && mX < xpos+widgetWidth
      && mY > ypos && mY < ypos+widgetHeight)
    {
      return true;
    }
    return false;
  }
}
