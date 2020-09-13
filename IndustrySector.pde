// Ralph Swords 17/3/2020 created class - Contains array lists for the industries and sectors
class IndustrySector
{
  ArrayList industry;
  ArrayList sector;
  IndustrySector()
  {
    industry = new ArrayList<String>();
    sector = new ArrayList<String>();
  }
  String getIndustry(int index)
  {
    return (String)industry.get(index);
  }
  void addIndustry(String element)
  {
    industry.add(element);
  }
  String getSector(int index)
  {
    return (String)sector.get(index);
  }
  void addSector(String element)
  {
    sector.add(element);
  }
}
