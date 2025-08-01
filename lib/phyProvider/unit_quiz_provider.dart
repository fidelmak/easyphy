import 'dart:async';

import 'package:flutter/material.dart';

import '../model/unit_quiz_model.dart';
import '../screens/allQuiz/quiz_result.dart';

class QuizProvider with ChangeNotifier {
  String selectedOption = '';
  int currentQuestionIndex = 0; // Changed from 1 to 0
  int score = 0;
  bool answered = false;
  List<QuizQuestion> questions = []; // List to store quiz questions

  Timer? _examTimer;
  int _examTimeRemaining = 0;
  bool isTimeAlmostUp = false;

  int get examTimeRemaining => _examTimeRemaining;

  // Load questions safely
  void loadQuestions(List<Map<String, dynamic>> data) {
    if (data.isEmpty) return;

    questions = data.map((item) {
      return QuizQuestion(
        id: item['id']?.toString() ?? 'N/A', // Ensure it's always a String
        name: item['name'] ?? 'Unknown Question',
        options: (item['options'] as List<dynamic>?)
            ?.map((option) => option.toString())
            .toList() ??
            [], // Ensure it's always a List<String>
        correctAnswer: item['correctAnswer'] ?? '',
      );
    }).toList();

    // Reset quiz state
    currentQuestionIndex = 0; // Start with first question (index 0)
    score = 0;
    selectedOption = ''; // Ensure no option is selected initially
    answered = false;

    // Calculate timer based on number of questions (40 seconds per question)
    if (questions.isNotEmpty) {
      _examTimeRemaining = questions.length * 40;
    }

    notifyListeners();

    // Start timer after loading questions
    if (questions.isNotEmpty) {
      startExamTimer();
    }
  }

  // Check if an answer is correct
  void checkAnswer(String answer) {
    if (answered || questions.isEmpty) return;

    if (currentQuestion.isCorrect(answer)) {
      score++;
    }
    selectedOption = answer;
    answered = true;
    notifyListeners();
  }

  // Move to next question or result screen
  void nextQuestion(BuildContext context) {
    if (questions.isEmpty) return;
    selectedOption = ''; // Clear selection when moving to next question

    if (currentQuestionIndex < questions.length - 1) {
      currentQuestionIndex++;
      answered = false;
      notifyListeners();
    } else {
      // Cancel timer before navigating away
      cancelTimer();

      Future.delayed(const Duration(milliseconds: 500), () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => QuizResultScreen()),
        );
      });
    }
  }

  // Safely return the current question
  QuizQuestion get currentQuestion {
    if (questions.isEmpty) {
      return QuizQuestion(
          id: '0',
          name: 'No Questions Available',
          options: [],
          correctAnswer: '');
    }
    return questions[currentQuestionIndex];
  }

  // Calculate pass score (50% of total)
  double get passingScore => questions.length * 0.5;

  // Reset quiz properly
  void resetQuiz() {
    selectedOption = ''; // Ensure no option is selected
    currentQuestionIndex = 0;
    score = 0;
    answered = false;

    // Calculate timer based on number of questions (40 seconds per question)
    if (questions.isNotEmpty) {
      _examTimeRemaining = questions.length * 40;
    }

    notifyListeners();
  }

  // Check if user passed
  bool get passed => score >= passingScore;

  void timeUp() {
    // Mark as answered but don't set any selected option
    answered = true;
    notifyListeners();
  }

  // Show results when exam is complete
  void showResults(BuildContext context) {
    // Cancel timer before showing results
    cancelTimer();

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Quiz Completed'),
          content: Text('Your final score: $score out of ${questions.length}'),
          actions: [
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
                // You could navigate back to home screen or to a detailed results page
              },
            ),
          ],
        );
      },
    );
  }

  // Timer methods
  void startExamTimer() {
    // Cancel any existing timer first
    cancelTimer();

    _examTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_examTimeRemaining > 0) {
        _examTimeRemaining--;

        // Check if 10 minutes remain (600 seconds)
        if (_examTimeRemaining == 600) {
          isTimeAlmostUp = true;
        }

        notifyListeners();
      } else {
        // Time's up
        timer.cancel();
        _timeUp();
      }
    });
  }

  void cancelTimer() {
    _examTimer?.cancel();
    _examTimer = null;
  }

  String formatTime(int seconds) {
    int hours = seconds ~/ 3600;
    int minutes = (seconds % 3600) ~/ 60;
    int remainingSeconds = seconds % 60;

    if (hours > 0) {
      return '$hours:${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
    } else {
      return '$minutes:${remainingSeconds.toString().padLeft(2, '0')}';
    }
  }

  void _timeUp() {
    answered = true; // Prevent further answers
    notifyListeners();
  }

  // Call this in dispose of your widgets that use this provider
  @override
  void dispose() {
    cancelTimer();
    super.dispose();
  }
}