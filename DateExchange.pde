// Ralph Swords 17/3/2020 created class - Contains array lists for the dates and exchanges
// Edited Ralph Sowrds 06/04/2020 - Made cahnges to reduce initial loading time. UniqueDates was changed from ArrayList to StringList, this allowd me to to sortReversed() instead of the orderUniqueDates method
// that I wrote, which worked, but was slow. I also got rid of the getMostRecentDate method, instead I will simply take the first date in the uniqueDates StringList.
class DateExchange
{
  ArrayList date;
  ArrayList exchange;
  StringList uniqueDates;
 
  DateExchange()
  {
    date = new ArrayList<String>();
    exchange = new ArrayList<String>();
    uniqueDates = new StringList();
  }
  String getDate(int index)
  {
    return (String)date.get(index);
  }
  void addDate(String element)
  {
    date.add(element);
  }
  String getExchange(int index)
  {
    return (String)exchange.get(index);
  }
  void addExchange(String element)
  {
    exchange.add(element);
  }
  String getUniqueDate(int index)
  {
    return (String)uniqueDates.get(index);
  }
  void addUniqueDate(String element)
  {
    uniqueDates.append(element);
  }
  
  
  
  
  
  // Ralph Swords 30/03/2020 - eleminates the repeated dates in the stocks so that they can be selected in the greatest change in price screen
  void findUniqueDates()
  {
    for(int index = 1; index < date.size(); index++)
    {
      boolean isUnique = true;
      String checkUnique = getDate(index);
      if(index == 1)
      {
        addUniqueDate(checkUnique);
      }
      else
      {
        for(int index2 = 0; index2 < uniqueDates.size() && isUnique; index2++)
        {
          String compareUnique = getUniqueDate(index2);
          if(compareUnique.equals(checkUnique))
          {
            isUnique = false;
          }
        }
        if(isUnique)
        {
          addUniqueDate(checkUnique);
        }
      }
    }
    uniqueDates.sortReverse(); // Ralph Swords 06/04/2020 - sorts uniqueDates so that the most recent date is first
  }
  
  //<>// //<>//
}
