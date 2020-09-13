//Edited Eligijus Skersonas created class 26/03/2020 dropbox widget class that when clicked on will produce a box with options (e.g. sectors, industries)
//Edited Eligijus Skersonas 09/04/2020 edited so that two lists are used so that you can have only up to 10 options on the dropBox at any one time but retain the 
//                                            properties of the checkboxes when scrolling (because when you scroll the list of checkboxes is cleared and a new one is made)
//                                            using currentPos
class DropBox extends Widget{
  ArrayList<CheckBoxWidget> list = new ArrayList<CheckBoxWidget>();
  ArrayList<CheckBoxWidget> currentlist = new ArrayList<CheckBoxWidget>();
  CheckBoxWidget checkBox;
  boolean inUse;
  int xCord, yCord;
  int space;
  String dropBoxType;
  color colour;
  
  DropBox(int xCord, int yCord, int boxWidth, int boxHeight, String text, color colour, color textColour, PFont font, int event){
    super(xCord, yCord, boxWidth, boxHeight, text, colour, textColour, font, event);
    space = 25;
    dropBoxType = text;
    inUse = false;
    setList(xCord, yCord, colour, font);
    initialiseList(xCord, yCord, colour, font, 0);
    this.xCord = xCord - 20;
    this.yCord = yCord + 40;
  }
  
//Eligijus Skersonas Edited 01/04/2020 implemented industry dropbox 
  void showOptions(){
    fill(255);
    if(dropBoxType.equalsIgnoreCase("sector"))
      rect(xCord-50, 35, 265, 270);
    else
      rect(xCord-50, 35, 635, 270);
    
    //draw check boxes
    for(int i = 0; i < currentlist.size(); i++){
      checkBox = ((CheckBoxWidget) currentlist.get(i));
      if(checkBox.y + 40 < 325)
        checkBox.draw();
    }
  }
  
  //Eligijus Skersonas 01/04/2020 check if dropbox contains checked checkboxes
  boolean hasChecked(){
    for(int i = 0; i < list.size(); i++){
      if(list.get(i).isChecked())
        return true;
    }
    return false;
  }
  
  void changeInUse(){
    inUse = !inUse;
  }
  
  void setInUseTo(boolean bool){
    inUse = bool;
  }
  
  void uncheck(){
    for(int i = 0; i < list.size(); i++){
      list.get(i).setCheckedAs(false);
    }
    for(int i = 0; i < currentlist.size(); i++){
      currentlist.get(i).setCheckedAs(false);
    }
  }
  
  //added eligijus skersonas 01/04/2020 makes arraylist of stocks according to checked checkboxes
  ArrayList<Integer> searchSectors(){
    ArrayList<Integer> results = new ArrayList<Integer>();
    int uncheckedCount = 0;
    
    if(dropBoxType.equalsIgnoreCase("Sector")){
      for(int i = 0; i < list.size(); i++){
        if(list.get(i).checked){
          String sector = (String) list.get(i).string;                                    //if a certain sector is checked e.g finance then add all the finance stocks to results
          for(int index = 0; index < industrySector.sector.size(); index++)               // this is done by saving the index of a stock that matches the the checked checkbox in results
          {
              if(sector.equalsIgnoreCase((String) industrySector.sector.get(index)))
                results.add(index);
          }
        }
        else
          uncheckedCount++;                                                              // if unchecked increment the unchecked counter
      }
      if(uncheckedCount == list.size()){
        for(int index = 0; index < industrySector.sector.size(); index++)
                results.add(index);                                                       // if all checkboxes are unchecked produces all the stocks
      }
    }
    else{
      for(int i = 0; i < list.size(); i++){
        if(list.get(i).checked){
          String industry = (String) list.get(i).string;
          for(int index = 0; index < industrySector.industry.size(); index++)              //same as the comments above just with industry names
          {
              if(industry.equalsIgnoreCase((String) industrySector.industry.get(index)))
                results.add(index);
          }
        }
        else
          uncheckedCount++;
      }
      if(uncheckedCount == list.size()){
        for(int index = 0; index < industrySector.industry.size(); index++)
                results.add(index);
      }
    }
      
      
    return results;
  }
  
  void setList(int xCord, int yCord, color colour, PFont font){
    if(dropBoxType.equalsIgnoreCase("Sector")){
      for(int i = 0; i < dataPoint.sectorNames.size(); i++){
        list.add(new CheckBoxWidget(xCord-50, yCord+40+i*space, 20, (String) dataPoint.sectorNames.get(i), colour, color(225,100,0), font, 5));
      }
    }
    else{
      for(int i = 0; i < dataPoint.industryNames.size(); i++){
        list.add(new CheckBoxWidget(xCord-50, yCord+40+i*space, 20, (String) dataPoint.industryNames.get(i), colour, color(225,100,0), font, 5));
      }
    }
  }
  
  //make list of checkboxes
  void initialiseList(int xCord, int yCord, color colour, PFont font, int currentPos){
    currentlist.clear();
    if(dropBoxType.equalsIgnoreCase("Sector")){
      for(int i = 0; i < 10; i++){
        if(currentPos < dataPoint.sectorNames.size()){
          currentlist.add(new CheckBoxWidget(xCord-50, yCord+40+i*space, 20, (String) dataPoint.sectorNames.get(currentPos), colour, color(225,100,0), font, 5, currentPos));
          if(list.get(currentlist.get(i).currentDataPos).checked)
            currentlist.get(i).setCheckedAs(true);
        }
        currentPos++;
      }
    }
    else{
      for(int i = 0; i < 10; i++){
        if(currentPos < dataPoint.industryNames.size()){
          currentlist.add(new CheckBoxWidget(xCord-50, yCord+40+i*space, 20, (String) dataPoint.industryNames.get(currentPos), colour, color(225,100,0), font, 5, currentPos));
          if(list.get(currentlist.get(i).currentDataPos).checked)
            currentlist.get(i).setCheckedAs(true);
        }
        currentPos++;
      }
    }
    
  }
  
  
 
}
