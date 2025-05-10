import 'package:easyphy/data/Definition.dart';
import 'package:easyphy/data/formular.dart';
import 'package:easyphy/data/law.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../const/color.dart';
import '../../data/quiz_data.dart';
import '../displayScreen/display_screen_for_all.dart';
import '../modes/levels/widgets/level_widget.dart';

class OtherSelect extends StatefulWidget {
  @override
  _SelectCategoryState createState() => _SelectCategoryState();
}

// PracticePhyScreen(
// yourTest: 'Access Solutions ',
// yourData: quizData,
// ),

class _SelectCategoryState extends State<OtherSelect> {
  int _currentPage = 0;
  final PageController _pageController = PageController();

  final List<PracticeOption> practiceOptions = [
    PracticeOption(
      title: "Formulas",
      subtitle: "Physics formular",
      icon: Icons.functions,
      color: Color(0xffFF2F13),
      route: LevelSelect(levelWay: PracticePhyScreen(
        yourTest: 'Physics  Basic',
        yourData: physicsFormulas,
      ), levelWay2: PracticePhyScreen(
        yourTest: 'Physics Intermediate',
        yourData: physicsFormulas,
      ), levelWay3:PracticePhyScreen(
        yourTest: 'Physics  Advanced',
        yourData: physicsFormulas,
      ), title: 'Practice Formulas',)  // QupizFormular(),
    ),
    PracticeOption(
      title: "Laws",
      subtitle: "Physics Laws",
      icon: Icons.balance,
      color: mama,
      textColor: Color(0xff1E1E1E),
      route: PracticePhyScreen(
        yourTest: 'Physics Laws',
        yourData: physicsLaws,
      ), // QuizLaws(),
    ),
    PracticeOption(
      title: "Definitions",
      subtitle: "Physics Definitions",
      icon: Icons.menu_book,
      color: mama,
      textColor: nov,
      route: PracticePhyScreen(
        yourTest: 'Physics Definitions',
        yourData: physicsDefinitions,
      ), //QuizDefinition(),
    ),
    PracticeOption(
      title: "Units ",
      subtitle: "Physics Units",
      icon: Icons.menu_book,
      color: Colors.blue,
      textColor: Colors.amber,
      route: PracticePhyScreen(
        yourTest: 'Units and Quantities ',
        yourData: quizData,
      ), //QuizDefinition(),
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
      appBar:AppBar(),
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
                  "Physics Practice",
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
                  children: practiceOptions
                      .map((option) => _buildPracticeCard(option, true))
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
                  "Practice Basic Concepts ",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24.sp,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Montserrat',
                  ),
                ),
              ),

              Expanded(
                child: ListView.builder(
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.sp, vertical: 8.sp),
                  itemCount: practiceOptions.length,
                  itemBuilder: (context, index) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              left: 12.sp,
                              bottom: 8.sp,
                              top: index == 0 ? 0 : 24.sp),
                          child: RichText(
                            text: TextSpan(
                              text: "Practice ",
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                color: Colors.white,
                                fontWeight: FontWeight.w400,
                                fontSize: 16.sp,
                              ),
                              children: [
                                TextSpan(
                                  text: practiceOptions[index].title,
                                  style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    color: mama,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16.sp,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        _buildPracticeCard(practiceOptions[index], false),
                      ],
                    );
                  },
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

  Widget _buildPracticeCard(PracticeOption option, bool isDesktop) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => option.route),
          );
        },
        borderRadius: BorderRadius.circular(isDesktop ? 16.r : 12.r),
        child: Container(
          width: isDesktop ? 180.sp : double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                option.color.withOpacity(0.8),
                option.color,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(isDesktop ? 16.r : 12.r),
            boxShadow: [
              BoxShadow(
                color: option.color.withOpacity(0.3),
                blurRadius: 8,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: isDesktop
              ? _buildDesktopOptionCard(option)
              : _buildMobileOptionCard(option),
        ),
      ),
    );
  }

  Widget _buildDesktopOptionCard(PracticeOption option) {
    return Padding(
      padding: EdgeInsets.all(20.sp),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            option.icon,
            size: 48.sp,
            color: Colors.white,
          ),
          SizedBox(height: 16.sp),
          Text(
            option.title,
            style: TextStyle(
              color: option.textColor ?? Colors.white,
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

  Widget _buildMobileOptionCard(PracticeOption option) {
    return Container(
      height: 60.sp,
      child: Center(
        child: Text(
          "Start",
          style: TextStyle(
            color: option.textColor ?? Colors.white,
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
            fontFamily: 'Montserrat',
          ),
        ),
      ),
    );
  }
}

class PracticeOption {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final Color? textColor;
  final Widget route;

  PracticeOption({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    this.textColor,
    required this.route,
  });
}
