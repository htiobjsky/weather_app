import 'package:chef_weather_app/model/model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:timer_builder/timer_builder.dart';

class WeatherScreen extends StatefulWidget {
  final dynamic parseWeatherData;
  final dynamic parseAirPollution;

  const WeatherScreen({Key key, this.parseWeatherData, this.parseAirPollution}) : super(key: key);

  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  Model model = Model();
  String cityName;
  int temp;
  Widget icon;
  String des;
  Widget airIcon;
  Widget airState;
  double dust1;
  double dust2;
  var date = DateTime.now();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    updateData(widget.parseWeatherData, widget.parseAirPollution);
  }

  void updateData(dynamic weatherData, dynamic airData) {
    double temp2 = weatherData["main"]["temp"];
    int condition = weatherData["weather"][0]["id"];
    des = weatherData["weather"][0]["description"];
    int index = airData["list"][0]["main"]["aqi"];
    dust1 = airData["list"][0]["components"]["pm10"];
    dust2 = airData["list"][0]["components"]["pm2_5"];
    //temp = temp2.toInt();
    temp = temp2.round();
    cityName = weatherData["name"];
    icon = model.getWeatherIcon(condition);
    airIcon = model.getAirIcon(index);
    airState = model.getAirCondition(index);

  }

  String getSystemTime() {
    var now = DateTime.now();
    return DateFormat("hh:mm a").format(now);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        //title: Text(""),
        leading: IconButton(
          icon: Icon(Icons.near_me),
          onPressed: () {},
          iconSize: 30.0,
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.location_searching),
            onPressed: () {},
            iconSize: 30.0,
          ),
        ],
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        child: Stack(
          children: [
            Image.asset(
              "image/background.jpg",
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
            SafeArea(
              child: Container(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 150,
                              ),
                              Text(
                                "$cityName",
                                style: GoogleFonts.lato(
                                    fontSize: 50,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                              Row(
                                children: [
                                  TimerBuilder.periodic(
                                    Duration(minutes: 1),
                                    builder: (context) {
                                      print("${getSystemTime()}");
                                      return Text(
                                        "${getSystemTime()}",
                                        style: GoogleFonts.lato(
                                          fontSize: 16,
                                          color: Colors.white,
                                        ),
                                      );
                                    },
                                  ),
                                  Text(
                                    DateFormat(" - EEEE, ").format(date),
                                    style: GoogleFonts.lato(
                                      fontSize: 16,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text(
                                    DateFormat("d MMM, yyy").format(date),
                                    style: GoogleFonts.lato(
                                      fontSize: 16,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "$temp\u2103",
                                style: GoogleFonts.lato(
                                    fontSize: 90,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white),
                              ),
                              Row(
                                children: [
                                  icon,
                                  SizedBox(
                                    width: 15,
                                  ),
                                  Text(
                                    "$des",
                                    style: GoogleFonts.lato(
                                        fontSize: 20,
                                        color: Colors.white),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        Divider(
                          height: 15,
                          thickness: 2,
                          color: Colors.white30,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                Text(
                                  "AQI(대기질지수)",
                                  style: GoogleFonts.lato(
                                      fontSize: 16,
                                      color: Colors.white),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                airIcon,
                                SizedBox(
                                  height: 10,
                                ),
                                airState,
                              ],
                            ),
                            Column(
                              children: [
                                Text(
                                  "미세먼지",
                                  style: GoogleFonts.lato(
                                      fontSize: 16,
                                      color: Colors.white),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "$dust1",
                                  style: GoogleFonts.lato(
                                      fontSize: 24,
                                      color: Colors.white),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "ug/m3",
                                  style: GoogleFonts.lato(
                                    fontSize: 14,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Text(
                                  "초미세먼지",
                                  style: GoogleFonts.lato(
                                      fontSize: 16,
                                      color: Colors.white),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "$dust2",
                                  style: GoogleFonts.lato(
                                      fontSize: 24,
                                      color: Colors.white),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "ug/m3",
                                  style: GoogleFonts.lato(
                                    fontSize: 14,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
