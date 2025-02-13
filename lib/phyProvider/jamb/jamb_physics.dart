import 'package:flutter/material.dart';

import '../../model/unit_quiz_model.dart';
import '../../screens/quiz_result.dart';

// Make sure to import the model file

class JambPhysicsQuizProvider with ChangeNotifier {
  int currentQuestionIndex = 0;
  int score = 0;
  bool answered = false;
  List<QuizQuestion> questions = []; // List to store quiz questions

  // Load the questions from units.json
  void loadQuestions(List<Map<String, dynamic>> data) {
    questions = data.map((item) {
      return QuizQuestion(
        id: item['id'],
        name: item['name'],
        options: List<String>.from(item['options']),
        correctAnswer: item['correctAnswer'],
      );
    }).toList();
    notifyListeners();
  }

  // Check the answer
  void checkAnswer(String answer) {
    if (answered) return;

    if (questions[currentQuestionIndex].isCorrect(answer)) {
      score++;
    }
    answered = true;
    notifyListeners();
  }

  // Move to the next question
  void nextQuestion(BuildContext context) {
    if (currentQuestionIndex < questions.length - 1) {
      currentQuestionIndex++;
      answered = false;
      notifyListeners();
    } else {
      // Navigate to result screen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => QuizResultScreen()),
      );
    }
  }

  // Get the current question
  QuizQuestion get currentQuestion {
    return questions[currentQuestionIndex];
  }

  // Calculate average score
  double get averageScore {
    return questions.length / 2;
  }

  void resetQuiz() {
    currentQuestionIndex = 0;
    answered = false;
    notifyListeners();
  }

  // Check if user has passed
  bool get passed => score >= averageScore;
}
