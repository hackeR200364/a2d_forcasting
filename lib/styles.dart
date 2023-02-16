import 'package:flutter/material.dart';

class AppColors {
  static const backgroundColour = Color(0xFFE7E7E7);
  static const onBoardingColour1 = Color(0xFF47BFDF);
  static const onBoardingColour2 = Color(0xFF4A91FF);
  static const white = Color(0xFFFFFFFF);
  static const onBoardSubTextColour = Color(0xFF6B6A71);
  static const blue = Colors.blue;
  static const black = Colors.black;
  static const grey = Colors.grey;
  static const disableButtonColour = Color(0xFFD9D9D9);
  static const appGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      AppColors.onBoardingColour1,
      AppColors.onBoardingColour2,
    ],
  );
  static const scrollPhysics = BouncingScrollPhysics();
}
