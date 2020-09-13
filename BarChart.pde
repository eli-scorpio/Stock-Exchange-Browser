//Eligijus Skersonas 17/03/2020 created class - BarChart subclass of Widget

class BarChart extends Widget{
  PShape rectangle;
  color textColor;
  int xScaler, yScale;
  int barX, barYop, barYcp, barYacp, barYhp, barYlp;
  int nextBar;
  int yCordOp, yCordCp, yCordAcp, yCordhp, yCordlp;
  float barMaxOp, barMaxCp, barMaxAcp, barMaxhp, barMaxlp;
  float maxY;
  int maxYScalePos;
  ArrayList<Integer> stockIndexes;
  
  BarChart(int px, int py, int pwidth, int pheight, color pcolour, int pevent, ArrayList stockIndexes){
    super(px, py, pwidth, pheight, pcolour, pevent);
    this.stockIndexes = stockIndexes;
    barYop = 0; barYcp = 0; barYacp = 0; barYhp = 0; barYlp = 0;
    rectangle = createShape(RECT, 0, 0, 1000, 400);
    rectangle.setFill(255);
    textColor = pcolour;
    yCordOp = 450; yCordCp = 450; yCordAcp = 450; yCordhp = 450; yCordlp = 450;
    setMaxY();
    barX = 644;
    nextBar = 39*5;
    maxYScalePos = 65;
  }
  
  //EDITED Eligijus Skersonas 22/03/2020 fixed bug by changing get(result) to get((Integer) stockIndexes.get(result)) 
  void draw(){
    fill(textColor);
    adjustMaxY();
 
    barMaxOp = (float((String) price.openPrice.get((Integer) stockIndexes.get(result)))/maxY)*400;         //calculate the max Open price value from the data set of openprices
    barMaxCp = (float((String) price.closePrice.get((Integer) stockIndexes.get(result)))/maxY)*400;        //calculate the max closing price from the data set of closing prices
    barMaxAcp = (float((String) price.adjustedClose.get((Integer) stockIndexes.get(result)))/maxY)*400;    //calculate the max adjusted closing price from the data set of adjusted closing prices
    barMaxhp = (float((String) price.high.get((Integer) stockIndexes.get(result)))/maxY)*400;    //calculate the max highest price from the data set of highest prices
    barMaxlp = (float((String) price.low.get((Integer) stockIndexes.get(result)))/maxY)*400;    //calculate the max lowest price from the data set of lowest prices
    shape(rectangle, 600, 50);
    fill(225,100,0);
    text("Bar Chart for " + nameTicker.ticker.get((Integer) stockIndexes.get(result)), 600, 25);
    stroke(0);
    rect(barX, yCordOp, 50, barYop); rect(barX + nextBar, yCordCp, 50, barYcp); rect(barX + (nextBar*2), yCordAcp, 50, barYacp);
    rect(barX + nextBar*3, yCordhp, 50, barYhp); rect(barX + nextBar*4, yCordlp, 50, barYlp);
    fill(textColor);
    drawXScale();
    drawYScale();
    
    //animate bar chart
    if(barYop <= barMaxOp){
      yCordOp -= 2; barYop += 2;
    }
      
    if(barYcp <= barMaxCp){
      yCordCp -= 2; barYcp += 2;
    }
      
    if(barYacp <= barMaxAcp){
      yCordAcp -= 2; barYacp += 2;
    }
      
    if(barYhp <= barMaxhp){
      yCordhp -= 2; barYhp += 2;
    }
      
    if(barYlp <= barMaxlp){
      yCordlp -= 2; barYlp += 2;
    }
  }
  
  void adjustMaxY(){
    if(float((String) price.openPrice.get((Integer) stockIndexes.get(result))) < 0.5)                    //if open price is < 0.5 set maxY scale to 0.5 etc. for values up to 200
      maxY = 0.5;
    else if(float((String) price.openPrice.get((Integer) stockIndexes.get(result))) < 1)
      maxY = 1;
    else if(float((String) price.openPrice.get((Integer) stockIndexes.get(result))) < 50)
      maxY = 50;
    else if(float((String) price.openPrice.get((Integer) stockIndexes.get(result))) < 100)
      maxY = 100;
    else if(float((String) price.openPrice.get((Integer) stockIndexes.get(result))) < 200)
      maxY = 200;
  }
  
  void setMaxY(){
      for(int i = 0; i < price.openPrice.size(); i++){
        if(float((String) price.openPrice.get(i)) > maxY){
          maxY = float((String) price.openPrice.get(i));
        }
      }
      for(int i = 0; i < price.closePrice.size(); i++){
        if(float((String) price.closePrice.get(i)) > maxY){
          maxY = float((String) price.closePrice.get(i));
        }
      }
      for(int i = 0; i < price.adjustedClose.size(); i++){
        if(float((String) price.adjustedClose.get(i)) > maxY){
          maxY = float((String) price.adjustedClose.get(i));
        }
      }
      for(int i = 0; i < price.high.size(); i++){
        if(float((String) price.high.get(i)) > maxY){
          maxY = float((String) price.high.get(i));
        }
      }
      for(int i = 0; i < price.low.size(); i++){
        if(float((String) price.low.get(i)) > maxY){
          maxY = float((String) price.low.get(i));
        }
      }
  }
  
  float getMaxY(){
    return maxY;
  }
  
  void drawXScale(){
    text("Open Price", barX - 10, 480); text("Close Price", barX + nextBar - 10, 480); text("Adjusted-Close Price", barX + nextBar*2 - 30, 480);
    text("Highest Price", barX + nextBar*3 - 10, 480); text("Lowest Price", barX + nextBar*4 - 10, 480);
    
    for(int i = 1596; i >= 600; i -= 39){
      text("|", i, 463);
    }
  }
  
  void drawYScale(){
    
    for(int i = 0; i < 10; i++){
      text(maxY - (maxY/10)*i, 520, maxYScalePos + 39*i);
    }
    
    text(0, 575, maxYScalePos + 39*10);
    
    for(int i = 447; i >= 50; i -= 39){
      text("_", 592, i);
    }
  }
  
  // Adam Mulvihill - 22/03/2020 - Added this method to reset the values displayed on the chart.
  void resetChart()
  {
    barYop = 0;
    barYcp = 0;
    barYacp = 0;
    yCordOp = 450; yCordCp = 450; yCordAcp = 450;
  }
}
