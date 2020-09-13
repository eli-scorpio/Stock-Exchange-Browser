
// Adam Mulvihill - 12/03/2020 created class

/*
 Sub-class of widget
 Allows the user to type in and search for something, in this case a ticker.
 Will continuously output what has been typed up.
*/

// EDITED Adam Mulvihill - 17/03/2020 - changed the use of variables such that widgetText holds the message to be displayed by an empty search bar, while the input is held in a variable specific to this sub class. All methods and the constructor have
// been changed to fit the new variable roles. Made instance variables private

// Would like to add a simple bar to show where the person is typing. For now, person can only edit the end of the string.
class SearchBar extends Widget
{
  private boolean isInUse;
  private String inputString;  // EDITED Adam Mulvihill - 17/03/2020 - Changed from emptySearchBarMessage to inputString. The role of this variable has been changed to store the input instead of widgetText.
  private color searchColour;  // EDITED Adam Mulvihill - 17/03/2020 - Changed from emptySearchColour to searchColour. This variable holds the colour of the input text now.
  
  // Constructor for SearchBar. Takes in the x and y coordinate of the bar, its width and height, the text to be displayed if the searchbar is empty
  // the colour of the bar, the colour of the text displayed on an empty searchbar, the colour of input text, the font to use, and the event flag.
  SearchBar(int px, int py, int pwidth, int pheight, String pemptyText, color pwidgetColour,
    color ptextColour, color psearchColour, PFont pfont, int pevent)
  {
    super(px, py, pwidth, pheight, pemptyText,
      pwidgetColour, ptextColour, pfont, pevent);
    isInUse = false;
    inputString = "";
    searchColour = psearchColour;
  }
  
  // draws the search Bar to the screen. Will display a generic message defined by the use of the constructor if nothing has been typed.
  void draw()
  {
    fill(super.widgetColour);
    if(isInUse) stroke(255);
    else stroke(0);
    rect(super.xpos, super.ypos, super.widgetWidth, super.widgetHeight);
    textFont(super.widgetFont);
    if(inputString.equals(""))
    {
      fill(super.textColour);
      text(super.widgetText, super.xpos+10, super.ypos+super.widgetHeight-5);
    }
    else
    {
      fill(searchColour);
      text(inputString, super.xpos+10, super.ypos+super.widgetHeight-5);
    }
  }
  
  // Returns whether the searchBar is in use.
  boolean isInUse()
  {
    return isInUse;
  }
  
  // Adam Mulvihill - 17/03/2020 - Method returns the string that has been typed into the search bar
  String getCurrentInput()
  {
    return inputString;
  }
  
  // Method will allow the user to type in the bar if it is in use. Another method will have it so that the boolean can be changed.
  // Got information from: https://processing.org/tutorials/interactivity/ and https://forum.processing.org/one/topic/delete-the-last-character-in-a-string.html
  // EDITED Adam Mulvihill - 14/03/2020 - Method will not update the display unless the clock is at 0. Fixed a problem with it taking input too quickly.
  // EDITED Adam Mulvihill - 17/03/2020 - Removed input clock as it didn't work well with the keyPressed Method.
  void updateSearchString()
  {
    if(isInUse)
    {
      if (keyPressed == true)
      {
        if(key >= 32 && key <= 126)  // EDITED Adam Mulvihill - 17/03/2020 - changed the condition such that most printable characters can be typed.
        {
          inputString = inputString + key;
        }
        else if(key == 8 && !(inputString.equals("")))  // Backspace key EDITED Adam Mulvihill - 17/03/2020 - Removed the condition checking if the input string was null, as the input string is initialised to "" automatically in the constructor.
        {
          inputString = inputString.substring(0, inputString.length()-1);
        }
      }
    }
  }
  
  // Adam Mulvihill - 14/03/2020
  // Method to tell the search bar whether it is in use or not, that is whether to take input or not.
  // Takes in the boolean value to set isInUse to.
  void setInUseTo(boolean bool)
  {
    isInUse = bool;
  }
  
  // Method takes an array list of strings to search through, and returns an arrayList of Integers representing the indexes of all matches found.
  // The input to the search bar is what it searches for. Input to the search bar is stored in inputString
  // Adam Mulvihill - 25/03/2020 - Changed the search method such that it will return all matches that are either the same or begin with the input string. The method will return every index of the given arraylist if input is empty.
  ArrayList<Integer> searchForStrings(ArrayList<String> stringsToSearchThrough)
  {
    inputString = inputString.trim();
    if(stringsToSearchThrough != null)
    {
      ArrayList<Integer> searchResults = new ArrayList<Integer>();
      if(!inputString.equals(""))
      {
        for(int index = 0; index < stringsToSearchThrough.size(); index++)
        {
          if(inputString.length() <= stringsToSearchThrough.get(index).length())
          {
            if(inputString.equalsIgnoreCase(stringsToSearchThrough.get(index).substring(0, inputString.length())))
            {
              searchResults.add(index);
            }
          }
        }
      }
      else
      {
        for(int index = 0; index < stringsToSearchThrough.size(); index++)
        {
          searchResults.add(index);
        }
      }
      return searchResults;
    }
    else
    {
      throw new NullPointerException();
    }
  }
  
  // Method takes an array list of strings to search through, and an array list of specified indexes to access, and returns an arrayList of Integers representing the indexes of all matches found.
  // The input to the search bar is what it searches for. Input to the search bar is stored in inputString
  // Adam Mulvihill - 09/04/2020
  ArrayList<Integer> searchForStrings(ArrayList<String> stringsToSearchThrough, ArrayList<Integer> indexesToSearchThrough)
  {
    inputString = inputString.trim();
    if(stringsToSearchThrough != null && indexesToSearchThrough != null)
    {
      ArrayList<Integer> searchResults = new ArrayList<Integer>();
      if(!inputString.equals(""))
      {
        for(int index = 0; index < indexesToSearchThrough.size(); index++)
        {
          if(indexesToSearchThrough.get(index) < stringsToSearchThrough.size())
          {
            if(inputString.length() <= stringsToSearchThrough.get(indexesToSearchThrough.get(index)).length())
            {
              if(inputString.equalsIgnoreCase(stringsToSearchThrough.get(indexesToSearchThrough.get(index)).substring(0, inputString.length())))
              {
                searchResults.add(indexesToSearchThrough.get(index));
              }
            }
          }
          else
          {
            throw new IndexOutOfBoundsException();
          }
        }
      }
      else
      {
        for(int index = 0; index < indexesToSearchThrough.size(); index++)
        {
          searchResults.add(indexesToSearchThrough.get(index));
        }
      }
      return searchResults;
    }
    else
    {
      throw new NullPointerException();
    }
  }
}
