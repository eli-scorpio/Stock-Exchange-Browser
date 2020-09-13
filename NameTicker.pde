// Ralph Swords 17/3/2020 created class - Contains array lists for the names and tickers
class NameTicker
{
  ArrayList ticker;
  ArrayList exchangeTicker;
  ArrayList name;
  
  NameTicker()
  {
    ticker = new ArrayList<String>();
    exchangeTicker = new ArrayList<String>();
    name = new ArrayList<String>();
  }
  
  String getExchangeTicker(int index)
  {
    return (String)exchangeTicker.get(index);
  }
  void addExchangeTicker(String element)
  {
    exchangeTicker.add(element);
  }
   String getName(int index)
  {
    return (String)name.get(index);
  }
  void addName(String element)
  {
    name.add(element);
  }
  String getTicker(int index)
  {
    return (String)ticker.get(index);
  }
  void addTicker(String element)
  {
    ticker.add(element);
  }
}
