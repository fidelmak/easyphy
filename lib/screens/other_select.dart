import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../const/color.dart';
import 'others/definition.dart';
import 'others/formular.dart';
import 'others/law_screen.dart';

class OtherSelect extends StatefulWidget {
  @override
  _SelectCategoryState createState() => _SelectCategoryState();
}

class _SelectCategoryState extends State<OtherSelect> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final size = MediaQuery.of(context).size;
    //ResponsiveLay().scaleWidth(18)
  }

  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<String> images = [
    'assets/images/select.jpg',
  ];

  final List<String> bText = [
    "Units And Quantities",
    "Formulas",
  ];

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // PageView as the background with images
          PageView.builder(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            itemCount: images.length,
            itemBuilder: (context, index) {
              return Stack(
                children: [
                  Image.asset(
                    images[index],
                    width: screenWidth,
                    height: screenHeight,
                    fit: BoxFit.cover,
                  ),
                  Container(
                    width: screenWidth,
                    height: screenHeight,
                    color: Colors.black.withOpacity(0.7), // 70% black overlay
                  ),
                ],
              );
            },
          ),
          // Content over the background
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.sp),
                      child: Column(
                        children: [
                          Center(
                            child: Container(
                              width: 240.sp, //ResponsiveLay().scaleWidth(),
                              child: FittedBox(
                                child: RichText(
                                  textAlign: TextAlign.center,
                                  text: TextSpan(
                                    text: "Practice",
                                    style: TextStyle(
                                      height: 1.4.sp,
                                      fontFamily: 'Montserrat',
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14.sp, // Responsive font size
                                    ),
                                    children: [
                                      TextSpan(
                                        text: " formular",
                                        style: TextStyle(
                                          fontFamily: 'Montserrat',
                                          color: Colors.white,
                                          fontWeight: FontWeight.w400,
                                          fontSize:
                                              14.sp, // Responsive font size
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 20.sp),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (ctx) {
                                return QuizFormular();
                              }));
                            },
                            style: ElevatedButton.styleFrom(
                              elevation: 0,
                              minimumSize: Size(200.sp, 48.sp),
                              backgroundColor: Color(0xffFF2F13),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.r),
                                side: BorderSide(
                                    color: Color(0xffFF2F13), width: 1),
                              ),
                            ),
                            child: FittedBox(
                              child: Text(
                                "Start",
                                style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18.sp,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 20.sp),

                          ////// this
                          Center(
                            child: Container(
                              width: 245.sp, //ResponsiveLay().scaleWidth(),
                              child: FittedBox(
                                child: RichText(
                                  textAlign: TextAlign.center,
                                  text: TextSpan(
                                    text: " Practice Laws",
                                    style: TextStyle(
                                      height: 1.4.sp,
                                      fontFamily: 'Poppins',
                                      color: Colors.white,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 16.sp, // Responsive font size
                                    ),
                                    children: [
                                      TextSpan(
                                        text: ",",
                                        style: TextStyle(
                                          fontFamily: 'Montserrat',
                                          color: mama,
                                          fontWeight: FontWeight.w400,
                                          fontSize:
                                              16.sp, // Responsive font size
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 10.sp),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (ctx) {
                                return QuizLaws();
                              }));
                            },
                            style: ElevatedButton.styleFrom(
                              elevation: 0,
                              minimumSize: Size(200.sp, 48.sp),
                              backgroundColor: mama,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.r),
                                side: BorderSide(color: mama, width: 1.5),
                              ),
                            ),
                            child: Text(
                              "Start",
                              style: TextStyle(
                                fontFamily: 'Montserrat',
                                color: Color(0xff1E1E1E),
                                fontWeight: FontWeight.w600,
                                fontSize: 18.sp,
                              ),
                            ),
                          ),

                          ///////////////
                          ///////////////
                          SizedBox(height: 20.sp),

                          Center(
                            child: Container(
                              width: 245.sp, //ResponsiveLay().scaleWidth(),
                              child: FittedBox(
                                child: RichText(
                                  textAlign: TextAlign.center,
                                  text: TextSpan(
                                    text: "Practice ",
                                    style: TextStyle(
                                      height: 1.4.sp,
                                      fontFamily: 'Poppins',
                                      color: Colors.white,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 18.sp, // Responsive font size
                                    ),
                                    children: [
                                      TextSpan(
                                        text: " Definitions",
                                        style: TextStyle(
                                          fontFamily: 'Montserrat',
                                          color: mama,
                                          fontWeight: FontWeight.w400,
                                          fontSize:
                                              18.sp, // Responsive font size
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 10.sp),

                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (ctx) {
                                return QuizDefinition();
                              }));
                            },
                            style: ElevatedButton.styleFrom(
                              elevation: 0,
                              minimumSize: Size(200.sp, 48.sp),
                              backgroundColor: mama,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.r),
                                side:
                                    BorderSide(color: Colors.white, width: 1.5),
                              ),
                            ),
                            child: Text(
                              " Start",
                              style: TextStyle(
                                fontFamily: 'Montserrat',
                                color: nov,
                                fontWeight: FontWeight.w600,
                                fontSize: 18.sp,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              // Dots indicator
              Padding(
                padding: EdgeInsets.only(bottom: 20.sp),
                child: Row(
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
                        height: 5.sp,
                        margin: EdgeInsets.symmetric(horizontal: 5.sp),
                        decoration: BoxDecoration(
                          color: _currentPage == index
                              ? Colors.black
                              : Colors.black,
                          borderRadius: BorderRadius.circular(5.r),
                        ),
                      ),
                    );
                  }),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
