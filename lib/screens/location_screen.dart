import 'package:clima_app/screens/city_screen.dart';
import 'package:clima_app/services/weather.dart';
import 'package:flutter/material.dart';
import '../utilities/constants.dart';

class LocationScreen extends StatefulWidget {

   LocationScreen({this.locationWeather});

   final locationWeather;
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {

  WeatherModel weather = WeatherModel();

   String? weatherIcon;
   String? cityName;
   int? temperature;
   String? weatherMessage;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    print(widget.locationWeather);
    updateUI(widget.locationWeather);
  }

  void updateUI(dynamic weatherData){
    setState(() {
      if(weatherData == null){
        temperature = 0;
        weatherIcon = "Error";
        weatherMessage = "Unable to get weather data";
        cityName = '';
        return;
      }
       var condition = weatherData["weather"][0]["id"];
   print(condition);
   weatherIcon = weather.getWeatherIcon(condition);

   cityName = weatherData["name"];

   double temp = weatherData["main"]["temp"];
   temperature = temp.toInt();
   print(temperature);

   var conditionMessgae = weatherData["weather"][0]["description"];
   weatherMessage = weather.getMessage(temperature ?? 0);
   print(conditionMessgae);
  
    });
  

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  ElevatedButton(
                    onPressed: () async {
                      var weatherData = await weather.getLocationWeather();
                      updateUI(weatherData);
                    },
                    child: Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                    var typedName = await Navigator.push(context, MaterialPageRoute(builder: (context)=>CityScreen()));
                    print(typedName);

                    if(typedName != null){
                      var weatherData = await weather.getCityWeather(typedName);
                      updateUI(weatherData);
                    }
                    },
                    child: Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      '$temperature°',
                      style: kTempTextStyle,
                    ),
                    Text(
                      weatherIcon ?? "Nothing",
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 15.0, bottom: 15),
                child: Text(
                  "$weatherMessage in $cityName!",
                  textAlign: TextAlign.right,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
