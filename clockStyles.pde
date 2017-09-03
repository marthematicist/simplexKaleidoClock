String dayOfTheWeek( int m , int d , int y ) {
  int c = 0;
  int g = 0;
  if( m >= 3 ) {
    c = floor( y/100 );
    g = y - 100*c;
  } else {
    c = floor( (y-1)/100 );
    g = y-1-100*c;
  }
  int[] e = { 0 , 3 , 2 , 5 , 0 , 3 , 5 , 1 , 4 , 6 , 2 , 4 };
  int[] f = { 0 , 5 , 3 , 1 };
  int w = ( d + e[m-1] + f[c%4] + g + floor(g/4) ) % 7;
  String[] dayText = { "Sunday" , "Monday" , "Tuesday" , "Wednesday" , "Thursday" , "Friday" , "Saturday" };
  return dayText[w];
}