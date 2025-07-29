import 'dart:async';

import 'package:easyphy/screens/onBoarding/onboard.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// Import the onboarding screen

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToOnboarding();
  }

  Future<void> _navigateToOnboarding() async {
    await Future.delayed(Duration(seconds: 5), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => OnboardingScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    bool isDesktop = screenWidth > 600;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFFFFFFF), // Dark grey
              Color(0xFFFFFFFF),
              Color(0xFFFFFFFF) // Medium grey
              // Light grey// Light purple
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: isDesktop
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Text("Gratitude to Muslim Community Grammar School",
                        style: TextStyle(
                            fontSize: 12.sp,
                            fontStyle: FontStyle.italic,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w200,
                            color: Colors.black)),
                  ),
                ],
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                      child: ClipOval(
                    child: Image.asset(
                      'assets/images/logo.jpg',
                      width: 275.sp,
                      height: 278.sp,
                      fit: BoxFit.contain,
                    ),
                  )),
                  Center(
                    child: Text("Start Learning Today",
                        style: TextStyle(
                            fontSize: 12.sp,
                            fontStyle: FontStyle.italic,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w200,
                            color: Colors.black)),
                  ),
                ],
              ),
      ),
    );
  }
}
