//QuizFormular

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../data/formular.dart';
import '../../phyProvider/unit_quiz_provider.dart';

// Import your model

class QuizFormular extends StatefulWidget {
  @override
  State<QuizFormular> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizFormular> {
  @override
  void initState() {
    super.initState();
    final quizProvider = Provider.of<QuizProvider>(context, listen: false);
    // You can load your units.json data here.

    quizProvider.loadQuestions(physicsFormulas);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<QuizProvider>(
      builder: (context, quizProvider, _) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Quiz - Formular'),
          ),
          body: quizProvider.questions.isEmpty
              ? Center(child: CircularProgressIndicator())
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 5,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            quizProvider.currentQuestion.id,
                            style: TextStyle(
                                fontSize: 18.sp, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: SizedBox(
                            width: 200.sp,
                            child: Center(
                              child: Text(
                                quizProvider.currentQuestion.name,
                                style: TextStyle(
                                    fontSize: 28.sp,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                        ...quizProvider.currentQuestion.options.map((option) {
                          bool isCorrect =
                              quizProvider.currentQuestion.isCorrect(option);
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: 200.sp,
                              height: 80.sp,
                              child: ElevatedButton(
                                onPressed: quizProvider.answered
                                    ? null
                                    : () {
                                        quizProvider.checkAnswer(option);
                                      },
                                style: ButtonStyle(
                                  shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius
                                          .zero, // Makes the button a perfect rectangle
                                    ),
                                  ),
                                  textStyle: MaterialStateProperty.all(
                                    TextStyle(
                                        color: Colors.white,
                                        fontSize:
                                            18), // Set text color and size
                                  ),
                                  backgroundColor: MaterialStateProperty.all(
                                    quizProvider.answered
                                        ? (isCorrect
                                            ? Colors.green
                                            : Colors.red)
                                        : Colors.black,
                                  ),
                                ),
                                child: Text(
                                  option,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16.sp),
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                        SizedBox(height: 20),
                        quizProvider.answered
                            ? FloatingActionButton(
                                onPressed: () {
                                  quizProvider.nextQuestion(context);
                                },
                                child: Icon(Icons.arrow_forward),
                              )
                            : SizedBox.shrink(),
                      ],
                    ),
                    SizedBox(
                      width: 5,
                    ),
                  ],
                ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
        );
      },
    );
  }
}
