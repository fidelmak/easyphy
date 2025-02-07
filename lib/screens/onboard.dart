import 'package:easyphy/screens/unit_quiz_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../widgets/custom_button.dart';
import 'display_screen.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<String> images = [
    'assets/images/onb1.jpg',
    'assets/images/onb2.jpg',
    'assets/images/onb3.jpg',
  ];

  final List<String> bText = [
    "Learn Physics Units",
    "Take Quiz",
    "Learn Formulars",
  ];

  final List<String> secondText = [
    "Learn The Basics of Physics Units",
    "Test Your Knowledge with our Quiz",
    "Learn Formulas for Physics",
  ];

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
            height: screenHeight * 0.60, // Adjusted to 60% of screen height
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                });
              },
              itemCount: images.length,
              itemBuilder: (context, index) {
                return ClipPath(
                  clipper: CurveClipper(),
                  child: Container(
                    width: screenWidth,
                    height:
                        screenHeight * 0.60, // Adjusted to 60% of screen height
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(images[index]),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(8.0.sp),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: screenWidth / 1.2,
                    child: Text(
                      bText[_currentPage],
                      style: TextStyle(
                        fontFamily: 'ZCOOLXiaoWei',
                        fontWeight: FontWeight.w400,
                        fontSize: 24.sp, // Adjusted font size
                        color: Colors.black,
                        height: 1.2, // Reduced text height spacing to 1.2
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: 8.sp),
                  SizedBox(
                    width: screenWidth / 1.2,
                    child: Text(
                      secondText[_currentPage],
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w400,
                        fontSize: 14.sp, // Adjusted font size
                        color: Colors.grey,
                        height: 1.2, // Reduced text height spacing to 1.2
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: 20.sp),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(images.length, (index) {
                      return GestureDetector(
                        onTap: () {
                          _pageController.animateToPage(
                            index,
                            duration: Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        },
                        child: Container(
                          width: _currentPage == index ? 30.sp : 10.sp,
                          height: 2.sp,
                          margin: EdgeInsets.symmetric(
                              horizontal: 2.sp), // Reduced gap between dots
                          decoration: BoxDecoration(
                            color: _currentPage == index
                                ? Colors.black
                                : Colors.grey,
                            borderRadius: BorderRadius.circular(5.r),
                          ),
                        ),
                      );
                    }),
                  ),
                  SizedBox(height: 10.sp),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (ctx) {
                        return DisplayScreen();
                      }));
                    },
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      minimumSize: Size(260.sp, 48.sp), // Adjusted button size
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(5.r), // Radius applied
                        side: BorderSide(
                            color: Colors.black87, width: 1.5), // Outline style
                      ),
                    ),
                    child: Text(
                      "Let's Get Started",
                      style: TextStyle(
                        color: Colors.black87,
                        fontFamily: "Montserrat",
                        fontWeight: FontWeight.w600,
                        fontSize: 16.sp, // Adjusted font size
                      ),
                    ),
                  ),
                  SizedBox(height: 10.sp),
                  CustomButton(
                    text: 'Take Quiz',
                    press: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (ctx) => QuizScreen()));
                    },
                  ),
                  SizedBox(height: 20.sp)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Custom Clipper for the curved bottom
class CurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height - 80);
    path.quadraticBezierTo(
      size.width / 2,
      size.height + 30,
      size.width,
      size.height - 80,
    );
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
