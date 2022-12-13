import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weatherapitest/services/weather_service.dart';

import 'model/weather.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  WeatherService weatherService = WeatherService();
  Weather weather = Weather();

  String currentWeather = "";
  String locationName = "";
  String locationCountry = "";
  double tempC = 0;
  double tempF = 0;
  double uv = 0;
  double windKPH = 0;
  int isDay = 0;
  DateTime now = DateTime.now();

  @override
  void initState() {
    super.initState();
    getWeather();
    Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        now = DateTime.now();
      });
    });
  }

  void getWeather() async {
    weather = await weatherService.getWeatherData("London");

    setState(() {
      currentWeather = weather.condition;
      locationName = weather.location;
      locationCountry = weather.country;
      tempF = weather.temperatureF;
      tempC = weather.temperatureC;
      uv = weather.uv;
      windKPH = weather.windKPH;
      isDay = weather.isDay;
    });
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: screenHeight,
            width: screenWidth,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  "assets/images/${isDay == 1 ? "day" : "night"}.jpg",
                ),
                fit: BoxFit.cover,
              ),
            ),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
              child: Container(
                color: Colors.transparent,
              ),
            ),
          ),
          SafeArea(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      SizedBox(height: screenHeight / 15,),
                      Text(
                        currentWeather,
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: "Montserrat",
                          fontWeight: FontWeight.w700,
                          fontSize: screenWidth / 14,
                        ),
                      ),
                      Text(
                        "$locationName, $locationCountry",
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: "Montserrat",
                          fontSize: screenWidth / 20,
                        ),
                      ),
                      Text(
                        "${tempC.toString()}°c",
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: "Montserrat",
                          fontWeight: FontWeight.w700,
                          fontSize: screenWidth / 5,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        "$uv UV | $windKPH KPH",
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: "Montserrat",
                          fontSize: screenWidth / 20,
                        ),
                      ),
                      Text(
                        DateFormat("EEE, dd MMM").format(now),
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: "Montserrat",
                          fontWeight: FontWeight.w700,
                          fontSize: screenWidth / 14,
                        ),
                      ),
                      Text(
                        DateFormat("HH:mm:ss").format(now),
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: "Montserrat",
                          fontWeight: FontWeight.w700,
                          fontSize: screenWidth / 10,
                        ),
                      ),
                      SizedBox(height: screenHeight / 15,),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
