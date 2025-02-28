import 'package:flutter/material.dart';

class QuizCard extends StatelessWidget {
  final String id;
  final String question;
  final String solution;

  QuizCard({required this.id, required this.question, required this.solution});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Question $id:",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Text(question),
            SizedBox(height: 8.0),
            Text(
              "Solution:",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Text(solution),
          ],
        ),
      ),
    );
  }
}
