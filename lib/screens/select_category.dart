import 'package:easyphy/screens/practice.dart';
import 'package:easyphy/solution/phy.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../const/color.dart';
import '../widgets/custom_button.dart';
import 'Jamb/English.dart';
import 'Jamb/biology.dart';
import 'Jamb/chem.dart';
import 'Jamb/phy_jamb_2024.dart';
import 'Jamb/phy_jamb_2024_Two.dart';
import 'Waec/General_phy.dart';
import 'Waec/waec_2024.dart';

class SelectCategory extends StatefulWidget {
  @override
  _SelectCategoryState createState() => _SelectCategoryState();
}

class _SelectCategoryState extends State<SelectCategory> {
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
    bool isDesktop = screenWidth > 600;

    return Scaffold(
      backgroundColor: Colors.white,
      body: isDesktop
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomButton(
                    text: 'Biology',
                    press: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (ctx) => PracticeScreen()));
                    },
                  ),
                  SizedBox(height: 10.sp),
                  CustomButton(
                    text: 'Physics',
                    press: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (ctx) => PracticeScreen()));
                    },
                  ),
                  SizedBox(height: 10.sp),
                  CustomButton(
                    text: 'Chemistry',
                    press: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (ctx) => PracticeScreen()));
                    },
                  ),
                ],
              ),
            )
          : Stack(
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
                          color: Colors.black
                              .withOpacity(0.7), // 70% black overlay
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
                                SizedBox(height: 20.sp),
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (ctx) {
                                      return QuizScreenJambOne();
                                    }));
                                  },
                                  style: ElevatedButton.styleFrom(
                                    elevation: 0,
                                    minimumSize: Size(200.sp, 48.sp),
                                    backgroundColor: Color(0xffFF2F13),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5.r),
                                      side: BorderSide(
                                          color: Colors.white, width: 1),
                                    ),
                                  ),
                                  child: FittedBox(
                                    child: Text(
                                      "Physics",
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
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (ctx) {
                                      return PhyQuizSolutionScreen();
                                    }));
                                  },
                                  style: ElevatedButton.styleFrom(
                                    elevation: 0,
                                    minimumSize: Size(200.sp, 48.sp),
                                    backgroundColor: Colors.black54,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5.r),
                                      side: BorderSide(
                                          color: Colors.white, width: 1),
                                    ),
                                  ),
                                  child: FittedBox(
                                    child: Text(
                                      "Solution",
                                      style: TextStyle(
                                        fontFamily: 'Montserrat',
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 18.sp,
                                      ),
                                    ),
                                  ),
                                ), //
                                SizedBox(height: 20.sp),

                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (ctx) {
                                      return QuizScreenChem();
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
                                    "Chemistry",
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

                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (ctx) {
                                      return QuizScreenBio();
                                    }));
                                  },
                                  style: ElevatedButton.styleFrom(
                                    elevation: 0,
                                    minimumSize: Size(200.sp, 48.sp),
                                    backgroundColor: mama,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5.r),
                                      side: BorderSide(
                                          color: Colors.white, width: 1.5),
                                    ),
                                  ),
                                  child: Text(
                                    "Biology",
                                    style: TextStyle(
                                      fontFamily: 'Montserrat',
                                      color: Colors.blue,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18.sp,
                                    ),
                                  ),
                                ),

                                //////
                                ///////
                                SizedBox(height: 20.sp),

                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (ctx) {
                                      return QuizScreenEng();
                                    }));
                                  },
                                  style: ElevatedButton.styleFrom(
                                    elevation: 0,
                                    minimumSize: Size(200.sp, 48.sp),
                                    backgroundColor: mama,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5.r),
                                      side: BorderSide(
                                          color: Colors.white, width: 1.5),
                                    ),
                                  ),
                                  child: Text(
                                    " English",
                                    style: TextStyle(
                                      fontFamily: 'Montserrat',
                                      color: Colors.white,
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
