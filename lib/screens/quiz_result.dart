import 'package:easyphy/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../phyProvider/unit_quiz_provider.dart';
import 'display_screen.dart';

class QuizResultScreen extends StatefulWidget {
  @override
  State<QuizResultScreen> createState() => _QuizResultScreenState();
}

class _QuizResultScreenState extends State<QuizResultScreen> {
  @override
  Widget build(BuildContext context) {
    final quizProvider = Provider.of<QuizProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Quiz Result')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Your score: ${quizProvider.score}/${quizProvider.questions.length}',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            quizProvider.passed
                ? CustomButton(
                    text: 'Go Back to Display Screen',
                    press: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DisplayScreen()),
                      );
                    },
                  )
                : CustomButton(
                    text: "Retake Quiz",
                    press: () {
                      quizProvider.resetQuiz();
                      //
                      // Option to retake quiz or go to previous screen
                      Navigator.pop(context);
                    },
                  )
          ],
        ),
      ),
    );
  }
}
