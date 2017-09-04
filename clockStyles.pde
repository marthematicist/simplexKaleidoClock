
class Clock {
  
  int clockID = 0;
  int numClocks = 4;
  String API_URL_forecast ="http://api.wunderground.com/api/" + APIkey + "/forecast/q/" + zip + ".xml";
  String API_URL_astronomy ="http://api.wunderground.com/api/" + APIkey + "/astronomy/q/" + zip + ".xml";
  
  PFont font1;
  PFont font2;
  PFont font3;
  PFont font4;
  String[] monthText = { "January" , "February" , "March" , "April" , "May" , "June" ,
                       "July" , "August" , "September" , "October" , "November" , "December" };
  
  // WEATHER VARIABLES
  XML w;
  String day0_dayName;
  String day0_dayNum;
  String day0_high;
  String day0_low;
  String day0_icon_url;
  String day0_icon_url_night;
  String day0_windavg;
  String day0_winddir;
  String day0_dateText;
  String day0_tempText;
  String day0_windText;
  PImage icon0;
  PImage icon0Night;
  String day1_dayName;
  String day1_dayNum;
  String day1_high;
  String day1_low;
  String day1_icon_url;
  String day1_windavg;
  String day1_winddir;
  String day1_dateText;
  String day1_tempText;
  String day1_windText;
  PImage icon1;
  String day2_dayName;
  String day2_dayNum;
  String day2_high;
  String day2_low;
  String day2_icon_url;
  String day2_windavg;
  String day2_winddir;
  String day2_dateText;
  String day2_tempText;
  String day2_windText;
  PImage icon2;
  String day3_dayName;
  String day3_dayNum;
  String day3_high;
  String day3_low;
  String day3_icon_url;
  String day3_windavg;
  String day3_winddir;
  String day3_dateText;
  String day3_tempText;
  String day3_windText;
  PImage icon3;
  
  // Astronomy variables
  XML astro;
  int sunriseHour;
  int sunsetHour;
  
  
  Clock() {
    font1 = createFont("TruenoRg.otf",100);
    font2 = createFont("TruenoRg.otf",100);
    font3 = createFont("TruenoRg.otf",100);
    font4 = createFont("TruenoRg.otf",100);
    //updateWeather();
    w =  loadXML("98264-temp.xml");
    astro = loadXML("98264-sunrise.xml");
  }
  
  void nextClock() {
    clockID++;
    clockID %= numClocks;
  }
  
  void drawClock() {
    
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////
    // CLOCK TYPE 0 ///////////////////////////////////////////////////////////////////////////////////////////////
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////
    if( clockID == 0 ) {
      if( minuteChanged || resetClock ) {
        minuteChanged = false;
        resetClock = false;
        
        if( hourChanged ) {
          hourChanged = false;
          updateWeather();
        }
        
        if( dayChanged ) {
          dayChanged = true;
          updateAstronomy();
        }
        
        pg.beginDraw();
        pg.textAlign( LEFT , TOP );
        // values
        float timeCorner = 20;
        float dateCorner = 10;
        color bgColor = color( 0 , 0 , 0 , 160 );
        color textColor = color( 255 , 255 , 255 , 196 );
        float timeBorderX = 10;
        float timeBorderY = 0;
        float timeX = halfWidth;
        float timeY = height*0.2;
        float dateBorderX = 10;
        float dateBorderY = 5;
        float dateX = halfWidth;
        float dateY = height*0.05;
        float timeTextSize = 100;
        float ampmTextSize = 20;
        float dateTextSize = 20;
        float vertOffset = 0.6;
        float ampmOffset = -1;
        float dateOffset = -4;
        String timeText = hour()%12 + ":" + nf(minute(),2);
        String ampmText = " am";
        if( hour() > 12 ) { ampmText = " pm"; }
        String dateText = dayOfTheWeek(month(),day(),year()) + ", " + monthText[month()-1] + " " + day(); 
        println(dateText);
        
        pg.textFont(font1);
        pg.textSize( timeTextSize );
        float timeTextWidth = pg.textWidth( timeText );
        pg.textSize( ampmTextSize );
        float ampmTextWidth = pg.textWidth( ampmText );
        pg.textSize( dateTextSize );
        float dateTextWidth = pg.textWidth( dateText );
  
        pg.clear();
        pg.noStroke();
        pg.fill( bgColor );
        pg.rect( timeX - 0.5*(timeTextWidth+ampmTextWidth)-timeBorderX , timeY - 0.5*timeTextSize - timeBorderY , 
                 timeTextWidth+ampmTextWidth + 2*timeBorderX , timeTextSize + 2*timeBorderY , timeCorner , timeCorner , timeCorner , timeCorner );
        pg.fill( textColor );
        pg.textSize( timeTextSize );
        pg.text( timeText ,  timeX-0.5*(timeTextWidth+ampmTextWidth) , timeY - vertOffset*timeTextSize ); 
        pg.textSize( ampmTextSize );
        pg.text( ampmText ,  timeX-0.5*(timeTextWidth+ampmTextWidth)+timeTextWidth , 
                 timeY - vertOffset*timeTextSize + (timeTextSize-ampmTextSize) + ampmOffset ); 
                 
        pg.fill( bgColor );
        pg.rect( dateX - 0.5*(dateTextWidth)-timeBorderX , dateY - 0.5*dateTextSize - dateBorderY , 
                 dateTextWidth + 2*dateBorderX , dateTextSize + 2*dateBorderY , dateCorner , dateCorner , dateCorner , dateCorner );
        pg.fill( textColor );
        pg.textSize( dateTextSize );
        pg.text( dateText ,  dateX-0.5*(dateTextWidth) , dateY - 0.5*dateTextSize + dateOffset ); 
                 
        
        float weatherWidth = 0.16*width;
        float weatherHeight = 0.30*height;
        float weatherGap = (width-4*weatherWidth)/5.0;
        float weatherY = 0.83*height;
        float weatherCorner = 10;
        float day0_x = weatherGap*1+0.5*weatherWidth;
        float day1_x = weatherGap*2+1.5*weatherWidth;
        float day2_x = weatherGap*3+2.5*weatherWidth;
        float day3_x = weatherGap*4+3.5*weatherWidth;
        
        pg.fill( bgColor );
        pg.rect( day0_x - 0.5*weatherWidth , weatherY - 0.5*weatherHeight , weatherWidth , weatherHeight ,
                 weatherCorner , weatherCorner , weatherCorner , weatherCorner );
        pg.rect( day1_x - 0.5*weatherWidth , weatherY - 0.5*weatherHeight , weatherWidth , weatherHeight ,
                 weatherCorner , weatherCorner , weatherCorner , weatherCorner );
        pg.rect( day2_x - 0.5*weatherWidth , weatherY - 0.5*weatherHeight , weatherWidth , weatherHeight ,
                 weatherCorner , weatherCorner , weatherCorner , weatherCorner );
        pg.rect( day3_x - 0.5*weatherWidth , weatherY - 0.5*weatherHeight , weatherWidth , weatherHeight ,
                 weatherCorner , weatherCorner , weatherCorner , weatherCorner );
                 
        float dayTextSize = 25;
        float dayTextOffset = -60;
        float tempTextSize = 25;
        float tempTextOffset = 30;
        float windTextSize = 15;
        float windTextOffset = 55;
        float iconOffset = -35;
        float iconSize = icon0.width;
        
        pg.fill( textColor );
        pg.textAlign( CENTER , CENTER );
        pg.textSize( dayTextSize );
        pg.text( day0_dateText , day0_x , weatherY + dayTextOffset );
        pg.text( day1_dateText , day1_x , weatherY + dayTextOffset );
        pg.text( day2_dateText , day2_x , weatherY + dayTextOffset );
        pg.text( day3_dateText , day3_x , weatherY + dayTextOffset );
        pg.textSize( tempTextSize );
        pg.text( day0_tempText , day0_x , weatherY + tempTextOffset );
        pg.text( day1_tempText , day1_x , weatherY + tempTextOffset );
        pg.text( day2_tempText , day2_x , weatherY + tempTextOffset );
        pg.text( day3_tempText , day3_x , weatherY + tempTextOffset );
        pg.textSize( windTextSize );
        pg.text( day0_windText , day0_x , weatherY + windTextOffset );
        pg.text( day1_windText , day1_x , weatherY + windTextOffset );
        pg.text( day2_windText , day2_x , weatherY + windTextOffset );
        pg.text( day3_windText , day3_x , weatherY + windTextOffset );
        if( hour() >= sunsetHour - 1 ) {
          pg.image( icon0Night , day0_x - 0.5*iconSize , weatherY + iconOffset );
        } else {
          pg.image( icon0 , day0_x - 0.5*iconSize , weatherY + iconOffset );
        }
        pg.image( icon1 , day1_x - 0.5*iconSize , weatherY + iconOffset );
        pg.image( icon2 , day2_x - 0.5*iconSize , weatherY + iconOffset );
        pg.image( icon3 , day3_x - 0.5*iconSize , weatherY + iconOffset );
        
        
        pg.endDraw();
      }
      image(pg , 0 , 0 );
    }
    
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////
    // CLOCK TYPE 1 ///////////////////////////////////////////////////////////////////////////////////////////////
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////
    if( clockID == 1 ) {
      if( minuteChanged || resetClock ) {
        minuteChanged = false;
        resetClock = false;
        pg.beginDraw();
        pg.textAlign( LEFT , TOP );
        // values
        float timeCorner = 20;
        color bgColor = color( 0 , 0 , 0 , 160 );
        color textColor = color( 255 , 255 , 255 , 196 );
        float timeBorderX = 10;
        float timeBorderY = 0;
        float timeX = halfWidth;
        float timeY = halfHeight;
        float timeTextSize = 100;
        float ampmTextSize = 40;
        float vertOffset = 0.6;
        float ampmOffset = -10;
        String timeText = hour()%12 + ":" + nf(minute(),2);
        String ampmText = " am";
        if( hour() > 12 ) { ampmText = " pm"; }
        
        pg.textFont(font1);
        pg.textSize( timeTextSize );
        float timeTextWidth = pg.textWidth( timeText );
        pg.textSize( ampmTextSize );
        float ampmTextWidth = pg.textWidth( ampmText );
  
        pg.clear();
        pg.noStroke();
        pg.fill( bgColor );
        pg.rect( timeX - 0.5*(timeTextWidth+ampmTextWidth)-timeBorderX , timeY - 0.5*timeTextSize - timeBorderY , 
                 timeTextWidth+ampmTextWidth + 2*timeBorderX , timeTextSize + 2*timeBorderY , timeCorner , timeCorner , timeCorner , timeCorner );
        pg.fill( textColor );
        pg.textSize( timeTextSize );
        pg.text( timeText ,  timeX-0.5*(timeTextWidth+ampmTextWidth) , timeY - vertOffset*timeTextSize ); 
        pg.textSize( ampmTextSize );
        pg.text( ampmText ,  timeX-0.5*(timeTextWidth+ampmTextWidth)+timeTextWidth , 
                 timeY - vertOffset*timeTextSize + (timeTextSize-ampmTextSize) + ampmOffset ); 
        pg.endDraw();
      }
      image(pg , 0 , 0 );
    }
    
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////
    // CLOCK TYPE 2 ///////////////////////////////////////////////////////////////////////////////////////////////
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////
    if( clockID == 2  ) {
      if(  minuteChanged || resetClock ) {
        minuteChanged = false;
        resetClock = false;
        pg.beginDraw();
        pg.textAlign( LEFT , TOP );
        // values
        float timeCorner = 40;
        color bgColor = color( 0 , 0 , 0 , 160 );
        color textColor = color( 255 , 255 , 255 , 196 );
        float timeBorderX = 10;
        float timeBorderY = -10;
        float timeX = halfWidth;
        float timeY = halfHeight;
        float timeTextSize = 200;
        float ampmTextSize = 40;
        float vertOffset = 0.6;
        float ampmOffset = -10;
        String timeText = hour()%12 + ":" + nf(minute(),2);
        String ampmText = " am";
        if( hour() > 12 ) { ampmText = " pm"; }
        
        pg.textFont(font1);
        pg.textSize( timeTextSize );
        float timeTextWidth = pg.textWidth( timeText );
        pg.textSize( ampmTextSize );
        float ampmTextWidth = pg.textWidth( ampmText );
  
        pg.clear();
        pg.noStroke();
        pg.fill( bgColor );
        pg.rect( timeX - 0.5*(timeTextWidth+ampmTextWidth)-timeBorderX , timeY - 0.5*timeTextSize - timeBorderY , 
                 timeTextWidth+ampmTextWidth + 2*timeBorderX , timeTextSize + 2*timeBorderY , timeCorner , timeCorner , timeCorner , timeCorner );
        pg.fill( textColor );
        pg.textSize( timeTextSize );
        pg.text( timeText ,  timeX-0.5*(timeTextWidth+ampmTextWidth) , timeY - vertOffset*timeTextSize ); 
        pg.textSize( ampmTextSize );
        pg.text( ampmText ,  timeX-0.5*(timeTextWidth+ampmTextWidth)+timeTextWidth , 
                 timeY - vertOffset*timeTextSize + (timeTextSize-ampmTextSize) + ampmOffset ); 
        pg.endDraw();
      }
      image(pg , 0 , 0 );
    }
    
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////
    // CLOCK TYPE 3 ///////////////////////////////////////////////////////////////////////////////////////////////
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////
    if( clockID == 3 ) {
      // no clock
    }
    
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////
    // CLOCK TYPE 4 ///////////////////////////////////////////////////////////////////////////////////////////////
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////
    if( clockID == 4 ) {
      if( minuteChanged || resetClock ) {
        resetClock = false;
        minuteChanged = false;
        pg.beginDraw();
        pg.textAlign( LEFT , TOP );
        // values
        float timeCorner = 20;
        float dateCorner = 10;
        color bgColor = color( 0 , 0 , 0 , 160 );
        color textColor = color( 255 , 255 , 255 , 196 );
        float timeBorderX = 10;
        float timeBorderY = 0;
        float timeX = halfWidth;
        float timeY = halfHeight;
        float dateBorderX = 10;
        float dateBorderY = 5;
        float dateX = halfWidth;
        float dateY = height*0.8;
        float timeTextSize = 100;
        float ampmTextSize = 40;
        float dateTextSize = 40;
        float vertOffset = 0.6;
        float ampmOffset = -10;
        float dateOffset = -4;
        String timeText = hour()%12 + ":" + nf(minute(),2);
        String ampmText = " am";
        if( hour() > 12 ) { ampmText = " pm"; }
        String dateText = dayOfTheWeek(month(),day(),year()) + ", " + monthText[month()-1] + " " + day(); 
        println(dateText);
        
        pg.textFont(font1);
        pg.textSize( timeTextSize );
        float timeTextWidth = pg.textWidth( timeText );
        pg.textSize( ampmTextSize );
        float ampmTextWidth = pg.textWidth( ampmText );
        pg.textSize( dateTextSize );
        float dateTextWidth = pg.textWidth( dateText );
  
        pg.clear();
        pg.noStroke();
        pg.fill( bgColor );
        pg.rect( timeX - 0.5*(timeTextWidth+ampmTextWidth)-timeBorderX , timeY - 0.5*timeTextSize - timeBorderY , 
                 timeTextWidth+ampmTextWidth + 2*timeBorderX , timeTextSize + 2*timeBorderY , timeCorner , timeCorner , timeCorner , timeCorner );
        pg.fill( textColor );
        pg.textSize( timeTextSize );
        pg.text( timeText ,  timeX-0.5*(timeTextWidth+ampmTextWidth) , timeY - vertOffset*timeTextSize ); 
        pg.textSize( ampmTextSize );
        pg.text( ampmText ,  timeX-0.5*(timeTextWidth+ampmTextWidth)+timeTextWidth , 
                 timeY - vertOffset*timeTextSize + (timeTextSize-ampmTextSize) + ampmOffset ); 
                 
        pg.fill( bgColor );
        pg.rect( dateX - 0.5*(dateTextWidth)-timeBorderX , dateY - 0.5*dateTextSize - dateBorderY , 
                 dateTextWidth + 2*dateBorderX , dateTextSize + 2*dateBorderY , dateCorner , dateCorner , dateCorner , dateCorner );
        pg.fill( textColor );
        pg.textSize( dateTextSize );
        pg.text( dateText ,  dateX-0.5*(dateTextWidth) , dateY - 0.5*dateTextSize + dateOffset ); 
                 
        
        pg.endDraw();
      }
      image(pg , 0 , 0 );
    }
    
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////
    // CLOCK TYPE 5 ///////////////////////////////////////////////////////////////////////////////////////////////
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////
    if( clockID == 5  ) {
      if( minuteChanged || resetClock ) {
        resetClock = false;
        minuteChanged = false;
        pg.beginDraw();
        pg.textAlign( LEFT , TOP );
        // values
        float timeCorner = 20;
        float dateCorner = 10;
        color bgColor = color( 0 , 0 , 0 , 160 );
        color textColor = color( 255 , 255 , 255 , 196 );
        float timeBorderX = 10;
        float timeBorderY = -20;
        float timeX = halfWidth;
        float timeY = halfHeight;
        float dateBorderX = 10;
        float dateBorderY = 5;
        float dateX = halfWidth;
        float dateY = height*0.9;
        float timeTextSize = 200;
        float ampmTextSize = 40;
        float dateTextSize = 40;
        float vertOffset = 0.6;
        float ampmOffset = -10;
        float dateOffset = -4;
        String timeText = hour()%12 + ":" + nf(minute(),2);
        String ampmText = " am";
        if( hour() > 12 ) { ampmText = " pm"; }
        String dateText = dayOfTheWeek(month(),day(),year()) + ", " + monthText[month()-1] + " " + day(); 
        println(dateText);
        
        pg.textFont(font1);
        pg.textSize( timeTextSize );
        float timeTextWidth = pg.textWidth( timeText );
        pg.textSize( ampmTextSize );
        float ampmTextWidth = pg.textWidth( ampmText );
        pg.textSize( dateTextSize );
        float dateTextWidth = pg.textWidth( dateText );
  
        pg.clear();
        pg.noStroke();
        pg.fill( bgColor );
        pg.rect( timeX - 0.5*(timeTextWidth+ampmTextWidth)-timeBorderX , timeY - 0.5*timeTextSize - timeBorderY , 
                 timeTextWidth+ampmTextWidth + 2*timeBorderX , timeTextSize + 2*timeBorderY , timeCorner , timeCorner , timeCorner , timeCorner );
        pg.fill( textColor );
        pg.textSize( timeTextSize );
        pg.text( timeText ,  timeX-0.5*(timeTextWidth+ampmTextWidth) , timeY - vertOffset*timeTextSize ); 
        pg.textSize( ampmTextSize );
        pg.text( ampmText ,  timeX-0.5*(timeTextWidth+ampmTextWidth)+timeTextWidth , 
                 timeY - vertOffset*timeTextSize + (timeTextSize-ampmTextSize) + ampmOffset ); 
                 
        pg.fill( bgColor );
        pg.rect( dateX - 0.5*(dateTextWidth)-timeBorderX , dateY - 0.5*dateTextSize - dateBorderY , 
                 dateTextWidth + 2*dateBorderX , dateTextSize + 2*dateBorderY , dateCorner , dateCorner , dateCorner , dateCorner );
        pg.fill( textColor );
        pg.textSize( dateTextSize );
        pg.text( dateText ,  dateX-0.5*(dateTextWidth) , dateY - 0.5*dateTextSize + dateOffset ); 
                 
        
        pg.endDraw();
      }
      image(pg , 0 , 0 );
    }
    
    
  }
  
  void updateAstronomy() {
    astro = loadXML( API_URL_astronomy );
    sunriseHour = Integer.parseInt(astro.getChild("sun_phase/sunrise/hour").getContent("hour"));
    sunsetHour = Integer.parseInt(astro.getChild("sun_phase/sunset/hour").getContent("hour"));
    println("---");
    println( "sunriseHour = " + sunriseHour + "  ;  sunsetHour = " + sunsetHour );
    println("UPDATED ASTRONOMY AT " + hour() + ":" + nf(minute(),2) + ":" + nf(second(),2) );
    println( API_URL_astronomy );
  }
  
  void updateWeather() {
    w = loadXML( API_URL_forecast );
    day0_dayName = w.getChild("forecast/simpleforecast/forecastdays").getChild(1).getChild("date/weekday_short").getContent("weekday_short");
    day0_dayNum = w.getChild("forecast/simpleforecast/forecastdays").getChild(1).getChild("date/day").getContent("day");
    day0_high = w.getChild("forecast/simpleforecast/forecastdays").getChild(1).getChild("high/fahrenheit").getContent("fahrenheit");
    day0_low = w.getChild("forecast/simpleforecast/forecastdays").getChild(1).getChild("low/fahrenheit").getContent("fahrenheit");
    day0_icon_url = w.getChild("forecast/simpleforecast/forecastdays").getChild(1).getChild("icon_url").getContent("icon_url");
    day0_icon_url_night = w.getChild("forecast/txt_forecast/forecastdays").getChild(3).getChild("icon_url").getContent("icon_url");
    day0_windavg = w.getChild("forecast/simpleforecast/forecastdays").getChild(1).getChild("avewind/mph").getContent("mph");
    day0_winddir = w.getChild("forecast/simpleforecast/forecastdays").getChild(1).getChild("avewind/dir").getContent("dir");
    icon0 = loadImage( day0_icon_url );
    icon0Night = loadImage( day0_icon_url_night );
    day0_dateText = ( day0_dayName + " | " + day0_dayNum );
    day0_tempText = ( day0_high + " | " + day0_low );
    day0_windText = ( day0_winddir + " at " + day0_windavg + " mph" );
    println( day0_dayName + " , " + day0_dayNum );
    println( day0_high + " | " + day0_low );
    println( day0_icon_url );
    println( day0_winddir + " at " + day0_windavg + " mph" );
    println( "-----" );
    
    day1_dayName = w.getChild("forecast/simpleforecast/forecastdays").getChild(3).getChild("date/weekday_short").getContent("weekday_short");
    day1_dayNum = w.getChild("forecast/simpleforecast/forecastdays").getChild(3).getChild("date/day").getContent("day");
    day1_high = w.getChild("forecast/simpleforecast/forecastdays").getChild(3).getChild("high/fahrenheit").getContent("fahrenheit");
    day1_low = w.getChild("forecast/simpleforecast/forecastdays").getChild(3).getChild("low/fahrenheit").getContent("fahrenheit");
    day1_icon_url = w.getChild("forecast/simpleforecast/forecastdays").getChild(3).getChild("icon_url").getContent("icon_url");
    day1_windavg = w.getChild("forecast/simpleforecast/forecastdays").getChild(3).getChild("avewind/mph").getContent("mph");
    day1_winddir = w.getChild("forecast/simpleforecast/forecastdays").getChild(3).getChild("avewind/dir").getContent("dir");
    icon1 = loadImage( day1_icon_url );
    day1_dateText = ( day1_dayName + " | " + day1_dayNum );
    day1_tempText = ( day1_high + " | " + day1_low );
    day1_windText = ( day1_winddir + " at " + day1_windavg + " mph" );
    println( day1_dayName + " , " + day1_dayNum );
    println( "hi: " + day1_high + " | lo: " + day1_low );
    println( day1_icon_url );
    println( day1_winddir + " at " + day1_windavg + " mph" );
    println( "-----" );
    
    day2_dayName = w.getChild("forecast/simpleforecast/forecastdays").getChild(5).getChild("date/weekday_short").getContent("weekday_short");
    day2_dayNum = w.getChild("forecast/simpleforecast/forecastdays").getChild(5).getChild("date/day").getContent("day");
    day2_high = w.getChild("forecast/simpleforecast/forecastdays").getChild(5).getChild("high/fahrenheit").getContent("fahrenheit");
    day2_low = w.getChild("forecast/simpleforecast/forecastdays").getChild(5).getChild("low/fahrenheit").getContent("fahrenheit");
    day2_icon_url = w.getChild("forecast/simpleforecast/forecastdays").getChild(5).getChild("icon_url").getContent("icon_url");
    day2_windavg = w.getChild("forecast/simpleforecast/forecastdays").getChild(5).getChild("avewind/mph").getContent("mph");
    day2_winddir = w.getChild("forecast/simpleforecast/forecastdays").getChild(5).getChild("avewind/dir").getContent("dir");
    icon2 = loadImage( day2_icon_url );
    day2_dateText = ( day2_dayName + " | " + day2_dayNum );
    day2_tempText = ( day2_high + " | " + day2_low );
    day2_windText = ( day2_winddir + " at " + day2_windavg + " mph" );
    println( day2_dayName + " , " + day2_dayNum );
    println( "high: " + day2_high + " | low: " + day2_low );
    println( day2_icon_url );
    println( day2_winddir + " at " + day2_windavg + " mph" );
    println( "-----" );
    
    day3_dayName = w.getChild("forecast/simpleforecast/forecastdays").getChild(7).getChild("date/weekday_short").getContent("weekday_short");
    day3_dayNum = w.getChild("forecast/simpleforecast/forecastdays").getChild(7).getChild("date/day").getContent("day");
    day3_high = w.getChild("forecast/simpleforecast/forecastdays").getChild(7).getChild("high/fahrenheit").getContent("fahrenheit");
    day3_low = w.getChild("forecast/simpleforecast/forecastdays").getChild(7).getChild("low/fahrenheit").getContent("fahrenheit");
    day3_icon_url = w.getChild("forecast/simpleforecast/forecastdays").getChild(7).getChild("icon_url").getContent("icon_url");
    day3_windavg = w.getChild("forecast/simpleforecast/forecastdays").getChild(7).getChild("avewind/mph").getContent("mph");
    day3_winddir = w.getChild("forecast/simpleforecast/forecastdays").getChild(7).getChild("avewind/dir").getContent("dir");
    icon3 = loadImage( day3_icon_url );
    day3_dateText = ( day3_dayName + " | " + day3_dayNum );
    day3_tempText = ( day3_high + " | " + day3_low );
    day3_windText = ( day3_winddir + " at " + day3_windavg + " mph" );
    println( day3_dayName + " , " + day3_dayNum );
    println( "high: " + day3_high + " | low: " + day3_low );
    println( day3_icon_url );
    println( day3_winddir + " at " + day3_windavg + " mph" );
    println( "-----" );
    
    println("UPDATED WEATHER AT " + hour() + ":" + nf(minute(),2) + ":" + nf(second(),2) );
    println( API_URL_forecast );
    
  }
  
}




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