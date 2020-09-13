
// Adam Mulvihill - 10/03/2020 created class

/*
 Sub-class of widget
 A scroll bar that can be used to scroll through data
 
 This class was taken from my attempt at Lab Exercise 6
*/


// CHANGE
class ScrollBar extends Widget
{
  private int barSize;  // An integer representing the size of the bar itself, rather than that of the entire widget. This represents the bars width if the Scroll bar is horizontal, and its height if its vertical
  private float barX;  // x position of the slider itself  EDITED Adam Mulvihill - 20/03/2020 - Changed barX and barY to floats.
  private float barY;  // y position of the slider itself
  private color barColour;
  private boolean isVertical;  // A boolean value representing whether the scroll bar is vertical or horizontal. The bar defaults to the left if its horizontal, and to the top if its vertical
  
  // Constructor for the scroll bar. Takes in the x and y coordinate of the top left of the bar, its width and height, the length of the slider on the bar,
  // the text to be displayed (currently no method in scrollBar uses this), the colour of the bar, the text colour, the colour of the slider on the bar, the text font,
  // the event flag, and a boolean value to set the slider to be vertical or horizontal. True makes it vertical, False makes it horizontal.
  ScrollBar(int px, int py, int pwidth, int pheight, int pbarSize,String ptext,
    color pwidgetColour, color ptextColour, color pbarColour, PFont pfont, int pevent, boolean pvertical)
  {
    super(px, py, pwidth, pheight, ptext, pwidgetColour, ptextColour, pfont, pevent);
    barSize = pbarSize;
    barX = px;
    barY = py;
    barColour = pbarColour;
    isVertical = pvertical;
  }
  
  // Intended to be used with a mouse.
  // Takes in an x coordinate (for a horizontal scrollbar) and a y coordinate (for a vertical scrollbar), and moves the slider to that position, or to the closest end of the scollbar if the coordinate is outside the scrollbar.
  void move(int mX, int mY)
  {
    if(isVertical) 
    {
      if(mY >= super.ypos && mY+barSize <= super.ypos+super.widgetHeight) barY = mY;
      else if(mY < super.ypos) barY = super.ypos;
      else barY = super.ypos+super.widgetHeight-barSize;
    }
    else
    {
      if(mX >= super.xpos && mX+barSize <= super.xpos+super.widgetWidth) barX = mX;
      else if(mX < super.xpos) barX = super.xpos;
      else barX = super.xpos+super.widgetWidth-barSize;
    }
  }
  
  // Draws the scrollbar onto the screen
  void draw()
  {
    fill(super.widgetColour);
    stroke(0);
    rect(super.xpos, super.ypos, super.widgetWidth, super.widgetHeight);
    fill(barColour);
    stroke(0);
    rect(barX, barY, ((isVertical) ? super.widgetWidth : barSize) , ((isVertical) ? barSize : super.widgetHeight));
  }
  
  // Gets the relative position of the bar on the scrollbar, returning an integer between 0 and 1. 0 represents the end of the bar the slider is initially at (the top if its vertical, the left if its horizontal), and 1 represents the opposite end.
  // Edited by Ralph Swords - 11/03/2020. Initialy this method always returned 0 as it was deviding int's, changed them to float's.
  float getRelativePos() //<>//
  {
    float ySum = barY - super.ypos;
    if(isVertical) return (float) (ySum/((float)super.widgetHeight-(float)barSize));
    else return (int) ((barX-super.xpos)/(super.widgetWidth-barSize));
  } //<>//
  
  // This method takes in the total number of Items in a list or other data structure (that is its size), and returns the index of the point that should be at the top of the screen.
  // Adam Mulvihill - 25/03/2020 - Changed such that you cannot scroll if there are ten datapoints or less. Fixed an error where the program would crash if there were less than ten datapoints and you tried to scroll.
  int getDataPos(int pnumberOfDataPoints) //<>//
  {
    if(pnumberOfDataPoints >= ON_SCREEN_DATA_POINT_COUNT)
    {
      int multiplier = pnumberOfDataPoints - ON_SCREEN_DATA_POINT_COUNT;
      return (int)(multiplier*getRelativePos());
    }
    else return 0;
  } //<>//
  
  // Adam Mulvihill - 20/03/2020 - New method for scrolling one by one through data. intended to be used with the mouse wheel.
  // Method for scrolling one by one, intended to be used with the mouse wheel. Takes in an integer to represent the direction of scrolling on the mouse wheel (this is found using MouseEvent event.getCount()), the current position in the data list, the number of entries in the data list, and the number of on screen data points.
  int scroll(int mouseDirection, int currentDataPos, int numberOfDataPoints, int numberOfOnScreenPoints)
  {
    int nextPos = currentDataPos;
    if(mouseDirection > 0 && currentDataPos < numberOfDataPoints-numberOfOnScreenPoints)  // Adam Mulvihill - 10/04/2020 - Changed the condition here to use the new parameter representing the number of on-screen data points. Meant to fix an issue with scrolling past the bottom of a list.
    {
      nextPos++;
    }
    else if(mouseDirection < 0 && currentDataPos > 0)
    {
      nextPos--;
    }
    setRelativePos(nextPos, numberOfDataPoints);
    return nextPos;
  }
  
  // Adam Mulvihill - 20/03/2020 - New method for taking in an index of a list of data, and placing the bar at its appropriate position for that.
  // Takes in the current position in the data list and the number of entries in that data list.
  void setRelativePos(int dataPos, int numberOfDataPoints)
  {
    float newBarY = ((float)((super.widgetHeight - barSize)*(dataPos))/(float)(numberOfDataPoints - ON_SCREEN_DATA_POINT_COUNT)) + (float)super.ypos;
    if(newBarY >= super.ypos && newBarY+barSize <= super.ypos+super.widgetHeight) barY = newBarY;
    else if(newBarY < super.ypos) barY = super.ypos;
    else barY = super.ypos+super.widgetHeight-barSize;
  }
  
  // Adam Mulvihill - 12/03/2020
  // Added methods to get the actual x and y coordinates of the slider. Needed for the mouseWheel method.
  float getX()
  {
    return barX;
  }
  
  float getY()
  {
    return barY;
  }
}
