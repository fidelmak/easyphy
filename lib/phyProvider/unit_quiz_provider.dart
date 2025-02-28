import 'package:flutter/material.dart';

import '../model/unit_quiz_model.dart';
import '../screens/quiz_result.dart';

class QuizProvider with ChangeNotifier {
  int currentQuestionIndex = 0;
  int score = 0;
  bool answered = false;
  List<QuizQuestion> questions = []; // List to store quiz questions

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
    currentQuestionIndex = 1;
    score = 0;
    answered = false;

    notifyListeners();
  }

  // Check if an answer is correct
  void checkAnswer(String answer) {
    if (answered || questions.isEmpty) return;

    if (currentQuestion.isCorrect(answer)) {
      score++;
    }

    answered = true;
    notifyListeners();
  }

  // Move to next question or result screen
  void nextQuestion(BuildContext context) {
    if (questions.isEmpty) return;

    if (currentQuestionIndex < questions.length - 1) {
      currentQuestionIndex++;
      answered = false;
      notifyListeners();
    } else {
      Future.delayed(Duration(milliseconds: 500), () {
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
    currentQuestionIndex = 0;
    score = 0;
    answered = false;
    notifyListeners();
  }

  // Check if user passed
  bool get passed => score >= passingScore;
}
