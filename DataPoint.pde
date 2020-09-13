//Eligijus Skersonas - 10/03/2020 created class
//Reading in the files using a table
class DataPoint{
  //datasets
  // Edited Ralph Swords 17/03/2020 - Made adjustments so it would work with new data classes.
  ArrayList stocksFileString = new ArrayList<String>();
  ArrayList sectorNames = new ArrayList<String>();
  ArrayList industryNames = new ArrayList<String>();
 

  /*
    read in the exchanges and the stocks
  */
  // Edited Ralph Swords 17/03/2020 - Made adjustments so it would work with new data classes.
  void read_in_the_file(String file){
    //Edited by Eligijus Skersonas 12/03/2020 used loadTable instead of loadString as some data contained commas and loadTable proved to be more efficient
    //Using loadTable removed the need for functions split_dailyPrices and split_exchanges
    
      /*
        this method will split each line in the daily_prices and stocks file into its different datasets and add it to the dataset lists
        in doing so we have split the datasets up.
        an element of a dataset matches with its corresponding element in another dataset via its index(they are both the same) 
  */
  
 
    Table table = loadTable(file);
    int element = 0;
    for(int rowNum = 0; rowNum < table.getRowCount(); rowNum++){
      for(int i=0; i < table.getColumnCount(); i++){
        if(file.equalsIgnoreCase("stocks.csv")){ 
          rowNum += (rowNum == 0)? 1:0;                                //this line skips the header row
          if(hasStocks(rowNum, i, table)){
            nameTicker.addExchangeTicker(table.getString(rowNum, i)); i++;        // add elements to their corresponding datasets
            dateExchange.addExchange(table.getString(rowNum, i)); i++;               //
            nameTicker.addName(table.getString(rowNum, i)); i++;                   //
            industrySector.addSector(table.getString(rowNum, i)); i++;                 //
            industrySector.addIndustry(table.getString(rowNum, i)); i++;  
            
          }
          else
            i += 5;
        }
        else {
          nameTicker.addTicker(table.getString(rowNum, i)); i++;                 // add elements to their corresponding datasets
          price.addOpenPrice(table.getString(rowNum, i)); i++;             //
          price.addClosePrice(table.getString(rowNum, i)); i++;            //
          price.addAdjustedClose(table.getString(rowNum, i)); i++;         //
          price.addLow(table.getString(rowNum, i)); i++;                    //
          price.addHigh(table.getString(rowNum, i)); i++;                   //
          price.addVolume(table.getString(rowNum, i)); i++;                 //
          dateExchange.addDate(table.getString(rowNum, i)); i++; 
        }
    }
      }
      setSectorNames();
      setIndustryNames();
    }
    
    //checks if an exchange has stocks associated with it
    //Edited Ralph Swords 13/04/2020 - replaces for loop with ArrayList.contians() in order to reduce the initial loading time
    boolean hasStocks(int rowNum, int i, Table table){
      if(nameTicker.ticker.contains(table.getString(rowNum, i) ))
      {
        return true;
      }
      else
      {
        return false;
      }
    }
  
    //makes an arraylist with all the different sectors removing duplicates, used in dropBox
    void setSectorNames(){
      boolean moveOn;
      String sector;
      for(int i = 0; i < industrySector.sector.size(); i++){
        moveOn = false;
        sector = (String) industrySector.sector.get(i);
        if(sectorNames.isEmpty() == true)
          sectorNames.add(sector);
        else{
          for(int j = 0; j < sectorNames.size() && !moveOn; j++){
             if(sector.equalsIgnoreCase((String) sectorNames.get(j))){
               moveOn = true;
             }
          }
          if(!moveOn)
            sectorNames.add(sector);
        }
      }
       
    }
    
    //makes an arraylist of all the different industry names removing any duplicates, used in dropBox
    void setIndustryNames(){
      boolean moveOn;
      String industry;
      for(int i = 0; i < industrySector.industry.size(); i++){
        moveOn = false;
        industry = (String) industrySector.industry.get(i);
        if(industryNames.isEmpty() == true)
          industryNames.add(industry);
        else{
          for(int j = 0; j < industryNames.size() && !moveOn; j++){
             if(industry.equalsIgnoreCase((String) industryNames.get(j)))
               moveOn = true;
          }
          if(!moveOn)
            industryNames.add(industry);
        }
      }
       
    }



}
