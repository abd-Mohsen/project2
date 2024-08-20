import 'package:project2/models/question_model.dart';

class MarkingSchemeModel {
  final int id;
  final String title;
  final List<QuestionModel> questions;

  MarkingSchemeModel({
    required this.id,
    required this.title,
    required this.questions,
  });

  factory MarkingSchemeModel.fromJson(Map<String, dynamic> json) => MarkingSchemeModel(
        id: json["id"],
        title: json["form_name"],
        questions: List<QuestionModel>.from(json["questions"].map((x) => QuestionModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "question": List<dynamic>.from(questions.map((x) => x.toJson())),
      };
}
