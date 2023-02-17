import 'package:a2d_app/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime date = DateTime.now();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Stack(
          children: [
            Container(
              width: size.width,
              height: size.height,
              decoration: BoxDecoration(
                gradient: AppColors.appGradient,
              ),
            ),
            SingleChildScrollView(
              physics: AppColors.scrollPhysics,
              child: SafeArea(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      children: [
                        Row(
                          children: [
                            Image.asset("assets/map.png"),
                            DropdownButton(
                              items: [],
                              onChanged: ((val) {}),
                            ),
                          ],
                        )
                      ],
                    ),
                    Image.asset(
                      "assets/cloudy - Edited.png",
                      scale: 0.5,
                    ),
                    Container(
                      width: size.width,
                      margin: EdgeInsets.only(
                        left: 25,
                        right: 25,
                        bottom: 40,
                      ),
                      padding: EdgeInsets.only(
                        left: 15,
                        right: 15,
                        top: 10,
                        bottom: 15,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.white.withOpacity(0.4),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        children: [
                          Text(
                            "Today, ${date.day} ${DateFormat.MMMM().format(date)}",
                            style: TextStyle(
                              color: AppColors.white,
                              fontSize: 18,
                            ),
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "29",
                                style: TextStyle(
                                    fontSize: 100,
                                    color: AppColors.white,
                                    shadows: [
                                      Shadow(
                                        color: AppColors.black.withOpacity(0.2),
                                        blurRadius: 30,
                                        offset: Offset(-10, 5),
                                      ),
                                    ]),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: Image.asset("assets/° - Edited.png"),
                              ),
                            ],
                          ),
                          Text(
                            "Cloudy",
                            style: TextStyle(
                              color: AppColors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 15,
                              left: 10,
                              right: 10,
                              bottom: 5,
                            ),
                            child: Column(
                              children: [
                                WeatherField(
                                  head: "Time",
                                  data: "06:00 AM",
                                ),
                                WeatherField(
                                  head: "Temperature",
                                  data: "06:00 AM",
                                ),
                                WeatherField(
                                  head: "MaxTemperature",
                                  data: "06:00 AM",
                                ),
                                WeatherField(
                                  head: "MinTemperature",
                                  data: "06:00 AM",
                                ),
                                WeatherField(
                                  head: "Condition",
                                  data: "06:00 AM",
                                ),
                                WeatherField(
                                  head: "WindSpeed",
                                  data: "06:00 AM",
                                ),
                                WeatherField(
                                  head: "Humanity",
                                  data: "06:00 AM",
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        bottom: 40,
                        left: size.width / 5,
                        right: size.width / 5,
                      ),
                      height: 64,
                      decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                                color: AppColors.black.withOpacity(0.1),
                                spreadRadius: 1,
                                blurRadius: 3,
                                offset: Offset(-7, 5))
                          ]),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Forecast report"),
                          SizedBox(
                            width: 20,
                          ),
                          Transform.scale(
                            scaleX: -1,
                            child: Image.asset(
                              "assets/success-page-icon.png",
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class WeatherField extends StatelessWidget {
  WeatherField({
    super.key,
    required this.head,
    required this.data,
  });

  String head = '';
  String data = '';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(
                CupertinoIcons.wind,
                color: AppColors.white,
                size: 27,
              ),
              SizedBox(
                width: 20,
              ),
              Text(
                head,
                style: TextStyle(
                  color: AppColors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
          Text(
            data,
            style: TextStyle(
              color: AppColors.white,
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
