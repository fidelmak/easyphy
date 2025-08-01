import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:easyphy/const/color.dart';

import 'package:easyphy/solutions/datap.dart';
import 'package:easyphy/solutions/quizcard.dart';

class QuizState with ChangeNotifier {
  int _currentIndex = 0;
  int get currentIndex => _currentIndex;

  void nextQuestion() {
    if (_currentIndex < quizPdata.length - 1) {
      _currentIndex++;
      notifyListeners();
    }
  }

  void prevQuestion() {
    if (_currentIndex > 0) {
      _currentIndex--;
      notifyListeners();
    }
  }
}

class PhyQuizSolutionScreen extends StatefulWidget {
  const PhyQuizSolutionScreen({super.key});

  @override
  _PhyQuizSolutionScreenState createState() => _PhyQuizSolutionScreenState();
}

class _PhyQuizSolutionScreenState extends State<PhyQuizSolutionScreen> {
  final TextEditingController _passwordController = TextEditingController();
  final String _correctPassword = "123456";
  bool _isAuthenticated = false;
  bool _showError = false;
  bool _isLoading = false;

  Future<void> _checkPassword() async {
    setState(() {
      _isLoading = true;
      _showError = false;
    });

    await Future.delayed(const Duration(milliseconds: 500));

    if (_passwordController.text == _correctPassword) {
      setState(() {
        _isAuthenticated = true;
        _isLoading = false;
      });
      Navigator.of(context).pop();
    } else {
      setState(() {
        _showError = true;
        _isLoading = false;
      });
    }
  }

  void _showPasswordDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        title: const Text("🔐 Enter Access Code"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                hintText: "Enter password",
                border: const OutlineInputBorder(),
                errorText: _showError ? "Incorrect password!" : null,
              ),
            ),
            const SizedBox(height: 10),
            if (_isLoading)
              const CircularProgressIndicator(strokeWidth: 2)
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: _checkPassword,
            child: const Text("Unlock"),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _showPasswordDialog());
  }

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(

        title: const Text("Physics Solutions", style: TextStyle(color: Colors.white),),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 0,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [mama, nov],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      extendBodyBehindAppBar: true,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: const AssetImage("assets/images/Neutron.jpg"),//, // Your background image
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.7), // Dark overlay for better text visibility
              BlendMode.darken,
            ),
          ),
        ),
        child:_isAuthenticated
            ? Consumer<QuizState>(
          builder: (context, quizState, _) {
            final index = quizState.currentIndex;
            return AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              transitionBuilder: (child, animation) =>
                  FadeTransition(opacity: animation, child: child),
              child: Padding(
                key: ValueKey(index),
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height /1.3.sp,
                      child: QuizCard(
                        id: "${index + 1}",
                        question: quizPdata[index]['question']!,
                        solution: quizPdata[index]['solution']!,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: quizState.prevQuestion,
                          icon: const Icon(Icons.chevron_left_rounded, size: 40),
                          color: Colors.grey.shade700,
                          tooltip: "Previous",
                        ),
                        Text(
                          "${index + 1} / ${quizPdata.length}",
                          style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                        IconButton(
                          onPressed: quizState.nextQuestion,
                          icon: const Icon(Icons.chevron_right_rounded, size: 40),
                          color: mama,
                          tooltip: "Next",
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        )
            : _buildLockedView() ,
      )
    );
  }

  Widget _buildLockedView() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.lock_outline_rounded, size: 80, color: Colors.grey),
            const SizedBox(height: 20),
            const Text(
              "Access Restricted",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 10),
            const Text(
              "This section is protected. Please enter the password to proceed.",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: _showPasswordDialog,
              icon: const Icon(Icons.lock_open_rounded),
              label: const Text("Enter Password"),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
