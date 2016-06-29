int year = 0;
int runs = 0;

void setup()
{
  size(500, 500);
  background (0, 200, 0);
  
}

void draw()
{
  
  
}

void dataPoint()
{
  int year = 0;
  int runs = 0;
  point(year, runs);
  ellipse(year, runs, 5, 5);
  
  int[] cool = coolArray();
  for (int i = 0; i < cool.length; i++)
  { 
    int newYear = 1950 + i;
    int newRuns = cool[i];
    map(year, 1950, 2050, 0, 500);
    map(runs, 0, 40, 0, 500);
    point(newYear, newRuns);
    fill(0,0,0);
    ellipse(newYear, newRuns, 5, 5);
    line(year, runs, newYear, newRuns);
    year = newYear;
    runs = newRuns;
  }
}

int[] coolArray()
{
  int[] cool = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14};
  return cool;
}

int[] runsArray()
{  
  //for importing csv files into a 2d array
  //by che-wei wang
  
  String lines[] = loadStrings("list.csv");
  String [] csv;
/*  
  //calculate max width of csv file
  for (int i=0; i < lines.length; i++) 
  {
    String [] chars=split(lines[i],',');
    if (chars.length>csvWidth){
      csvWidth=chars.length;
    }
  }
*/  
  
  //create csv array based on # of rows and columns in csv file
  csv = new int [lines.length];
  
  //parse values into 1d array
  for (int i=0; i < lines.length; i++) {
    int [] csv = new int [lines.length];
    csv = split(lines[i], ',');
    }
 
}
