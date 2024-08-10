import 'dart:convert';

List<ExamModel> loginModelFromJson(String str) =>
    List<ExamModel>.from(json.decode(str).map((x) => ExamModel.fromJson(x)));

String loginModelToJson(List<ExamModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ExamModel {
  final int id;
  final String title;
  final List<MarkingSchemeModel> markingSchemes;

  ExamModel({
    required this.id,
    required this.title,
    required this.markingSchemes,
  });

  factory ExamModel.fromJson(Map<String, dynamic> json) => ExamModel(
        id: json["id"],
        title: json["title"],
        markingSchemes:
            List<MarkingSchemeModel>.from(json["marking_schemes"].map((x) => MarkingSchemeModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "marking_schemes": List<dynamic>.from(markingSchemes.map((x) => x.toJson())),
      };
}

class MarkingSchemeModel {
  final int id;
  final String title;
  final int size;
  final List<QuestionModel> questions;

  MarkingSchemeModel({
    required this.id,
    required this.title,
    required this.size,
    required this.questions,
  });

  factory MarkingSchemeModel.fromJson(Map<String, dynamic> json) => MarkingSchemeModel(
        id: json["id"],
        title: json["title"],
        size: json["size"],
        questions: List<QuestionModel>.from(json["question"].map((x) => QuestionModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "size": size,
        "question": List<dynamic>.from(questions.map((x) => x.toJson())),
      };
}

class QuestionModel {
  final int number;
  final String answer;

  QuestionModel({
    required this.number,
    required this.answer,
  });

  factory QuestionModel.fromJson(Map<String, dynamic> json) => QuestionModel(
        number: json["number"],
        answer: json["answer"],
      );

  Map<String, dynamic> toJson() => {
        "number": number,
        "answer": answer,
      };
}
