import 'package:a2d_app/screens/signup_screen.dart';
import 'package:a2d_app/styles.dart';
import 'package:flutter/material.dart';

class SuccessScreen extends StatelessWidget {
  const SuccessScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: AppColors.backgroundColour,
        body: Padding(
          padding: const EdgeInsets.only(
            bottom: 50,
            top: 10,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image.asset("assets/congrats-page-logo.png"),
              Image.asset("assets/success-page-message.png"),
              InkWell(
                onTap: (() {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (nextPageContext) => SignUpScreen(pageIndex: 1),
                    ),
                  );
                }),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset("assets/success-page-icon.png"),
                    const SizedBox(
                      width: 10,
                    ),
                    Text("Back to Login"),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
