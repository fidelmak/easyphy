import 'package:easyphy/screens/onBoarding/onboard.dart';
import 'package:flutter/material.dart';




class StudentHomePage extends StatefulWidget {
  const StudentHomePage({super.key});

  @override
  State<StudentHomePage> createState() => _StudentHomePageState();
}

class _StudentHomePageState extends State<StudentHomePage> with SingleTickerProviderStateMixin {
  int _selectedIndex = 0;
  late AnimationController _animationController;
  final List<Color> _gradientColors = [
    const Color(0xFF6448FE),
    const Color(0xFF5FC6FF),
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..repeat();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: const AssetImage('assets/images/Neutron.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.7), // Darkens the image
              BlendMode.darken,
            ),
          ),
        ),
       child: Center(
         child: Column(
           mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildSubjectAreasGrid(),
            ],
          ),
       ),

            // Animated App Bar




            // Add some bottom padding



      ),
      bottomNavigationBar: _buildAnimatedBottomNavigationBar(),


    );
  }

  Widget _buildStudentProfileCard() {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            // Student Image with Animation
            Hero(
              tag: 'student_image',
              child: Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Theme.of(context).primaryColor,
                    width: 3,
                  ),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 8,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: ClipOval(
                  child: Image.network(
                    'https://api.placeholder.com/400/320',
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Center(
                        child: CircularProgressIndicator(
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded /
                              loadingProgress.expectedTotalBytes!
                              : null,
                        ),
                      );
                    },
                    errorBuilder: (context, error, stackTrace) {
                      return const CircleAvatar(
                        backgroundColor: Colors.grey,
                        child: Icon(
                          Icons.person,
                          size: 50,
                          color: Colors.white,
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
            const SizedBox(width: 20),
            // Student Information
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Alex Johnson',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Physics Students  • Year 2',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.green[100],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.check_circle,
                              size: 12,
                              color: Colors.green[800],
                            ),
                            const SizedBox(width: 4),
                            Text(
                              'Active Student',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.green[800],
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            IconButton(
              icon: const Icon(Icons.edit_outlined),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSubjectAreasGrid() {
    // List of subject areas
    final List<Map<String, dynamic>> subjectAreas = [
      {
        'title': 'EasyScience',
        'description': 'Explore',
        'icon': Icons.science,
        'color': Colors.amber,
        'textColor': Colors.white,
        'route': 'math',
      },
      {
        'title': 'EasyArts',
        'description': 'Coming Soon',
        'icon': Icons.palette,
        'color': Colors.green,
        'textColor': Colors.white,
        'route': 'math',
      },
      {
        'title': 'EasyBusiness',
        'description': 'Coming Soon ',
        'icon': Icons.business_center,
        'color': const Color(0xFF26A69A),
        'textColor': Colors.white,
        'route': 'math',
      },
      {
        'title': 'EasyMath',
        'description': 'Coming Soon ',
        'icon': Icons.calculate,
        'color': Colors.redAccent,
        'textColor': Colors.white,
        'route': 'math',
      },
      {
        'title': 'EasyLang',
        'description': 'Explore',
        'icon': Icons.science,
        'color': Colors.amber,
        'textColor': Colors.white,
        'route': 'math',
      },
      {
        'title': 'EasySocial',
        'description': 'Coming Soon',
        'icon': Icons.palette,
        'color': Colors.green,
        'textColor': Colors.white,
        'route': 'math',
      },
      {
        'title': 'EasyQues',
        'description': 'Coming Soon ',
        'icon': Icons.business_center,
        'color': const Color(0xFF26A69A),
        'textColor': Colors.white,
        'route': 'math',
      },
      {
        'title': 'EasyTech',
        'description': 'Coming Soon ',
        'icon': Icons.calculate,
        'color': Colors.redAccent,
        'textColor': Colors.white,
        'route': 'math',
      },


    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1.4,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemCount: subjectAreas.length,
      itemBuilder: (context, index) {
        final area = subjectAreas[index];
        return _buildSubjectAreaCard(area);
      },
    );
  }

  Widget _buildSubjectAreaCard(Map<String, dynamic> area) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      clipBehavior: Clip.antiAlias,
      child: _buildNavCard(area), // Renamed for clarity
    );
  }

  InkWell _buildNavCard(Map<String, dynamic> area) {
    return InkWell(
      onTap: () {
        // Dynamic navigation based on 'route' in the area map
        _navigateToScreen(area['route']);
      },
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [area['color'], area['color']],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    area['icon'],
                    color: area['textColor'],
                    size: 28,
                  ),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      'Explore',
                      style: TextStyle(
                        color: area['textColor'],
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Text(
                area['title'],
                style: TextStyle(
                  color: area['textColor'],
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                area['description'],
                style: TextStyle(
                  color: area['textColor'].withOpacity(0.8),
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

// Helper function to handle navigation
  void _navigateToScreen(String routeName) {
    switch (routeName) {
      case 'onboarding':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => OnboardingScreen()),
        );
        break;
      case 'math':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => OnboardingScreen()),
        );
        break;
      case 'science':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => OnboardingScreen()),
        );
        break;
    // Add more cases as needed
      default:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => OnboardingScreen()),
        );
    }
  }
  Widget _buildAnimatedBottomNavigationBar() {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.black,
        boxShadow: [
          BoxShadow(
            color: Colors.red,
            blurRadius: 10,
            offset: Offset(0, -5),
          ),
        ],
      ),
      child: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home_rounded),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.apps_rounded),
            label: 'More',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_rounded),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}