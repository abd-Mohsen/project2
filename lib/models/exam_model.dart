import 'dart:convert';

import 'package:project2/models/class_model.dart';
import 'package:project2/models/marking_scheme_model.dart';

List<ExamModel> examModelFromJson(String str) =>
    List<ExamModel>.from(json.decode(str).map((x) => ExamModel.fromJson(x)));

String examModelToJson(List<ExamModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ExamModel {
  final int id;
  final String title;
  final int completeMark;
  final int passMark;
  final int questionsCount;
  final ClassModel examClass;
  final List<MarkingSchemeModel> markingSchemes;

  ExamModel({
    required this.id,
    required this.title,
    required this.completeMark,
    required this.passMark,
    required this.questionsCount,
    required this.examClass,
    required this.markingSchemes,
  });

  factory ExamModel.fromJson(Map<String, dynamic> json) => ExamModel(
        id: json["id"],
        title: json["title"],
        completeMark: json["complete_mark"],
        passMark: json["pass_mark"],
        questionsCount: json["question_number"],
        examClass: ClassModel.fromJson(json["classes"]),
        markingSchemes: json["forms"] == null
            ? []
            : List<MarkingSchemeModel>.from(json["forms"].map((x) => MarkingSchemeModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "complete_mark": completeMark,
        "pass_mark": passMark,
        "question_number": questionsCount,
        "classes": examClass.toJson(),
        "forms": List<dynamic>.from(markingSchemes.map((x) => x.toJson())),
      };
}
