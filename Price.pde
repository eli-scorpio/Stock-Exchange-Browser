// Ralph Swords 17/3/2020 created class - Contains array lists for the opening prices, closing prices, adusted closes, highs, lows, and volumes
class Price
{
  ArrayList openPrice;
  ArrayList closePrice;
  ArrayList adjustedClose;
  ArrayList high;
  ArrayList low;
  ArrayList volume;
  ArrayList percentageChange;
  ArrayList percentPosition;
  ArrayList dataInDate;
  ArrayList percentChangePosition;
  Price()
  {
    openPrice = new ArrayList<Float>();
    closePrice = new ArrayList<String>();
    adjustedClose = new ArrayList<Float>();
    high = new ArrayList<String>();
    low = new ArrayList<String>();
    volume = new ArrayList<String>();
    percentageChange = new ArrayList<Float>();
    percentPosition = new ArrayList<Integer>();
    dataInDate = new ArrayList<Integer>();
    percentChangePosition = new ArrayList<Integer>();
  }
  String getOpenPrice(int index)
  {
    return (String)openPrice.get(index);
  }
  void addOpenPrice(String element)
  {
    openPrice.add(element);
  }
  String getClosePrice(int index)
  {
    return (String)closePrice.get(index);
  }
  void addClosePrice(String element)
  {
    closePrice.add(element);
  }
  String getAdjustedClose(int index)
  {
    return (String)adjustedClose.get(index);
  }
  void addAdjustedClose(String element)
  {
    adjustedClose.add(element);
  }
  String getHigh(int index)
  {
    return (String)high.get(index);
  }
  void addHigh(String element)
  {
    high.add(element);
  }
  String getLow(int index)
  {
    return (String)low.get(index);
  }
  void addLow(String element)
  {
    low.add(element);
  }
  String getVolume(int index)
  {
    return (String)volume.get(index);
  }
  void addVolume(String element)
  {
    volume.add(element);
  }
    float getPercentageChange(int index)
  {
    return (float)percentageChange.get(index);
  }
  void addPercentageChange(float element)
  {
    percentageChange.add(element);
  }
  int getPercentPosition(int index)
  {
    return (int)percentPosition.get(index);
  }
  void addPercentPosition(int element)
  {
    percentPosition.add(element);
  }
  int getDataInDate(int index)
  {
    return (int)dataInDate.get(index);
  }
  void addDataInDate(int element)
  {
    dataInDate.add(element);
  }
   int getPercentChangePosition(int index)
  {
    return (int)percentChangePosition.get(index);
  }
  void addPercentChangePosition(int element)
  {
    percentChangePosition.add(element);
  }
 //Ralph Swords - adds the percentage cahnge to the array list
 //Ralph Swords - works for current day
  void initPercentArray()
  {
    percentageChange.clear();
    dataInDate.clear();
    for(int index = 0; index < openPrice.size(); index++)
    {
      if(dateExchange.getDate(index).equals(currentDate))
      {
        float close = float(getClosePrice(index));
        float open = float(getOpenPrice(index));
        float percentChange = (((close) - open)/ open) * 100; 
        addPercentageChange(percentChange);
        addDataInDate(index);
      }
    }
  }
  // Ralph Swords - stores and index of the order in which the data should be shown in screen 4
  // Edited Ralph Swords - works for current day
  void sortPercent()
  {
    percentChangePosition.clear();
    percentPosition.clear();
    for(int index = 0; index < percentageChange.size(); index++) //<>//
    {
      println(index);
      float addChange = getPercentageChange(index);
      int dataIndex = getDataInDate(index);
      println(dataIndex);
      if(index == 0)
      {
        addPercentPosition(dataIndex);
        addPercentChangePosition(index);
      }
      else
      {
        float compareChange = 0.0;
        boolean placed = false;
        for(int index2 = 0; index2  < index  && !placed; index2++)
        {
          int changeIndex = getPercentChangePosition(index2);
          compareChange= getPercentageChange(changeIndex);
          if(compareChange < addChange)
          {
            percentPosition.add(index2, dataIndex);
            percentChangePosition.add(index2, index);
            placed = true;
          }
        }
        if(!placed)
        {
          addPercentPosition(dataIndex);
          addPercentChangePosition(index);
        } //<>//
      }
    }
  }
}
