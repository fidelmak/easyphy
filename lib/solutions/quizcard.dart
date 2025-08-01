import 'package:flutter/material.dart';
import 'package:easyphy/const/color.dart'; // Assuming you have custom colors mama, nov, etc.

class QuizCard extends StatelessWidget {
  final String id;
  final String question;
  final String solution;

  const QuizCard({
    super.key,
    required this.id,
    required this.question,
    required this.solution,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Column(
        children: [
          // Header Section
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [mama, nov],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: Row(
              children: [
                const Icon(Icons.quiz_rounded, color: Colors.white),
                const SizedBox(width: 10),
                Text(
                  "Question $id",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                )
              ],
            ),
          ),

          // Question & Solution Body
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 16),
              child: SingleChildScrollView(
                child: Container(

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        question,
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          const Icon(Icons.lightbulb_rounded, color: mama, size: 20),
                          const SizedBox(width: 6),
                          Text(
                            "Solution",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              color: Colors.grey[800],
                            ),
                          ),
                        ],
                      ),
                      const Divider(thickness: 1),
                      const SizedBox(height: 10),
                      Text(
                        solution,
                        style: const TextStyle(fontSize: 15, height: 1.5),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
