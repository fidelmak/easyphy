class QuizQuestion {
  final String name;
  final String id; // Name of the unit (e.g., "Mass")
  final List<String> options; // List of options (e.g., ["Kg", "N", "S"])
  final String correctAnswer; // Correct answer (e.g., "Kg")

  QuizQuestion({
    required this.name,
    required this.options,
    required this.correctAnswer,
    required this.id,
  });

  // You can add a method to check the answer
  bool isCorrect(String answer) {
    return answer == correctAnswer;
  }
}
