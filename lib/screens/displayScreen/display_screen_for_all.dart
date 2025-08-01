import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../data/jamb_physics_one_2024.dart';
import '../../phyProvider/unit_quiz_provider.dart';
import '../../widgets/my_timer.dart';

class PracticePhyScreen extends StatefulWidget {
  final String yourTest;
  final List<Map<String, dynamic>> yourData;

  const PracticePhyScreen({
    super.key,
    required this.yourTest,
    required this.yourData,
  });

  @override
  State<PracticePhyScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<PracticePhyScreen>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _bounceController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _bounceAnimation;

  // Track current question to detect changes
  int _lastQuestionIndex = -1;
  bool _isTransitioning = false;

  @override
  void initState() {
    super.initState();

    // Initialize controllers without immediately using the provider
    _setupAnimationControllers();

    // Schedule provider initialization for after the first frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        final quizProvider = Provider.of<QuizProvider>(context, listen: false);
        quizProvider.loadQuestions(widget.yourData);
        quizProvider.startExamTimer();
        _fadeController.forward();
      }
    });
  }

  void _setupAnimationControllers() {
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _bounceController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeIn),
    );

    _bounceAnimation = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 1.2), weight: 1),
      TweenSequenceItem(tween: Tween(begin: 1.2, end: 1.0), weight: 1),
    ]).animate(
      CurvedAnimation(parent: _bounceController, curve: Curves.elasticOut),
    );
  }

  @override
  void dispose() {
    // Make sure to dispose controllers
    _fadeController.dispose();
    _bounceController.dispose();
    super.dispose();
  }

  void _animateAnswer() {
    if (!mounted) return;

    if (_bounceController.isAnimating) {
      _bounceController.stop();
    }
    _bounceController.reset();
    _bounceController.forward();
  }

  // Safe transition to next question with proper animation sequencing
  void _safeNextQuestion(BuildContext context, QuizProvider quizProvider) {
    if (!mounted || _isTransitioning) return;

    setState(() {
      _isTransitioning = true;
    });

    // First fade out
    _fadeController.reverse().then((_) {
      if (!mounted) return;

      // Then change the question in provider
      quizProvider.nextQuestion(context);

      // Use setState to ensure widget rebuilds properly
      setState(() {
        _isTransitioning = false;
      });

      // Then fade back in
      if (mounted) {
        _fadeController.forward();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.black,
        title: Text(
          widget.yourTest,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: Consumer<QuizProvider>(
        builder: (context, quizProvider, _) {
          // Handle the case when questions haven't loaded yet
          if (quizProvider.questions.isEmpty) {
            return const Center(
              child: CircularProgressIndicator(color: Colors.black),
            );
          }

          // Handle question index change detection
          if (_lastQuestionIndex != quizProvider.currentQuestionIndex && !_isTransitioning) {
            _lastQuestionIndex = quizProvider.currentQuestionIndex;
            // Don't animate on first load
            if (_lastQuestionIndex > 0 && mounted) {
              _fadeController.reset();
              _fadeController.forward();
            }
          }

          double screenWidth = MediaQuery.of(context).size.width;
          bool isDesktop = screenWidth > 600;

          return FadeTransition(
            opacity: _fadeAnimation,
            child: _buildQuizContent(context, quizProvider, isDesktop),
          );
        },
      ),
    );
  }

  Widget _buildQuizContent(BuildContext context, QuizProvider quizProvider, bool isDesktop) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.grey[100]!, Colors.grey[200]!],
        ),
      ),
      child: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: isDesktop ? 20.sp : 16.0),
              child: Column(
                children: [
                  // Progress indicator
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: isDesktop ? 5.sp : 16.0),
                    child: LinearProgressIndicator(
                      value: (quizProvider.currentQuestionIndex + 1) / quizProvider.questions.length,
                      backgroundColor: Colors.grey[300],
                      valueColor: const AlwaysStoppedAnimation<Color>(Colors.black),
                      minHeight: isDesktop ? 2.sp : 6.0,
                    ),
                  ),

                  // Question number row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: isDesktop ? 4.sp : 12.0,
                          vertical: isDesktop ? 2.sp : 6.0,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(isDesktop ? 3.sp : 8.0),
                        ),
                        child: Text(
                          quizProvider.currentQuestion.id,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: isDesktop ? 5.sp : 14.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Text(
                        "${quizProvider.currentQuestionIndex + 1}/${quizProvider.questions.length}",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: isDesktop ? 5.sp : 14.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),

                  // Timer
                  QuizTimer(examDurationInSeconds: quizProvider.questions.length * 40),

                  // Question card
                  Expanded(
                    flex: 2,
                    child: Center(
                      child: Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(isDesktop ? 5.sp : 16.0),
                        ),
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(isDesktop ? 8.sp : 20.0),
                          child: Center(
                            child: SingleChildScrollView(
                              child: Text(
                                quizProvider.currentQuestion.name,
                                style: TextStyle(
                                  fontSize: isDesktop ? 7.sp : 18.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  // Options
                  Expanded(
                    flex: 4,
                    child: _buildOptionsListView(quizProvider, isDesktop),
                  ),

                  // Space for floating action button
                  const SizedBox(height: 80),
                ],
              ),
            ),

            // Floating action button positioned with Positioned widget for safety
            if (quizProvider.answered)
              Positioned(
                bottom: 16,
                left: 0,
                right: 0,
                child: Center(
                  child: FloatingActionButton(
                    heroTag: "nextBtn", // Prevent hero animation conflicts
                    onPressed: () => _safeNextQuestion(context, quizProvider),
                    backgroundColor: Colors.black,
                    child: const Icon(Icons.arrow_forward, color: Colors.white),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildOptionsListView(QuizProvider quizProvider, bool isDesktop) {
    // Use a normal builder instead of ListView.builder to avoid potential issues
    return SingleChildScrollView(
      key: ValueKey('options-list-${quizProvider.currentQuestionIndex}'),
      child: Column(
        children: List.generate(
          quizProvider.currentQuestion.options.length,
              (index) => _buildOptionItem(quizProvider, index, isDesktop),
        ),
      ),
    );
  }

  Widget _buildOptionItem(QuizProvider quizProvider, int index, bool isDesktop) {
    String option = quizProvider.currentQuestion.options[index];
    bool isCorrect = quizProvider.currentQuestion.isCorrect(option);
    bool isSelected = quizProvider.answered && quizProvider.selectedOption == option;

    return Padding(
      key: ValueKey('option-$index-${quizProvider.currentQuestionIndex}'),
      padding: EdgeInsets.symmetric(vertical: isDesktop ? 2.sp : 8.0),
      child: GestureDetector( // Using GestureDetector instead of InkWell for better control
        onTap: quizProvider.answered ? null : () {
          if (!mounted) return;
          quizProvider.checkAnswer(option);
          _animateAnswer();
        },
        child: Container(
          padding: EdgeInsets.all(isDesktop ? 5.sp : 16.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(isDesktop ? 3.sp : 10.0),
            color: quizProvider.answered
                ? (isCorrect
                ? Colors.green[700]
                : (isSelected ? Colors.red[700] : Colors.white))
                : Colors.white,
            border: Border.all(
              color: quizProvider.answered
                  ? (isCorrect
                  ? Colors.green[700]!
                  : (isSelected ? Colors.red[700]! : Colors.grey[300]!))
                  : Colors.grey[300]!,
              width: 1.5,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                width: isDesktop ? 10.sp : 28.0,
                height: isDesktop ? 10.sp : 28.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: quizProvider.answered
                      ? (isCorrect
                      ? Colors.green[700]
                      : (isSelected ? Colors.red[700] : Colors.grey[200]))
                      : Colors.grey[200],
                  border: Border.all(
                    color: quizProvider.answered
                        ? (isCorrect
                        ? Colors.green[100]!
                        : (isSelected ? Colors.red[100]! : Colors.grey[400]!))
                        : Colors.grey[400]!,
                  ),
                ),
                alignment: Alignment.center,
                child: Text(
                  String.fromCharCode(65 + index), // A, B, C, D
                  style: TextStyle(
                    color: quizProvider.answered && (isCorrect || isSelected)
                        ? Colors.white
                        : Colors.black,
                    fontSize: isDesktop ? 5.sp : 14.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(width: isDesktop ? 5.sp : 12.0),
              Expanded(
                child: Text(
                  option,
                  style: TextStyle(
                    color: quizProvider.answered && (isCorrect || isSelected)
                        ? Colors.white
                        : Colors.black87,
                    fontSize: isDesktop ? 5.sp : 16.sp,
                  ),
                ),
              ),
              if (quizProvider.answered)
                Icon(
                  isCorrect
                      ? Icons.check_circle
                      : (isSelected ? Icons.cancel : null),
                  color: Colors.white,
                  size: isDesktop ? 8.sp : 24.0,
                ),
            ],
          ),
        ),
      ),
    );
  }
}