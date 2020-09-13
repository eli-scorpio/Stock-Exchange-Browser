
// Adam Mulvihill - 12/03/2020 created class

/*
 Sub-class of Widget
 creates a square checkbox. A green circle appears in the middle if the box has been checked/ticked (clicked on).
 Shows a grey circle if the mouse hovers over it and it has not been checked.
 
 This class was taken from my attempt at Lab Exercise 6
 
 NOTE: May allow colour to be changed later.
*/

class CheckBoxWidget extends Widget
{
  private boolean checked;  // Boolean that tells whether the box is checked
  String searchString;
  int x, y;
  String string;
  int currentDataPos;
  
  // Constructor, takes in the x and y coordinates for the box, the size of one of it's sides,
  // the text to be displayed, the colours, font, and the event
  CheckBoxWidget(int px, int py, int psidesize, String ptext,
    color pwidgetColour, color ptextColour, PFont pfont, int pevent, int currentDataPos)
  {
    super(px, py, psidesize, psidesize, ptext, pwidgetColour, ptextColour, pfont, pevent);
    this.currentDataPos = currentDataPos;
    x = px;
    y = py;
    string = ptext;
    checked = false;

  }
  
  CheckBoxWidget(int px, int py, int psidesize, String ptext,
    color pwidgetColour, color ptextColour, PFont pfont, int pevent)
  {
    super(px, py, psidesize, psidesize, ptext, pwidgetColour, ptextColour, pfont, pevent);
    x = px;
    y = py;
    string = ptext;
    checked = false;

  }
  
  // Method for manually changing the widget to checked or unchecked.
  // Takes the boolean value checked is to be set to.
  void setCheckedAs(boolean bool)
  {
    checked = bool;
  }
  
  // Method changes the checked boolean to its opposite aka false -> true, true -> false.
  void changeChecked()
  {
    checked = !checked;
  }
  
  // Method returns whether the box is checked or not.
  boolean isChecked()
  {
    return checked;
    
  }

  
  
  // Draws the check box to the screen. Text is displayed to the right of the box for now.
  void draw()
  {
    fill(super.widgetColour);
    stroke(0);
    rect(super.xpos, super.ypos, super.widgetWidth, super.widgetHeight);
    fill(super.textColour);
    textFont(super.widgetFont);
    text(super.widgetText, super.xpos+super.widgetWidth+10, super.ypos+super.widgetHeight-5);
    if(checked)  // Draws a green circle inside the box if the box is checked.
    {
      fill(225,100,0);
      ellipse(super.xpos+(super.widgetWidth/2), super.ypos+(super.widgetHeight/2), super.widgetWidth/2, super.widgetHeight/2);
    }
    else if(mouseOverWidget(mouseX, mouseY) && !checked)  // Draws a grey circle inside the box if the box has not been checked and the mouse is over it.
    {
      fill(100);
      ellipse(super.xpos+(super.widgetWidth/2), super.ypos+(super.widgetHeight/2), super.widgetWidth/2, super.widgetHeight/2);
    }
    
  }
  
  void mousePressed(int mx, int my)
  {
    if(mx > super.xpos && mx < super.xpos + super.widgetWidth && my > super.ypos && my < super.ypos + super.widgetHeight)
    {
      if( currentScreen == screen1 && (currentScreen.sectorDropBox.inUse == true || currentScreen.industryDropBox.inUse == true)){
       if(currentScreen.sectorDropBox.inUse)
         currentScreen.industryDropBox.uncheck();
       else
         currentScreen.sectorDropBox.uncheck();
      }
        changeChecked();
    }
    
  }
}
