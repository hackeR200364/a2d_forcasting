import 'package:a2d_app/screens/login_screen.dart';
import 'package:a2d_app/screens/signup_screen.dart';
import 'package:a2d_app/styles.dart';
import 'package:flutter/material.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Stack(
          children: [
            Positioned(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      AppColors.onBoardingColour1,
                      AppColors.onBoardingColour2,
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              top: 1,
              left: 0,
              right: 0,
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: Image.asset(
                  "assets/on-board-bg.png",
                  fit: BoxFit.contain,
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                margin: EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 25,
                ),
                padding: EdgeInsets.only(
                  left: 15,
                  right: 15,
                  top: 45,
                  bottom: 10,
                ),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Column(
                  children: [
                    Text(
                      "Expore global map of wind, weather, and ocean conditions",
                      overflow: TextOverflow.clip,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      "Planing your trip become more easier with ideate weather app. you can instantly see the whole word weather within few second",
                      overflow: TextOverflow.clip,
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.onBoardSubTextColour,
                      ),
                    ),
                    SizedBox(
                      height: 70,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: InkWell(
                        onTap: (() {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (nextPageContext) => SignUpScreen(
                                pageIndex: 0,
                              ),
                            ),
                          );
                        }),
                        child: Container(
                          width: double.infinity,
                          height: 60,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                AppColors.onBoardingColour1,
                                AppColors.onBoardingColour2,
                              ],
                            ),
                          ),
                          child: Center(
                            child: Text(
                              "Get started",
                              style: TextStyle(
                                color: AppColors.white,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Already have an account ?"),
                        Container(
                          child: InkWell(
                            onTap: (() {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (nextPageContext) => LoginScreen(),
                                ),
                              );
                            }),
                            child: Text(
                              " Log in",
                              style: TextStyle(
                                  color: AppColors.blue,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
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
