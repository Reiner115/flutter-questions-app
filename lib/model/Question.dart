// To parse this JSON data, do
//
//     final question = questionFromJson(jsonString);

import 'dart:convert';

Question questionFromJson(String str) => Question.fromJson(json.decode(str));

String questionToJson(Question data) => json.encode(data.toJson());

class Question {
  Question({
    required this.category,
    required this.type,
    required this.difficulty,
    required this.question,
    required this.correctAnswer,
    required this.incorrectAnswers,
  });

  String category;
  String type;
  String difficulty;
  String question;
  String correctAnswer;
  List<String> incorrectAnswers;

  factory Question.fromJson(Map<String, dynamic> json) => Question(
    category: json["category"],
    type: json["type"],
    difficulty: json["difficulty"],
    question: json["question"],
    correctAnswer: json["correct_answer"],
    incorrectAnswers: List<String>.from(json["incorrect_answers"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "category": category,
    "type": type,
    "difficulty": difficulty,
    "question": question,
    "correct_answer": correctAnswer,
    "incorrect_answers": List<dynamic>.from(incorrectAnswers.map((x) => x)),
  };

  @override
  String toString() {
    return 'Question{category: $category, type: $type, difficulty: $difficulty, question: $question, correctAnswer: $correctAnswer, incorrectAnswers: $incorrectAnswers}';
  }
}