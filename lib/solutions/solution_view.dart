import 'package:easyphy/data/ss1_physics_essay.dart';

import 'package:easyphy/solutions/phy.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../const/color.dart';
import '../../data/Chemistry.dart';
import '../../data/biology.dart';
import '../../data/english.dart';
import '../../widgets/custom_button.dart';
import '../screens/displayScreen/display_screen_for_all.dart';
import 'data_structure/algo.dart';
import 'data_structure/dsa.dart';
import 'data_structure/screen.dart';



class SolutionSelectCategory extends StatefulWidget {
  @override
  _SelectCategoryState createState() => _SelectCategoryState();
}

class _SelectCategoryState extends State<SolutionSelectCategory> {
  int _currentPage = 0;
  final PageController _pageController = PageController();

  final List<SubjectOption> subjects = [

    SubjectOption(
      title: "Physics Solution",
      icon: Icons.lightbulb,
      color: Colors.amber,
      route: PhyQuizSolutionScreen(),
    ),
    SubjectOption(
      title: "DSA Python",
      icon: Icons.lightbulb,
      color: Colors.red,
      route:   DSAScreen(Data: dsaData,),
    ),
    SubjectOption(
      title: "Algo Python",
      icon: Icons.lightbulb,
      color: Colors.green,
      route:   DSAScreen(Data: algoData,),
    ),

  ];

  final List<String> backgroundImages = [
    'assets/images/select.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    bool isDesktop = screenWidth > 600;

    return Scaffold(
      body: isDesktop ? _buildDesktopLayout() : _buildMobileLayout(),
    );
  }

  Widget _buildDesktopLayout() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.blue.shade900, Colors.indigo.shade900],
        ),
      ),
      child: Center(
        child: Card(
          elevation: 8,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.r),
          ),
          margin: EdgeInsets.all(32.sp),
          child: Padding(
            padding: EdgeInsets.all(24.sp),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Select Subject",
                  style: TextStyle(
                    fontSize: 28.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 30.sp),
                Wrap(
                  spacing: 16.sp,
                  runSpacing: 16.sp,
                  alignment: WrapAlignment.center,
                  children: subjects
                      .map((subject) => _buildSubjectCard(subject, true))
                      .toList(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMobileLayout() {
    return Stack(
      children: [
        // Background PageView with gradient overlay
        PageView.builder(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() {
              _currentPage = index;
            });
          },
          itemCount: backgroundImages.length,
          itemBuilder: (context, index) {
            return Stack(
              fit: StackFit.expand,
              children: [
                Image.asset(
                  backgroundImages[index],
                  fit: BoxFit.cover,
                ),
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.black.withOpacity(0.7),
                        Colors.black.withOpacity(0.8),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),

        // Content
        SafeArea(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(16.sp),
                child: Text(
                  "Select Your Subject",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24.sp,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Montserrat',
                  ),
                ),
              ),

              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.sp),
                  child: Center(
                    child: ListView.builder(
                      padding: EdgeInsets.symmetric(vertical: 8.sp),
                      itemCount: subjects.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.only(bottom: 16.sp),
                          child: _buildSubjectCard(subjects[index], false),
                        );
                      },
                    ),
                  ),
                ),
              ),

              // Page indicator
              if (backgroundImages.length > 1)
                Padding(
                  padding: EdgeInsets.only(bottom: 20.sp),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(backgroundImages.length, (index) {
                      return GestureDetector(
                        onTap: () {
                          _pageController.animateToPage(
                            index,
                            duration: Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        },
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: 300),
                          width: _currentPage == index ? 24.sp : 8.sp,
                          height: 8.sp,
                          margin: EdgeInsets.symmetric(horizontal: 4.sp),
                          decoration: BoxDecoration(
                            color: _currentPage == index
                                ? Colors.white
                                : Colors.white.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(4.r),
                          ),
                        ),
                      );
                    }),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSubjectCard(SubjectOption subject, bool isDesktop) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => subject.route),
          );
        },
        borderRadius: BorderRadius.circular(isDesktop ? 16.r : 12.r),
        child: Container(
          width: isDesktop ? 180.sp : double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                subject.color.withOpacity(0.7),
                subject.color,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(isDesktop ? 16.r : 12.r),
            boxShadow: [
              BoxShadow(
                color: subject.color.withOpacity(0.3),
                blurRadius: 8,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: isDesktop
              ? _buildDesktopCard(subject)
              : _buildMobileCard(subject),
        ),
      ),
    );
  }

  Widget _buildDesktopCard(SubjectOption subject) {
    return Padding(
      padding: EdgeInsets.all(20.sp),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            subject.icon,
            size: 48.sp,
            color: Colors.white,
          ),
          SizedBox(height: 16.sp),
          Text(
            subject.title,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
              fontFamily: 'Montserrat',
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildMobileCard(SubjectOption subject) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.sp, horizontal: 20.sp),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(12.sp),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Icon(
              subject.icon,
              size: 28.sp,
              color: Colors.white,
            ),
          ),
          SizedBox(width: 16.sp),
          Expanded(
            child: Text(
              subject.title,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                fontFamily: 'Montserrat',
              ),
            ),
          ),
          Icon(
            Icons.arrow_forward_ios,
            color: Colors.white,
            size: 16.sp,
          ),
        ],
      ),
    );
  }
}

class SubjectOption {
  final String title;
  final IconData icon;
  final Color color;
  final Widget route;

  SubjectOption({
    required this.title,
    required this.icon,
    required this.color,
    required this.route,
  });
}
