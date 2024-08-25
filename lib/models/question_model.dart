import 'dart:convert';

List<QuestionModel> questionModelFromJson(String str) =>
    List<QuestionModel>.from(json.decode(str).map((x) => QuestionModel.fromJson(x)));

String questionModelToJson(List<QuestionModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class QuestionModel {
  final int? id;
  final int number;
  String answer;

  QuestionModel({
    this.id,
    required this.number,
    required this.answer,
  });

  factory QuestionModel.fromJson(Map<String, dynamic> json) => QuestionModel(
        id: json["id"],
        number: json["question_id"],
        answer: json["answer"],
      );

  Map<String, dynamic> toJson() => {
        if (id != null) "id": id,
        "question_id": number,
        "answer": answer,
      };

  @override
  String toString() {
    return "{$number,$answer}";
  }
}
