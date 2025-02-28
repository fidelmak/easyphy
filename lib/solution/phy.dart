import 'package:easyphy/data/quiz_data.dart';
import 'package:easyphy/solution/datap.dart';
import 'package:easyphy/solution/quizcard.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<PhyQuizSolutionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Phy  Solns for ${quizPdata.length} Que."),
      ),
      body: Consumer<QuizState>(builder: (context, quizState, child) {
        return Center(
          child: QuizCard(
            id: "${quizState.currentIndex + 1}",
            question: quizPdata[quizState.currentIndex]['question']!,
            solution: quizPdata[quizState.currentIndex]['solution']!,
          ),
        );
      }),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          FloatingActionButton(
            onPressed: () {
              Provider.of<QuizState>(context, listen: false).prevQuestion();
            },
            child: Icon(Icons.arrow_back),
            heroTag: "prev",
          ),
          SizedBox(height: 10),
          FloatingActionButton(
            onPressed: () {
              Provider.of<QuizState>(context, listen: false).nextQuestion();
            },
            child: Icon(Icons.arrow_forward),
            heroTag: "next",
          ),
        ],
      ),
    );
  }
}
