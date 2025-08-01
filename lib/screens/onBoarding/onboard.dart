import 'package:easyphy/screens/examCategory/select_category.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:math' as math;

import '../../data/quiz_data.dart';

import '../../widgets/custom_button.dart';
import '../displayScreen/display_explore_screen.dart';
import '../displayScreen/display_screen_for_all.dart';
import '../basicCategory/other_select.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen>
    with TickerProviderStateMixin {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  bool _isLastPage = false;

  // Animation controllers
  late AnimationController _floatingObjectsController;
  late AnimationController _scaleController;
  late Animation<double> _scaleAnimation;

  // Navigation options
  final List<NavigationOption> navigationOptions = [
    NavigationOption(
      title: "Explore and Learn ",
      description: "Learn formulas, laws and definitions",
      icon: Icons.assignment,
      route: DisplayExploreSelectCategory(),
      color: const Color(0xFF4A6572),
    ),
 


  NavigationOption(
      title: "Science Exams",
      description: "Practice with past exam questions",
      icon: Icons.explore,
      route: SelectCategory(),
      color: const Color(0xFF232F34),
    ),
  ];

  final List<String> images = [
    'assets/images/onb1.jpg',
    'assets/images/onb2.jpg',
    'assets/images/onb3.jpg',
  ];

  final List<String> bText = [
    "Learn Physics Units",
    "Take Quiz",
    "Learn Formulas",
  ];

  final List<String> secondText = [
    "Learn The Basics of Physics Units",
    "Test Your Knowledge with our Quiz",
    "Learn Formulas for Physics",
  ];

  // Floating icons for physics-themed animation
  final List<IconData> physicsIcons = [
    Icons.science,
    Icons.speed,
    Icons.lightbulb,
    Icons.waves,
    Icons.electric_bolt,
    Icons.air,
    Icons.thermostat,
    Icons.lens,
  ];

  @override
  void initState() {
    super.initState();

    // Initialize animation controllers
    _floatingObjectsController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 20),
    )..repeat();

    _scaleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _scaleAnimation = Tween<double>(begin: 0.95, end: 1).animate(
        CurvedAnimation(parent: _scaleController, curve: Curves.easeInOut));

    _pageController.addListener(() {
      if (_pageController.page! >= images.length - 1.5) {
        if (!_isLastPage) {
          setState(() {
            _isLastPage = true;
          });
          _scaleController.forward();
        }
      } else {
        if (_isLastPage) {
          setState(() {
            _isLastPage = false;
          });
          _scaleController.reverse();
        }
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    _floatingObjectsController.dispose();
    _scaleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    bool isDesktop = screenWidth > 600;

    return Scaffold(
      backgroundColor: Colors.white,
      body: isDesktop
          ? _buildDesktopLayout(screenWidth, screenHeight)
          : _buildMobileLayout(screenWidth, screenHeight),
    );
  }

  Widget _buildDesktopLayout(double screenWidth, double screenHeight) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.blue.shade900, Colors.indigo.shade800],
        ),
      ),
      child: Row(
        children: [
          // Left side: Animated illustration
          Expanded(
            child: Stack(
              children: [
                // Background image
                Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20.r),
                    child: Image.asset(
                      images[_currentPage],
                      width: screenWidth * 0.35,
                      height: screenHeight * 0.7,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                // Floating physics icons animation
                ..._buildFloatingPhysicsIcons(),
              ],
            ),
          ),

          // Right side: Content and navigation
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(32.sp),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Welcome to EasyPhy",
                    style: TextStyle(
                      fontSize: 32.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 16.sp),
                  Text(
                    "Your interactive learning companion for Physics",
                    style: TextStyle(
                      fontSize: 18.sp,
                      color: Colors.white.withOpacity(0.8),
                    ),
                  ),
                  SizedBox(height: 40.sp),

                  // Navigation options
                  ...navigationOptions
                      .map((option) => _buildDesktopNavigationOption(option))
                      ,
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDesktopNavigationOption(NavigationOption option) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.sp),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => option.route));
          },
          borderRadius: BorderRadius.circular(12.r),
          child: Container(
            padding: EdgeInsets.all(16.sp),
            decoration: BoxDecoration(
              color: option.color.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: Colors.white.withOpacity(0.2)),
            ),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(12.sp),
                  decoration: BoxDecoration(
                    color: option.color,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Icon(
                    option.icon,
                    color: Colors.white,
                    size: 24.sp,
                  ),
                ),
                SizedBox(width: 16.sp),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        option.title,
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 4.sp),
                      Text(
                        option.description,
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: Colors.white.withOpacity(0.7),
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.white.withOpacity(0.7),
                  size: 16.sp,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMobileLayout(double screenWidth, double screenHeight) {
    return Stack(
      children: [
        // Main content
        Column(
          children: [
            // Top section with interactive background
            SizedBox(
              height: screenHeight * 0.60,
              child: Stack(
                children: [
                  // PageView with curved clipper
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
                          // Image with clipper
                          ClipPath(
                            clipper: CurveClipper(),
                            child: Container(
                              width: screenWidth,
                              height: screenHeight * 0.60,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(images[index]),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          // Animated overlay content
                          Positioned(
                            top: 100.sp,
                            left: 0,
                            right: 0,
                            child: AnimatedOpacity(
                              opacity: _currentPage == index ? 1.0 : 0.0,
                              duration: const Duration(milliseconds: 400),
                              child: Column(
                                children: [
                                  Icon(
                                    index == 0
                                        ? Icons.science
                                        : index == 1
                                            ? Icons.quiz
                                            : Icons.functions,
                                    size: 60.sp,
                                    color: Colors.white,
                                  ),
                                  SizedBox(height: 16.sp),
                                  Text(
                                    bText[index],
                                    style: TextStyle(
                                      fontFamily: 'ZCOOLXiaoWei',
                                      fontWeight: FontWeight.w600,
                                      fontSize: 28.sp,
                                      color: Colors.white,
                                      shadows: [
                                        Shadow(
                                          blurRadius: 10.0,
                                          color: Colors.black.withOpacity(0.5),
                                          offset: const Offset(2, 2),
                                        ),
                                      ],
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),

                  // Add some floating physics-themed icons for fun
                  ..._buildFloatingPhysicsIcons(),
                ],
              ),
            ),

            // Bottom section with information and buttons
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                child: Padding(
                  padding: EdgeInsets.all(16.sp),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Description text
                      Column(
                        children: [
                          Text(
                            secondText[_currentPage],
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w500,
                              fontSize: 16.sp,
                              color: Colors.black87,
                              height: 1.4,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 20.sp),

                          // Page indicator
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(images.length, (index) {
                              return GestureDetector(
                                onTap: () {
                                  _pageController.animateToPage(
                                    index,
                                    duration: const Duration(milliseconds: 300),
                                    curve: Curves.easeInOut,
                                  );
                                },
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 300),
                                  width: _currentPage == index ? 30.sp : 10.sp,
                                  height: 4.sp,
                                  margin:
                                      EdgeInsets.symmetric(horizontal: 3.sp),
                                  decoration: BoxDecoration(
                                    color: _currentPage == index
                                        ? const Color(0xFF344955)
                                        : Colors.grey.shade300,
                                    borderRadius: BorderRadius.circular(5.r),
                                  ),
                                ),
                              );
                            }),
                          ),
                        ],
                      ),

                      // Navigation buttons with animations
                      Column(
                        children: [
                          // Main action buttons with improved visuals
                          _buildNavigationButton(
                            navigationOptions[0].title,
                            navigationOptions[0].icon,
                            navigationOptions[0].color,
                            () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (ctx) =>
                                        navigationOptions[0].route)),
                          ),
                          SizedBox(height: 12.sp),
                          _buildNavigationButton(
                            navigationOptions[1].title,
                            navigationOptions[1].icon,
                            navigationOptions[1].color,
                            () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (ctx) =>
                                        navigationOptions[1].route)),
                          ),
                          SizedBox(height: 12.sp),
                          _buildNavigationButton(
                            navigationOptions[1].title,
                            navigationOptions[1].icon,
                            navigationOptions[1].color,
                            () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (ctx) =>
                                        navigationOptions[2].route)),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),

        // "Get Started" floating button that appears on the last page
        Positioned(
          bottom: 20.sp,
          right: 20.sp,
          child: AnimatedOpacity(
            opacity: _isLastPage ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 300),
            child: ScaleTransition(
              scale: _scaleAnimation,
              child: FloatingActionButton.extended(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (ctx) => SelectCategory()),
                  );
                },
                backgroundColor: const Color(0xFF344955),
                label: const Text("Get Started"),
                icon: const Icon(Icons.arrow_forward),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildNavigationButton(
      String text, IconData icon, Color color, VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        elevation: 2,
        padding: EdgeInsets.symmetric(vertical: 12.sp),
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
          side: BorderSide(color: color, width: 1.5),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.sp),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(8.sp),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Icon(
                icon,
                color: color,
                size: 24.sp,
              ),
            ),
            SizedBox(width: 12.sp),
            Text(
              text,
              style: TextStyle(
                color: Colors.black87,
                fontFamily: "Montserrat",
                fontWeight: FontWeight.w600,
                fontSize: 16.sp,
              ),
            ),
            const Spacer(),
            Icon(
              Icons.arrow_forward,
              color: color,
              size: 18.sp,
            ),
          ],
        ),
      ),
    );
  }

  // Build floating physics-themed icons for visual interest
  List<Widget> _buildFloatingPhysicsIcons() {
    return List.generate(8, (index) {
      final randomOffset = index * (math.pi * 2 / 8);

      return AnimatedBuilder(
        animation: _floatingObjectsController,
        builder: (context, child) {
          final value = _floatingObjectsController.value;
          final angle = value * math.pi * 2 + randomOffset;

          double radius;
          if (MediaQuery.of(context).size.width > 600) {
            radius = 160.sp; // Desktop
          } else {
            radius = 120.sp; // Mobile
          }

          final dx = math.cos(angle) * radius;
          final dy = math.sin(angle) * radius;

          return Positioned(
            top: MediaQuery.of(context).size.height * 0.3 + dy,
            left: MediaQuery.of(context).size.width *
                    (MediaQuery.of(context).size.width > 600 ? 0.25 : 0.5) +
                dx,
            child: Opacity(
              opacity: 0.3 + (math.sin(value * math.pi * 2) + 1) / 4,
              child: Transform.rotate(
                angle: angle,
                child: Icon(
                  physicsIcons[index % physicsIcons.length],
                  size: (20 + index % 3 * 5).sp,
                  color: Colors.white.withOpacity(0.7),
                ),
              ),
            ),
          );
        },
      );
    });
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

class NavigationOption {
  final String title;
  final String description;
  final IconData icon;
  final Widget route;
  final Color color;

  NavigationOption({
    required this.title,
    required this.description,
    required this.icon,
    required this.route,
    required this.color,
  });
}
